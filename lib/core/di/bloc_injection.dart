import 'package:injectable/injectable.dart';

/// Dependency injection module for BLoCs and Cubits
/// Add your feature BLoCs here as you create them
///
/// Example:
/// ```dart
/// @singleton
/// AppointmentsBloc appointmentsBloc(
///   GetAppointmentsUseCase getAppointmentsUseCase,
/// ) => AppointmentsBloc(getAppointmentsUseCase);
/// ```
@module
abstract class BlocInjection {
  // Add your BLoC registrations here
}
