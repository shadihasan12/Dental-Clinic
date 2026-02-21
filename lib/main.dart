import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/bloc_observer.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/routes_manager.dart';
import 'package:dental_clinic_app/core/resources/theme_manager.dart';
import 'package:dental_clinic_app/core/constants/app_constants.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/injection.dart';

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

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorManager.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: ColorManager.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Enable edge-to-edge mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Configure dependencies
  await configureDependencies();

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

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: getApplicationThemeData(),
          routerConfig: routesManager.router,
        );
      },
    );
  }
}
