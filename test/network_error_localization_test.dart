import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

/// Error text reaches the user in the user's language. The regression this
/// pins is a real one: the home screen rendered its failure through the
/// context-free [NetworkExceptions.getErrorMessage], so an Arabic clinic got
/// an English "Connection request timeout" inside an Arabic error card.
void main() {
  Future<String> render(
    WidgetTester tester,
    NetworkExceptions exception, {
    required Locale locale,
  }) async {
    late String message;
    await tester.pumpWidget(
      MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        home: Builder(
          builder: (context) {
            message = NetworkExceptions.localizedMessage(context, exception);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    return message;
  }

  testWidgets('a fixed client-side failure is translated', (tester) async {
    const timeout = NetworkExceptions.requestTimeout();

    expect(
      await render(tester, timeout, locale: const Locale('en')),
      'The connection timed out',
    );
    expect(
      await render(tester, timeout, locale: const Locale('ar')),
      'انتهت مهلة الاتصال',
    );
  });

  testWidgets('the server\'s own words are passed through untouched', (
    tester,
  ) async {
    // The API is the only thing that knows what this says; swapping it for a
    // generic local string would throw away the specifics.
    const fromServer = NetworkExceptions.unprocessableEntity('الاسم مطلوب');

    expect(
      await render(tester, fromServer, locale: const Locale('en')),
      'الاسم مطلوب',
    );
  });

  testWidgets('every case resolves in both languages', (tester) async {
    const cases = <NetworkExceptions>[
      NetworkExceptions.notImplemented(),
      NetworkExceptions.requestCancelled(),
      NetworkExceptions.internalServerError(),
      NetworkExceptions.serviceUnavailable(),
      NetworkExceptions.methodNotAllowed(),
      NetworkExceptions.unexpectedError(),
      NetworkExceptions.requestTimeout(),
      NetworkExceptions.noInternetConnection(),
      NetworkExceptions.conflict(),
      NetworkExceptions.sendTimeout(),
      NetworkExceptions.unableToProcess(),
      NetworkExceptions.formatException(),
      NetworkExceptions.notAcceptable(),
      NetworkExceptions.canceledByUser(),
    ];

    for (final locale in const [Locale('en'), Locale('ar')]) {
      for (final exception in cases) {
        expect(
          await render(tester, exception, locale: locale),
          isNotEmpty,
          reason: '$exception has no text in $locale',
        );
      }
    }
  });
}
