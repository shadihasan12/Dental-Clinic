import 'dart:async';

import 'package:flutter/foundation.dart';
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
import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
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
  unawaited(getIt<NotificationService>().initialize());

  // Set up BLoC observer for debugging
  Bloc.observer = const AppBlocObserver();

  runApp(const DentalClinicApp());
}

class DentalClinicApp extends StatefulWidget {
  const DentalClinicApp({super.key});

  @override
  State<DentalClinicApp> createState() => _DentalClinicAppState();
}

class _DentalClinicAppState extends State<DentalClinicApp> {
  final RoutesManager routesManager = RoutesManager(getIt<TokenStorage>());
  StreamSubscription<void>? _notificationTapSubscription;

  @override
  void initState() {
    super.initState();
    getIt<LanguageBloc>().add(const LoadLanguageEvent());
    getIt<ThemeBloc>().add(const LoadThemeEvent());

    // Deep-link push taps to the notifications screen. We use the GoRouter
    // instance directly (rather than `context.go`) because taps may fire
    // before any subtree has mounted (cold-start from a tapped push).
    _notificationTapSubscription =
        getIt<NotificationService>().onNotificationTap.listen((payload) {
      routesManager.router.go(payload.deepLink);
    });
  }

  @override
  void dispose() {
    _notificationTapSubscription?.cancel();
    super.dispose();
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
              return ScreenUtilInit(
                designSize: const Size(375, 812),
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
