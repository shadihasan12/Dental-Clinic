import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/theme_manager.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/invoice_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/quote_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/quote_sheet.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// The sheet only asks the repository one thing itself: whether an invoice
/// is open, after a 409.
class _Invoices implements BillingRepository {
  List<InvoiceEntity> invoices = const [];

  @override
  Future<Either<NetworkExceptions, List<InvoiceEntity>>> getInvoices() async =>
      Right(invoices);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// The purchase sheet after a refusal. A 409 with no open invoice behind it
/// means what was priced no longer holds: the sheet prices it again, shows
/// the new figures under the server's sentence, and its button follows the
/// new quote.
void main() {
  const changed = 'Your subscription changed while the price was worked out.';
  const confirm = 'Issue the invoice';

  late _Invoices repository;
  QuoteSheetResult? result;

  setUp(() {
    repository = _Invoices();
    getIt.registerSingleton<BillingRepository>(repository);
    result = null;
  });

  tearDown(getIt.reset);

  QuoteEntity quote({
    double usd = 23.97,
    String kind = 'renewal',
    bool canRequest = true,
    String? reason,
    bool startsLater = false,
  }) => QuoteEntity(
    kind: kind,
    canRequest: canRequest,
    reason: reason,
    planName: 'Basic',
    planVersionId: 'version-1',
    billingPeriod: BillingPeriod.monthly,
    durationQuantity: 1,
    isCredit: false,
    amountUsd: usd,
    amounts: const [],
    lines: [
      BillingLineEntity(
        kind: 'PLAN',
        description: 'Basic (Monthly) x 1',
        quantity: 1,
        unitPriceUsd: usd,
        amountUsd: usd,
      ),
    ],
    periodStart: DateTime(2026, 11, 15),
    periodEnd: DateTime(2026, 12, 15),
    startsLater: startsLater,
  );

  InvoiceEntity openInvoice() => const InvoiceEntity(
    id: 'invoice-1',
    number: 'INV-000001',
    purpose: 'SUBSCRIPTION_RENEW',
    status: InvoiceStatus.open,
    isCreditNote: false,
    amountUsd: 23.97,
    amountPaidUsd: 0,
    remainingUsd: 23.97,
    amounts: [],
    items: [],
  );

  /// Opens the sheet over a phone-sized page, answering each quote and each
  /// request with the next entry of [quotes] and [requests].
  Future<({int Function() quoted, int Function() requested})> open(
    WidgetTester tester, {
    required List<Either<NetworkExceptions, QuoteEntity>> quotes,
    List<FutureOr<Either<NetworkExceptions, BillingRequestResult>>> requests =
        const [],
    VoidCallback? onRefused,
  }) async {
    tester.view.physicalSize = const Size(375 * 3, 812 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    var quoted = 0;
    var requested = 0;
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, _) => MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('ar')],
          theme: getApplicationThemeData(),
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () async {
                  result = await showQuoteSheet(
                    context,
                    quote: () async => quotes[quoted++],
                    request: () async => requests[requested++],
                    onRefused: onRefused,
                  );
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    return (quoted: () => quoted, requested: () => requested);
  }

  Finder confirmButton() => find.widgetWithText(ElevatedButton, confirm);

  testWidgets('a 409 with no invoice open is priced again, to be asked for '
      'once more', (tester) async {
    var refused = 0;
    final calls = await open(
      tester,
      quotes: [Right(quote(usd: 23.97)), Right(quote(usd: 31.96))],
      requests: [
        const Left(NetworkExceptions.conflict(changed)),
        const Right(BillingRequestResult(message: 'Invoice raised.')),
      ],
      onRefused: () => refused++,
    );
    expect(find.text(r'$23.97'), findsWidgets);

    await tester.tap(confirmButton());
    await tester.pumpAndSettle();

    // The new figures, the server's sentence, and the button back.
    expect(calls.quoted(), 2);
    expect(refused, 1);
    expect(find.text(changed), findsOneWidget);
    expect(find.text(r'$31.96'), findsWidgets);
    expect(find.text(r'$23.97'), findsNothing);
    expect(tester.widget<ElevatedButton>(confirmButton()).onPressed, isNotNull);

    await tester.tap(confirmButton());
    await tester.pumpAndSettle();

    expect(calls.requested(), 2);
    expect(result?.outcome?.message, 'Invoice raised.');
  });

  testWidgets('the button follows the new quote: no asking again when it '
      'says no', (tester) async {
    const reason = 'This allows 2 members, and the clinic has 3.';
    await open(
      tester,
      quotes: [
        Right(quote()),
        Right(quote(canRequest: false, reason: reason)),
      ],
      requests: [const Left(NetworkExceptions.conflict(reason))],
    );

    await tester.tap(confirmButton());
    await tester.pumpAndSettle();

    expect(find.text(reason), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNothing);
  });

  testWidgets('a 409 behind which an invoice is open leads to that invoice, '
      'and prices nothing again', (tester) async {
    repository.invoices = [openInvoice()];
    var refused = 0;
    final calls = await open(
      tester,
      quotes: [Right(quote())],
      requests: [const Left(NetworkExceptions.conflict('INV-000001 is open.'))],
      onRefused: () => refused++,
    );

    await tester.tap(confirmButton());
    await tester.pumpAndSettle();

    expect(calls.quoted(), 1);
    expect(refused, 0);
    expect(find.text('INV-000001 is open.'), findsOneWidget);

    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Open invoice INV-000001'),
    );
    await tester.pumpAndSettle();
    expect(result?.openInvoice?.id, 'invoice-1');
  });

