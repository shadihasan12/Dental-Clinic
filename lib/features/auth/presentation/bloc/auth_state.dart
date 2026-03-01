part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    // Login fields
    @Default('') String loginEmail,
    @Default('') String loginPassword,
    @Default(false) bool isLoginPasswordVisible,
    @Default(false) bool isLoginLoading,
    @Default(null) String? loginError,

    // Signup fields - Unified (all users are dental professionals)
    @Default('') String signupName,
    @Default('') String signupEmail,
    @Default('') String signupPassword,
    @Default('') String signupConfirmPassword,
    @Default(false) bool isSignupPasswordVisible,
    @Default(false) bool isSignupConfirmPasswordVisible,
    @Default(false) bool isSignupLoading,
    @Default(null) String? signupError,
    // Optional professional fields
    @Default('') String signupLicenseNumber,
    @Default('') String signupSpecialization,
    @Default('') String signupLocation,

    // API fetched data
    @Default([]) List<SpecialtyEntity> specialties,
    @Default([]) List<LocationEntity> searchedLocations,
    @Default([]) List<PlanEntity> plans,

    // API loading states
    @Default(false) bool isLoadingSpecialties,
    @Default(false) bool isLoadingPlans,
    @Default(false) bool isSearchingLocations,

    // Selected entities for registration
    @Default(null) SpecialtyEntity? selectedSpecialty,
    @Default(null) LocationEntity? selectedLocation,
    @Default(null) PlanEntity? selectedPlan,

    // Clinic information for registration
    @Default('') String clinicName,
    @Default('') String clinicAddress,
    @Default('') String mobileNumber,

    // OTP verification fields
    @Default('') String otpCode,
    @Default(false) bool isOtpLoading,
    @Default(false) bool isOtpVerifying,
    @Default(null) String? otpError,
    @Default(null) String? sessionId,
    @Default(0) int otpSecondsRemaining,
    @Default(false) bool canResendOtp,

    // Forgot password fields
    @Default('') String forgotPasswordEmail,
    @Default(false) bool isForgotPasswordLoading,
    @Default(false) bool isForgotPasswordSuccess,
    @Default(null) String? forgotPasswordError,

    // Authenticated user data
    @Default(null) UserEntity? currentUser,
    @Default([]) List<ClinicMembershipEntity> memberships,
    @Default([]) List<InvitationEntity> pendingInvitations,
    @Default(null) String? activeClinicId,

    // Auth status
    @Default(AuthStatus.unauthenticated) AuthStatus status,
  }) = _AuthState;
}

enum AuthStatus {
  authenticated,
  unauthenticated,
  loading,
}

// Validation helpers
extension AuthStateValidation on AuthState {
  bool get isLoginEmailValid =>
      _isValidEmail(loginEmail) || _isValidPhone(loginEmail);
  bool get isLoginPasswordValid => loginPassword.length >= 6;
  bool get isLoginFormValid => isLoginEmailValid && isLoginPasswordValid;

  bool get isSignupNameValid => signupName.length >= 2;
  bool get isSignupEmailValid => _isValidEmail(signupEmail);
  bool get isSignupPasswordValid => signupPassword.length >= 6;
  bool get isSignupConfirmPasswordValid =>
      signupConfirmPassword == signupPassword && signupConfirmPassword.isNotEmpty;

  bool get isSignupFormValid =>
      isSignupNameValid &&
      isSignupEmailValid &&
      isSignupPasswordValid &&
      isSignupConfirmPasswordValid;

  bool get isForgotPasswordEmailValid => _isValidEmail(forgotPasswordEmail);

  // Get the current user's role in the active clinic
  ClinicRole? get activeClinicRole {
    if (activeClinicId == null) return null;
    final membership = memberships.where((m) => m.clinicId == activeClinicId).firstOrNull;
    return membership?.role;
  }

  // Check if user is admin of active clinic
  bool get isActiveClinicAdmin => activeClinicRole == ClinicRole.admin;

  // Check if user has any clinic memberships
  bool get hasClinicMemberships => memberships.isNotEmpty;

  // Check if user owns a clinic (is admin of any clinic)
  bool get ownsClinic => memberships.any((m) => m.role == ClinicRole.admin);

  // Get owned clinic (first one where user is admin)
  ClinicMembershipEntity? get ownedClinicMembership =>
      memberships.where((m) => m.role == ClinicRole.admin).firstOrNull;

  // Get active clinic membership
  ClinicMembershipEntity? get activeClinicMembership {
    if (activeClinicId == null) return null;
    return memberships.where((m) => m.clinicId == activeClinicId).firstOrNull;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\+?[0-9]{7,15}$').hasMatch(phone.trim());
  }
}
