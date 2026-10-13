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
    @Default('') String signupFirstName,
    @Default('') String signupLastName,
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

    /// Required by /auth/register. A label only - nothing branches on it.
    @Default(null) ClinicType? clinicType,
    @Default('') String clinicAddress,
    @Default('') String mobileNumber,

    // OTP verification fields
    @Default('') String otpCode,
    @Default(false) bool isOtpLoading,
    @Default(false) bool isOtpVerifying,
    @Default(null) String? otpError,
    @Default(null) String? sessionId,

    /// The server refused to register because the OTP session behind
    /// [sessionId] has run out. Nothing on the create-account page can fix
    /// that - the email has to be verified again - so the page reacts by
    /// sending the user back to the start rather than showing an error they
    /// cannot act on.
    @Default(false) bool signupSessionExpired,
    @Default(0) int otpSecondsRemaining,

    /// Goes up every time a wait begins: a code went out, or the server
    /// said how long to wait before asking again. The code screens restart
    /// their countdown on it - the seconds alone can be the same twice in a
    /// row (300, then 300), which is no change to listen for.
    @Default(0) int otpWaitTick,

    /// Wrong answers given to the code now in hand. The server ends a code
    /// at the fifth; see [AuthStateValidation.isOtpCodeSpent].
    @Default(0) int otpFailedAttempts,
    @Default(false) bool canResendOtp,

    // Forgot password fields
    @Default('') String forgotPasswordEmail,
    /// The reset flow was opened from inside the app to change the password
    /// of the signed-in account, not from the login screen.
    @Default(false) bool isSignedInPasswordChange,
    @Default(false) bool isForgotPasswordLoading,
    @Default(false) bool isForgotPasswordSuccess,
    @Default(null) String? forgotPasswordError,

    // Reset password fields
    @Default('') String resetPasswordNew,
    @Default('') String resetPasswordConfirm,
    @Default(false) bool isResetPasswordVisible,
    @Default(false) bool isResetPasswordConfirmVisible,
    @Default(false) bool isResetPasswordLoading,
    @Default(false) bool isResetPasswordSuccess,
    @Default(null) String? resetPasswordError,
    @Default(null) String? resetPasswordSessionId,

    /// The server refused the reset because the session behind
    /// [resetPasswordSessionId] is used up or has run out. As at sign-up,
    /// only a new code can fix that, so the page sends the user back for
    /// one.
    @Default(false) bool resetSessionExpired,

    // Authenticated user data
    @Default(null) UserEntity? currentUser,
    @Default([]) List<ClinicMembershipEntity> memberships,
    @Default([]) List<InvitationEntity> pendingInvitations,
    @Default(null) String? activeClinicId,

    // Auth status
    @Default(AuthStatus.unauthenticated) AuthStatus status,

    // Email verification from login flow
    @Default(false) bool needsEmailVerification,
    @Default(false) bool emailVerificationForLogin,
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
  // The password in use is only compared, never judged: an account older
  // than the rules for a new one still signs in with what it has.
  bool get isLoginPasswordValid => loginPassword.isNotEmpty;
  bool get isLoginFormValid => isLoginEmailValid && isLoginPasswordValid;

  bool get isSignupFirstNameValid => signupFirstName.length >= 2;
  bool get isSignupLastNameValid => signupLastName.length >= 2;
  bool get isSignupEmailValid => _isValidEmail(signupEmail);
  bool get isSignupPasswordValid => PasswordRules.isValid(signupPassword);
  bool get isSignupConfirmPasswordValid =>
      signupConfirmPassword == signupPassword && signupConfirmPassword.isNotEmpty;

  bool get isSignupFormValid =>
      isSignupFirstNameValid &&
      isSignupLastNameValid &&
      isSignupEmailValid &&
      isSignupPasswordValid &&
      isSignupConfirmPasswordValid;

  bool get isForgotPasswordEmailValid => _isValidEmail(forgotPasswordEmail);

  bool get isResetPasswordValid => PasswordRules.isValid(resetPasswordNew);
  bool get isResetPasswordConfirmValid =>
      resetPasswordConfirm == resetPasswordNew && resetPasswordConfirm.isNotEmpty;
  bool get isResetPasswordFormValid => isResetPasswordValid && isResetPasswordConfirmValid;

  /// Five wrong answers end a code, and from then on the server refuses
  /// even the right one. A new code can be asked for at once.
  bool get isOtpCodeSpent => otpFailedAttempts >= 5;

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

  bool _isValidEmail(String email) => EmailAddress.isValid(email);

  bool _isValidPhone(String phone) => MobileNumber.isValid(phone);
}
