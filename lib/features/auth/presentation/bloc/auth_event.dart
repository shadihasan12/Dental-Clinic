part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  // Login events
  const factory AuthEvent.loginEmailChanged(String email) = _LoginEmailChanged;
  const factory AuthEvent.loginPasswordChanged(String password) = _LoginPasswordChanged;
  const factory AuthEvent.loginPasswordVisibilityToggled() = _LoginPasswordVisibilityToggled;
  const factory AuthEvent.loginSubmitted() = _LoginSubmitted;

  // Signup events - Unified for all dental professionals
  const factory AuthEvent.signupNameChanged(String name) = _SignupNameChanged;
  const factory AuthEvent.signupEmailChanged(String email) = _SignupEmailChanged;
  const factory AuthEvent.signupPasswordChanged(String password) = _SignupPasswordChanged;
  const factory AuthEvent.signupConfirmPasswordChanged(String confirmPassword) = _SignupConfirmPasswordChanged;
  const factory AuthEvent.signupPasswordVisibilityToggled() = _SignupPasswordVisibilityToggled;
  const factory AuthEvent.signupConfirmPasswordVisibilityToggled() = _SignupConfirmPasswordVisibilityToggled;
  const factory AuthEvent.signupSubmitted() = _SignupSubmitted;
  const factory AuthEvent.signupFormReset() = _SignupFormReset;

  // Optional professional fields
  const factory AuthEvent.signupLicenseNumberChanged(String licenseNumber) = _SignupLicenseNumberChanged;
  const factory AuthEvent.signupSpecializationChanged(String specialization) = _SignupSpecializationChanged;
  const factory AuthEvent.signupLocationChanged(String location) = _SignupLocationChanged;

  // API data fetching events
  const factory AuthEvent.specialtiesRequested() = _SpecialtiesRequested;
  const factory AuthEvent.plansRequested() = _PlansRequested;
  const factory AuthEvent.locationSearchRequested({
    required String query,
    required String countryCode,
  }) = _LocationSearchRequested;

  // Selection events (with entities)
  const factory AuthEvent.signupSpecialtyEntitySelected(SpecialtyEntity specialty) = _SignupSpecialtyEntitySelected;
  const factory AuthEvent.signupLocationEntitySelected(LocationEntity location) = _SignupLocationEntitySelected;
  const factory AuthEvent.signupPlanEntitySelected(PlanEntity plan) = _SignupPlanEntitySelected;

  // Clinic information events
  const factory AuthEvent.signupClinicNameChanged(String name) = _SignupClinicNameChanged;
  const factory AuthEvent.signupClinicAddressChanged(String address) = _SignupClinicAddressChanged;
  const factory AuthEvent.signupMobileNumberChanged(String mobile) = _SignupMobileNumberChanged;

  // Forgot password events
  const factory AuthEvent.forgotPasswordEmailChanged(String email) = _ForgotPasswordEmailChanged;
  const factory AuthEvent.forgotPasswordSubmitted() = _ForgotPasswordSubmitted;
  const factory AuthEvent.forgotPasswordReset() = _ForgotPasswordReset;

  // Clinic context switching
  const factory AuthEvent.activeClinicChanged(String? clinicId) = _ActiveClinicChanged;

  // Auth restoration
  const factory AuthEvent.authCheckRequested() = _AuthCheckRequested;

  // Logout
  const factory AuthEvent.logoutRequested() = _LogoutRequested;
}
