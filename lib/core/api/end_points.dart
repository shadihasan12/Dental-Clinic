import 'package:dental_clinic_app/core/config/app_config.dart';

/// Base endpoints class
/// Note: For better organization and to avoid merge conflicts,
/// create feature-specific endpoint classes in each feature's data/endpoints folder
/// Example: lib/features/appointments/data/endpoints/appointments_endpoints.dart
class Endpoints {
  Endpoints._();

  static String get baseUrl => AppConfig.baseUrl;

  // Core/shared endpoints can be added here
  // For feature-specific endpoints, create per-feature endpoint files
}