  testWidgets('when it cannot be priced again, the refusal stays and nothing '
      'more is asked for', (tester) async {
    await open(
      tester,
      quotes: [
        Right(quote()),
        const Left(NetworkExceptions.notFound('Not on sale.')),
      ],
      requests: [const Left(NetworkExceptions.conflict(changed))],
    );

    await tester.tap(confirmButton());
    await tester.pumpAndSettle();

    expect(find.text(changed), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNothing);
  });

  testWidgets('a failure that is not a 409 is shown as before, and prices '
      'nothing again', (tester) async {
    var refused = 0;
    final calls = await open(
      tester,
      quotes: [Right(quote())],
      requests: [const Left(NetworkExceptions.noInternetConnection())],
      onRefused: () => refused++,
    );

    await tester.tap(confirmButton());
    await tester.pumpAndSettle();

    expect(calls.quoted(), 1);
    expect(refused, 0);
    expect(find.text('No internet connection'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNothing);
  });

  testWidgets('a 404 - no longer on sale - tells the page to read its list '
      'again', (tester) async {
    var refused = 0;
    final calls = await open(
      tester,
      quotes: [Right(quote(kind: 'addon'))],
      requests: [const Left(NetworkExceptions.notFound('Not on sale.'))],
      onRefused: () => refused++,
    );

    await tester.tap(confirmButton());
    await tester.pumpAndSettle();

    expect(calls.quoted(), 1);
    expect(refused, 1);
    expect(find.text('Not on sale.'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNothing);
  });

  testWidgets('a second tap while the first request is on its way sends '
      'nothing', (tester) async {
    final answer = Completer<Either<NetworkExceptions, BillingRequestResult>>();
    final calls = await open(
      tester,
      quotes: [Right(quote())],
      requests: [answer.future],
    );

    // Both taps land before the button has redrawn as busy.
    await tester.tap(confirmButton());
    await tester.tap(confirmButton());
    await tester.pump();
    expect(calls.requested(), 1);
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
        isNull);

    answer.complete(const Right(BillingRequestResult(message: 'Invoice raised.')));
    await tester.pumpAndSettle();
    expect(calls.requested(), 1);
  });

  group('when the cycle is said to start', () {
    const onPaymentDay = 'It starts on the day payment is confirmed.';

    testWidgets('a new subscription starts on the day it is paid',
        (tester) async {
      await open(tester, quotes: [Right(quote(kind: 'new'))]);

      expect(find.textContaining(onPaymentDay), findsOneWidget);
    });

    testWidgets('a renewal after the cycle ended is given its dates, and no '
        'start on the payment day', (tester) async {
      await open(tester, quotes: [Right(quote(kind: 'renewal'))]);

      expect(
        find.text('If paid today, it runs from Nov 15, 2026 to Dec 15, 2026.'),
        findsOneWidget,
      );
      expect(find.textContaining(onPaymentDay), findsNothing);
    });

    testWidgets('a renewal bought while the cycle runs follows that cycle',
        (tester) async {
      await open(
        tester,
        quotes: [Right(quote(kind: 'renewal', startsLater: true))],
      );

      expect(
        find.textContaining('straight after your current cycle'),
        findsOneWidget,
      );
      expect(find.textContaining(onPaymentDay), findsNothing);
    });
  });
}
