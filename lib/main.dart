import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dental_clinic_app/bloc_observer.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/routes_manager.dart';
import 'package:dental_clinic_app/core/resources/theme_manager.dart';
import 'package:dental_clinic_app/core/constants/app_constants.dart';
import 'package:dental_clinic_app/core/services/notifications/fcm_background_handler.dart';
import 'package:dental_clinic_app/core/services/notifications/firebase_options.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_poller.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_routing.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_topics_synchronizer.dart';
import 'package:dental_clinic_app/features/home/presentation/manager/unread_count_cubit.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/localization/language_bloc.dart';
import 'package:dental_clinic_app/core/theme/theme_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/currency/currency_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    // .env file not found, continue without it
    if (kDebugMode) {
      print(
        'Warning: .env file not found. Continuing with default configuration.',
      );
    }
  }

  // System UI overlay style is handled by the theme's appBarTheme.systemOverlayStyle
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorManager.transparent,
      systemNavigationBarColor: ColorManager.transparent,
    ),
  );

  // Enable edge-to-edge mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Firebase — needed before the DI container resolves any FCM-touching
  // singletons. The background handler must be registered on the platform
  // channel BEFORE the app goes to background so the message isn't dropped.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // firebase_core runs on Windows, but firebase_messaging does not ship a
  // Windows plugin - calling into it there throws MissingPluginException at
  // startup. Desktop gets its notifications over a different transport.
  if (NotificationService.supportsPush) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  // Configure dependencies
  await configureDependencies();

  // Notification service: requests permission, wires FCM listeners, registers
  // the device token. Fire-and-forget so we don't block first frame on a
  // network round-trip; failures will retry on the next sign-in.
  unawaited(() async {
    // The poller waits for initialize(): it announces through the local
    // notifications plugin, which is set up in there. A no-op on every
    // platform that receives real pushes.
    try {
      await getIt<NotificationService>().initialize();
    } catch (e) {
      // A failure in here is almost always the FCM half, which Windows does
      // not use anyway. Start the poller regardless - individual show() calls
      // are already guarded - rather than leave desktop with no delivery at
      // all because an unrelated subsystem failed.
      if (kDebugMode) debugPrint('[notifications] initialize failed: $e');
    }
    getIt<NotificationPoller>().start();
  }());

  // Both of these need a session. On a cold start with one already in storage
  // nothing else re-asserts them:
  //   * the server-named topic subscriptions (subscribeToTopic is idempotent,
  //     and re-running it repairs one that failed silently earlier),
  //   * the badge count.
  if (getIt<TokenStorage>().hasToken()) {
    unawaited(getIt<NotificationTopicsSynchronizer>().sync());
    unawaited(getIt<UnreadCountCubit>().refresh());
  }

  // Set up BLoC observer for debugging
  Bloc.observer = const AppBlocObserver();

  runApp(const DentalClinicApp());
}

class DentalClinicApp extends StatefulWidget {
  const DentalClinicApp({super.key});

  @override
  State<DentalClinicApp> createState() => _DentalClinicAppState();
}

class _DentalClinicAppState extends State<DentalClinicApp>
    with WidgetsBindingObserver {
  final RoutesManager routesManager = RoutesManager(getIt<TokenStorage>());
  StreamSubscription<void>? _notificationTapSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getIt<LanguageBloc>().add(const LoadLanguageEvent());
    getIt<ThemeBloc>().add(const LoadThemeEvent());

    // Deep-link push taps to the notifications screen. We use the GoRouter
    // instance directly (rather than `context.go`) because taps may fire
    // before any subtree has mounted (cold-start from a tapped push).
    _notificationTapSubscription =
        getIt<NotificationService>().onNotificationTap.listen((data) {
      if (!getIt<TokenStorage>().hasToken()) return;

      // Tapping several notifications in a row should not stack duplicates.
      final current =
          routesManager.router.routerDelegate.currentConfiguration.uri.path;
      if (current == NotificationRouting.locationFor(data)) return;

      // The destination comes from `data['type']`, and an unknown type lands
      // safely on the inbox rather than throwing.
      NotificationRouting.navigate(routesManager.router, data);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _notificationTapSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    if (!getIt<TokenStorage>().hasToken()) return;

    // Notifications may have been read on another device, or arrived while we
    // were backgrounded. Nothing else refreshes the badge on the way back in.
    unawaited(getIt<UnreadCountCubit>().refresh());
    // Windows only: the poller can be idle here if it was stopped, and start()
    // polls immediately so anything that landed while we were away surfaces
    // now rather than one interval later.
    getIt<NotificationPoller>().start();
  }

  void _bindPollerStrings(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;
    final poller = getIt<NotificationPoller>();
    poller.summaryTitle = l10n.newNotificationsTitle;
    poller.summaryBodyBuilder = l10n.moreNotifications;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>(
          create: (_) => getIt<LanguageBloc>()..add(const LoadLanguageEvent()),
        ),
        BlocProvider<ThemeBloc>(
          create: (_) => getIt<ThemeBloc>()..add(const LoadThemeEvent()),
        ),
        BlocProvider<CurrencyBloc>(
          lazy: false,
          create: (_) => getIt<CurrencyBloc>()..add(const CurrencyEvent.load()),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        bloc: getIt<LanguageBloc>(),
        builder: (context, languageState) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            bloc: getIt<ThemeBloc>(),
            builder: (context, themeState) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  // ScreenUtil scales every .w/.h/.sp by screen ÷ design size,
                  // and it keeps that ratio in one global singleton. On
                  // desktop the design size IS the window, so the ratio is 1
                  // and the desktop layouts render at the sizes they are
                  // written in.
                  //
                  // Deciding it here, at the only ScreenUtilInit in the app,
                  // is what makes it reliable: the shells used to re-configure
                  // the singleton themselves, and any rebuild that landed
                  // between the root's write and theirs painted at the phone
                  // ratio - which on a 1900px window is text at 5x. One writer,
                  // no race.
                  final isDesktop =
                      constraints.hasBoundedWidth &&
                      constraints.maxWidth >= Responsive.desktopBreakpoint;

                  return ScreenUtilInit(
                    designSize: isDesktop
                        ? constraints.biggest
                        : const Size(375, 812),
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: (context, child) {
                      return MaterialApp.router(
                        title: AppConstants.appName,
                        debugShowCheckedModeBanner: false,
                        theme: getApplicationThemeData(),
                        darkTheme: getDarkThemeData(),
                        themeMode: themeState.themeMode,
                        locale: languageState.locale,
                        localizationsDelegates: const [
                          AppLocalizations.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                        ],
                        supportedLocales: const [Locale('en'), Locale('ar')],
                        routerConfig: routesManager.router,
                        builder: (context, child) {
                          // The Windows poller raises banners from outside the
                          // widget tree, so it has no BuildContext of its own.
                          // Hand it the localised summary copy from here, where
                          // AppLocalizations is resolved and re-resolved whenever
                          // the locale changes.
                          _bindPollerStrings(context);

                          // ScreenUtil already scales every .sp by the device's
                          // width ratio; the OS font-size setting then multiplies
                          // on top of that, so a device set above default compounds
                          // twice and the whole UI reads oversized. Clamp the upper
                          // end while still honouring users who need larger text.
                          final mq = MediaQuery.of(context);
                          return MediaQuery(
                            data: mq.copyWith(
                              textScaler: mq.textScaler.clamp(
                                minScaleFactor: 1.0,
                                maxScaleFactor: 1.2,
                              ),
                            ),
                            child: child ?? const SizedBox.shrink(),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
