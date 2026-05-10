import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/user_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/specialty_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/location_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;
  final UserStorage _userStorage;

  AuthBloc(this._authRepository, this._tokenStorage, this._userStorage) : super(const AuthState()) {
    // Login events
    on<_LoginEmailChanged>(_onLoginEmailChanged);
    on<_LoginPasswordChanged>(_onLoginPasswordChanged);
    on<_LoginPasswordVisibilityToggled>(_onLoginPasswordVisibilityToggled);
    on<_LoginSubmitted>(_onLoginSubmitted);

    // Signup events - Unified
    on<_SignupFirstNameChanged>(_onSignupFirstNameChanged);
    on<_SignupLastNameChanged>(_onSignupLastNameChanged);
    on<_SignupEmailChanged>(_onSignupEmailChanged);
    on<_SignupPasswordChanged>(_onSignupPasswordChanged);
    on<_SignupConfirmPasswordChanged>(_onSignupConfirmPasswordChanged);
    on<_SignupPasswordVisibilityToggled>(_onSignupPasswordVisibilityToggled);
    on<_SignupConfirmPasswordVisibilityToggled>(_onSignupConfirmPasswordVisibilityToggled);
    on<_SignupSubmitted>(_onSignupSubmitted);
    on<_SignupFormReset>(_onSignupFormReset);

    // Optional professional fields
    on<_SignupLicenseNumberChanged>(_onSignupLicenseNumberChanged);
    on<_SignupSpecializationChanged>(_onSignupSpecializationChanged);
    on<_SignupLocationChanged>(_onSignupLocationChanged);

    // API data fetching events
    on<_SpecialtiesRequested>(_onSpecialtiesRequested);
    on<_PlansRequested>(_onPlansRequested);
    on<_LocationSearchRequested>(_onLocationSearchRequested);

    // Selection events
    on<_SignupSpecialtyEntitySelected>(_onSignupSpecialtyEntitySelected);
    on<_SignupLocationEntitySelected>(_onSignupLocationEntitySelected);
    on<_SignupPlanEntitySelected>(_onSignupPlanEntitySelected);

    // Clinic info events
    on<_SignupClinicNameChanged>(_onSignupClinicNameChanged);
    on<_SignupClinicAddressChanged>(_onSignupClinicAddressChanged);
    on<_SignupMobileNumberChanged>(_onSignupMobileNumberChanged);

    // OTP events
    on<_OtpRequested>(_onOtpRequested);
    on<_OtpCodeChanged>(_onOtpCodeChanged);
    on<_OtpVerified>(_onOtpVerified);
    on<_OtpResendRequested>(_onOtpResendRequested);

    // Forgot password events
    on<_ForgotPasswordEmailChanged>(_onForgotPasswordEmailChanged);
    on<_ForgotPasswordSubmitted>(_onForgotPasswordSubmitted);
    on<_ForgotPasswordReset>(_onForgotPasswordReset);

    // Reset password events
    on<_ResetPasswordOtpRequested>(_onResetPasswordOtpRequested);
    on<_ResetPasswordOtpVerified>(_onResetPasswordOtpVerified);
    on<_ResetPasswordOtpResendRequested>(_onResetPasswordOtpResendRequested);
    on<_ResetPasswordNewChanged>(_onResetPasswordNewChanged);
    on<_ResetPasswordConfirmChanged>(_onResetPasswordConfirmChanged);
    on<_ResetPasswordVisibilityToggled>(_onResetPasswordVisibilityToggled);
    on<_ResetPasswordConfirmVisibilityToggled>(_onResetPasswordConfirmVisibilityToggled);
    on<_ResetPasswordSubmitted>(_onResetPasswordSubmitted);

    // Clinic context
    on<_ActiveClinicChanged>(_onActiveClinicChanged);

    // Auth check
    on<_AuthCheckRequested>(_onAuthCheckRequested);

    // Logout
    on<_LogoutRequested>(_onLogoutRequested);

    // Email verification from login flow
    on<_VerifyEmailOtpRequested>(_onVerifyEmailOtpRequested);
    on<_EmailVerificationCompleted>(_onEmailVerificationCompleted);
    on<_EmailVerificationCancelled>(_onEmailVerificationCancelled);
  }

  // Login handlers
  void _onLoginEmailChanged(_LoginEmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      loginEmail: event.email,
      loginError: null,
    ));
  }

  void _onLoginPasswordChanged(_LoginPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      loginPassword: event.password,
      loginError: null,
    ));
  }

  void _onLoginPasswordVisibilityToggled(
    _LoginPasswordVisibilityToggled event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      isLoginPasswordVisible: !state.isLoginPasswordVisible,
    ));
  }

  /// Picks the membership we treat as "active" right after auth — admin
  /// clinic if the user has one, otherwise the first membership.
  ClinicMembershipEntity? _pickActiveMembership(
    List<ClinicMembershipEntity> memberships,
  ) {
    if (memberships.isEmpty) return null;
    for (final m in memberships) {
      if (m.role == ClinicRole.admin) return m;
    }
    return memberships.first;
  }

  Future<void> _onLoginSubmitted(_LoginSubmitted event, Emitter<AuthState> emit) async {
    if (!state.isLoginFormValid) {
      debugPrint('[AuthBloc] Login validation failed — identifier: "${state.loginEmail}"');
      emit(state.copyWith(loginError: 'Please fill in all fields correctly'));
      return;
    }

    debugPrint('[AuthBloc] Login submitted — identifier: "${state.loginEmail}"');
    emit(state.copyWith(isLoginLoading: true, loginError: null));

    final params = LoginParams(
      emailOrMobileNumber: state.loginEmail,
      password: state.loginPassword,
    );

    final result = await _authRepository.login(params: params);

    result.fold(
      (failure) {
        debugPrint('[AuthBloc] ✗ Login failed — ${NetworkExceptions.getErrorMessage(failure)}');
        emit(state.copyWith(
          isLoginLoading: false,
          loginError: NetworkExceptions.getErrorMessage(failure),
        ));
      },
      (loginResult) {
        debugPrint('[AuthBloc] ✓ Login success — user: ${loginResult.user.name} (${loginResult.user.id}), emailVerified: ${loginResult.emailVerified}');
        // Cache the role of the active membership so the UI can hide
        // admin-only sections without waiting for the permissions API.
        final active = _pickActiveMembership(loginResult.memberships);
        if (active != null) {
          _userStorage.saveUserRole(active.role.name);
        }
        if (!loginResult.emailVerified) {
          // User exists but hasn't verified email yet — redirect to email verification
          emit(state.copyWith(
            isLoginLoading: false,
            needsEmailVerification: true,
            emailVerificationForLogin: true,
            signupEmail: state.loginEmail,
            currentUser: loginResult.user,
            memberships: loginResult.memberships,
            activeClinicId: active?.clinicId,
          ));
        } else {
          emit(state.copyWith(
            isLoginLoading: false,
            status: AuthStatus.authenticated,
            currentUser: loginResult.user,
            memberships: loginResult.memberships,
            activeClinicId: active?.clinicId,
          ));
        }
      },
    );
  }

  // Signup handlers
  void _onSignupFirstNameChanged(_SignupFirstNameChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      signupFirstName: event.firstName,
      signupError: null,
    ));
  }

  void _onSignupLastNameChanged(_SignupLastNameChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      signupLastName: event.lastName,
      signupError: null,
    ));
  }

  void _onSignupEmailChanged(_SignupEmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      signupEmail: event.email,
      signupError: null,
    ));
  }

  void _onSignupPasswordChanged(_SignupPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      signupPassword: event.password,
      signupError: null,
    ));
  }

  void _onSignupConfirmPasswordChanged(
    _SignupConfirmPasswordChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      signupConfirmPassword: event.confirmPassword,
      signupError: null,
    ));
  }

  void _onSignupPasswordVisibilityToggled(
    _SignupPasswordVisibilityToggled event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      isSignupPasswordVisible: !state.isSignupPasswordVisible,
    ));
  }

  void _onSignupConfirmPasswordVisibilityToggled(
    _SignupConfirmPasswordVisibilityToggled event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      isSignupConfirmPasswordVisible: !state.isSignupConfirmPasswordVisible,
    ));
  }

  // Dentist-specific signup
  void _onSignupLicenseNumberChanged(_SignupLicenseNumberChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      signupLicenseNumber: event.licenseNumber,
      signupError: null,
    ));
  }

  void _onSignupSpecializationChanged(_SignupSpecializationChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      signupSpecialization: event.specialization,
      signupError: null,
    ));
  }

  void _onSignupLocationChanged(_SignupLocationChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      signupLocation: event.location,
      signupError: null,
    ));
  }

  // API data fetching handlers
  Future<void> _onSpecialtiesRequested(
    _SpecialtiesRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoadingSpecialties: true, signupError: null));

    final result = await _authRepository.getSpecialties();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingSpecialties: false,
        signupError: NetworkExceptions.getErrorMessage(failure),
      )),
      (specialties) => emit(state.copyWith(
        isLoadingSpecialties: false,
        specialties: specialties,
      )),
    );
  }

  Future<void> _onPlansRequested(
    _PlansRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoadingPlans: true, signupError: null));

    final result = await _authRepository.getPlans();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadingPlans: false,
        signupError: NetworkExceptions.getErrorMessage(failure),
      )),
      (plans) => emit(state.copyWith(
        isLoadingPlans: false,
        plans: plans,
      )),
    );
  }

  Future<void> _onLocationSearchRequested(
    _LocationSearchRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Don't search if query is too short
    if (event.query.trim().length < 2) {
      emit(state.copyWith(searchedLocations: []));
      return;
    }

    emit(state.copyWith(isSearchingLocations: true, signupError: null));

    final result = await _authRepository.searchLocations(
      query: event.query,
      countryCode: event.countryCode,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isSearchingLocations: false,
        signupError: NetworkExceptions.getErrorMessage(failure),
      )),
      (locations) => emit(state.copyWith(
        isSearchingLocations: false,
        searchedLocations: locations,
      )),
    );
  }

  // Selection handlers
  void _onSignupSpecialtyEntitySelected(
    _SignupSpecialtyEntitySelected event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      selectedSpecialty: event.specialty,
      signupError: null,
    ));
  }

  void _onSignupLocationEntitySelected(
    _SignupLocationEntitySelected event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      selectedLocation: event.location,
      signupError: null,
    ));
  }

  void _onSignupPlanEntitySelected(
    _SignupPlanEntitySelected event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      selectedPlan: event.plan,
      signupError: null,
    ));
  }

  // Clinic info handlers
  void _onSignupClinicNameChanged(
    _SignupClinicNameChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      clinicName: event.name,
      signupError: null,
    ));
  }

  void _onSignupClinicAddressChanged(
    _SignupClinicAddressChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      clinicAddress: event.address,
      signupError: null,
    ));
  }

  void _onSignupMobileNumberChanged(
    _SignupMobileNumberChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      mobileNumber: event.mobile,
      signupError: null,
    ));
  }

  // OTP handlers
  Future<void> _onOtpRequested(_OtpRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isOtpLoading: true, otpError: null));

    final params = RequestOtpParams(email: state.signupEmail);
    final result = await _authRepository.requestOtpForRegister(params: params);

    result.fold(
      (failure) => emit(state.copyWith(
        isOtpLoading: false,
        otpError: NetworkExceptions.getErrorMessage(failure),
      )),
      (response) => emit(state.copyWith(
        isOtpLoading: false,
        otpSecondsRemaining: response.secondsRemaining,
        canResendOtp: false,
      )),
    );
  }

  void _onOtpCodeChanged(_OtpCodeChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      otpCode: event.code,
      otpError: null,
    ));
  }

  Future<void> _onOtpVerified(_OtpVerified event, Emitter<AuthState> emit) async {
    if (state.otpCode.length != 6) {
      emit(state.copyWith(otpError: 'Please enter a valid 6-digit code'));
      return;
    }

    emit(state.copyWith(isOtpVerifying: true, otpError: null));

    if (state.emailVerificationForLogin) {
      // Email verification flow uses a dedicated endpoint
      final result = await _authRepository.verifyEmailWithOtp(state.otpCode);
      result.fold(
        (failure) => emit(state.copyWith(
          isOtpVerifying: false,
          otpError: NetworkExceptions.getErrorMessage(failure),
        )),
        (_) => emit(state.copyWith(
          isOtpVerifying: false,
          status: AuthStatus.authenticated,
          needsEmailVerification: false,
          emailVerificationForLogin: false,
        )),
      );
    } else {
      // Signup / registration flow
      final params = VerifyOtpParams(
        email: state.signupEmail,
        otp: state.otpCode,
      );
      final result = await _authRepository.verifyOtp(params: params);
      result.fold(
        (failure) => emit(state.copyWith(
          isOtpVerifying: false,
          otpError: NetworkExceptions.getErrorMessage(failure),
        )),
        (response) => emit(state.copyWith(
          isOtpVerifying: false,
          sessionId: response.sessionId,
        )),
      );
    }
  }

  Future<void> _onOtpResendRequested(_OtpResendRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isOtpLoading: true, otpError: null));

    final Either<NetworkExceptions, OtpResponse> result;
    if (state.emailVerificationForLogin) {
      result = await _authRepository.requestOtpForVerifyEmail();
    } else {
      final params = RequestOtpParams(email: state.signupEmail);
      result = await _authRepository.resendOtp(params: params);
    }

    result.fold(
      (failure) => emit(state.copyWith(
        isOtpLoading: false,
        otpError: NetworkExceptions.getErrorMessage(failure),
      )),
      (response) => emit(state.copyWith(
        isOtpLoading: false,
        otpSecondsRemaining: response.secondsRemaining,
        canResendOtp: false,
        otpCode: '', // Clear OTP code on resend
      )),
    );
  }

  Future<void> _onSignupSubmitted(_SignupSubmitted event, Emitter<AuthState> emit) async {
    // Validate basic form fields
    if (!state.isSignupFirstNameValid) {
      emit(state.copyWith(signupError: 'First name must be at least 2 characters'));
      return;
    }
    if (!state.isSignupLastNameValid) {
      emit(state.copyWith(signupError: 'Last name must be at least 2 characters'));
      return;
    }
    if (!state.isSignupEmailValid) {
      emit(state.copyWith(signupError: 'Please enter a valid email address'));
      return;
    }
    if (!state.isSignupPasswordValid) {
      emit(state.copyWith(signupError: 'Password must be at least 8 characters'));
      return;
    }
    if (!state.isSignupConfirmPasswordValid) {
      emit(state.copyWith(signupError: 'Passwords do not match'));
      return;
    }

    // Validate required selections for API
    if (state.selectedSpecialty == null) {
      emit(state.copyWith(signupError: 'Please select a specialty'));
      return;
    }
    if (state.mobileNumber.trim().isEmpty) {
      emit(state.copyWith(signupError: 'Please enter your mobile number'));
      return;
    }
    if (state.selectedLocation == null) {
      emit(state.copyWith(signupError: 'Please select a location'));
      return;
    }
    if (state.selectedPlan == null) {
      emit(state.copyWith(signupError: 'Please select a subscription plan'));
      return;
    }
    if (state.clinicName.trim().isEmpty) {
      emit(state.copyWith(signupError: 'Please enter clinic name'));
      return;
    }

    emit(state.copyWith(isSignupLoading: true, signupError: null));

    // Validate session ID from OTP verification
    if (state.sessionId == null || state.sessionId!.isEmpty) {
      emit(state.copyWith(signupError: 'Please verify your email first'));
      return;
    }

    // Create register request params
    final params = RegisterRequestParams(
      firstName: state.signupFirstName,
      lastName: state.signupLastName,
      mobileNumber: state.mobileNumber,
      password: state.signupPassword,
      passwordConfirmation: state.signupConfirmPassword,
      specialtyId: state.selectedSpecialty!.id,
      clinicName: state.clinicName,
      locationId: state.selectedLocation!.id,
      detailedAddress: state.clinicAddress.trim().isEmpty
          ? state.selectedLocation!.name
          : state.clinicAddress,
      planVersionId: state.selectedPlan!.versionId,
      sessionId: state.sessionId!,
    );

    // Call register API
    final result = await _authRepository.register(params: params);

    result.fold(
      (failure) => emit(state.copyWith(
        isSignupLoading: false,
        signupError: NetworkExceptions.getErrorMessage(failure),
      )),
      (response) {
        // Convert response to user entity and clinic membership
        final user = response.toUserEntity();
        final membership = response.toClinicMembership();

        emit(state.copyWith(
          isSignupLoading: false,
          status: AuthStatus.authenticated,
          currentUser: user,
          memberships: [membership],
          activeClinicId: membership.clinicId,
        ));
      },
    );
  }

  // Forgot password handlers
  void _onForgotPasswordEmailChanged(
    _ForgotPasswordEmailChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      forgotPasswordEmail: event.email,
      forgotPasswordError: null,
      isForgotPasswordSuccess: false,
    ));
  }

  Future<void> _onForgotPasswordSubmitted(
    _ForgotPasswordSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (!state.isForgotPasswordEmailValid) {
      emit(state.copyWith(forgotPasswordError: 'Please enter a valid email'));
      return;
    }

    emit(state.copyWith(isForgotPasswordLoading: true, forgotPasswordError: null));

    final params = RequestOtpParams(email: state.forgotPasswordEmail);
    final result = await _authRepository.requestOtpForResetPassword(params: params);

    result.fold(
      (failure) => emit(state.copyWith(
        isForgotPasswordLoading: false,
        forgotPasswordError: NetworkExceptions.getErrorMessage(failure),
      )),
      (response) => emit(state.copyWith(
        isForgotPasswordLoading: false,
        isForgotPasswordSuccess: true,
        otpSecondsRemaining: response.secondsRemaining,
        canResendOtp: false,
      )),
    );
  }

  void _onForgotPasswordReset(_ForgotPasswordReset event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      forgotPasswordEmail: '',
      isForgotPasswordSuccess: false,
      forgotPasswordError: null,
    ));
  }

  // Reset password handlers
  Future<void> _onResetPasswordOtpRequested(
    _ResetPasswordOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isOtpLoading: true, otpError: null));

    final params = RequestOtpParams(email: state.forgotPasswordEmail);
    final result = await _authRepository.requestOtpForResetPassword(params: params);

    result.fold(
      (failure) => emit(state.copyWith(
        isOtpLoading: false,
        otpError: NetworkExceptions.getErrorMessage(failure),
      )),
      (response) => emit(state.copyWith(
        isOtpLoading: false,
        otpSecondsRemaining: response.secondsRemaining,
        canResendOtp: false,
      )),
    );
  }

  Future<void> _onResetPasswordOtpVerified(
    _ResetPasswordOtpVerified event,
    Emitter<AuthState> emit,
  ) async {
    if (state.otpCode.length != 6) {
      emit(state.copyWith(otpError: 'Please enter a valid 6-digit code'));
      return;
    }

    emit(state.copyWith(isOtpVerifying: true, otpError: null));

    final params = VerifyOtpParams(
      email: state.forgotPasswordEmail,
      otp: state.otpCode,
    );
    final result = await _authRepository.verifyOtp(params: params);

    result.fold(
      (failure) => emit(state.copyWith(
        isOtpVerifying: false,
        otpError: NetworkExceptions.getErrorMessage(failure),
      )),
      (response) => emit(state.copyWith(
        isOtpVerifying: false,
        resetPasswordSessionId: response.sessionId,
      )),
    );
  }

  Future<void> _onResetPasswordOtpResendRequested(
    _ResetPasswordOtpResendRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isOtpLoading: true, otpError: null));

    final params = RequestOtpParams(email: state.forgotPasswordEmail);
    final result = await _authRepository.requestOtpForResetPassword(params: params);

    result.fold(
      (failure) => emit(state.copyWith(
        isOtpLoading: false,
        otpError: NetworkExceptions.getErrorMessage(failure),
      )),
      (response) => emit(state.copyWith(
        isOtpLoading: false,
        otpSecondsRemaining: response.secondsRemaining,
        canResendOtp: false,
        otpCode: '',
      )),
    );
  }

  void _onResetPasswordNewChanged(
    _ResetPasswordNewChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      resetPasswordNew: event.password,
      resetPasswordError: null,
    ));
  }

  void _onResetPasswordConfirmChanged(
    _ResetPasswordConfirmChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      resetPasswordConfirm: event.confirm,
      resetPasswordError: null,
    ));
  }

  void _onResetPasswordVisibilityToggled(
    _ResetPasswordVisibilityToggled event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      isResetPasswordVisible: !state.isResetPasswordVisible,
    ));
  }

  void _onResetPasswordConfirmVisibilityToggled(
    _ResetPasswordConfirmVisibilityToggled event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      isResetPasswordConfirmVisible: !state.isResetPasswordConfirmVisible,
    ));
  }

  Future<void> _onResetPasswordSubmitted(
    _ResetPasswordSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (state.resetPasswordNew.length < 8) {
      emit(state.copyWith(resetPasswordError: 'Password must be at least 8 characters'));
      return;
    }
    if (state.resetPasswordNew != state.resetPasswordConfirm) {
      emit(state.copyWith(resetPasswordError: 'Passwords do not match'));
      return;
    }
    if (state.resetPasswordSessionId == null || state.resetPasswordSessionId!.isEmpty) {
      emit(state.copyWith(resetPasswordError: 'Session expired. Please try again.'));
      return;
    }

    emit(state.copyWith(isResetPasswordLoading: true, resetPasswordError: null));

    final params = ResetPasswordParams(
      sessionId: state.resetPasswordSessionId!,
      password: state.resetPasswordNew,
      passwordConfirmation: state.resetPasswordConfirm,
    );
    final result = await _authRepository.resetPassword(params: params);

    result.fold(
      (failure) => emit(state.copyWith(
        isResetPasswordLoading: false,
        resetPasswordError: NetworkExceptions.getErrorMessage(failure),
      )),
      (_) => emit(state.copyWith(
        isResetPasswordLoading: false,
        isResetPasswordSuccess: true,
      )),
    );
  }

  // Clinic context handler
  void _onActiveClinicChanged(_ActiveClinicChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(activeClinicId: event.clinicId));
  }

  // Auth check handler
  Future<void> _onAuthCheckRequested(_AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      // TODO: Check for stored tokens and validate them
      await Future.delayed(const Duration(milliseconds: 500));

      // For now, just mark as unauthenticated
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  // Logout handler
  Future<void> _onLogoutRequested(_LogoutRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    // Clear authentication and user data from local storage
    await _tokenStorage.clearAuthData();
    await _userStorage.clear();

    // Reset to initial state (unauthenticated)
    emit(const AuthState());
  }

  Future<void> _onVerifyEmailOtpRequested(
    _VerifyEmailOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isOtpLoading: true, otpError: null));

    final result = await _authRepository.requestOtpForVerifyEmail();

    result.fold(
      (failure) => emit(state.copyWith(
        isOtpLoading: false,
        otpError: NetworkExceptions.getErrorMessage(failure),
      )),
      (response) => emit(state.copyWith(
        isOtpLoading: false,
        otpSecondsRemaining: response.secondsRemaining,
        canResendOtp: false,
      )),
    );
  }

  void _onEmailVerificationCompleted(
    _EmailVerificationCompleted event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      status: AuthStatus.authenticated,
      needsEmailVerification: false,
      emailVerificationForLogin: false,
    ));
  }

  void _onEmailVerificationCancelled(
    _EmailVerificationCancelled event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(
      needsEmailVerification: false,
      emailVerificationForLogin: false,
      otpCode: '',
      otpError: null,
      otpSecondsRemaining: 0,
      sessionId: null,
    ));
  }

  // Reset signup form
  void _onSignupFormReset(_SignupFormReset event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      signupFirstName: '',
      signupLastName: '',
      signupEmail: '',
      signupPassword: '',
      signupConfirmPassword: '',
      signupLicenseNumber: '',
      signupSpecialization: '',
      signupLocation: '',
      isSignupPasswordVisible: false,
      isSignupConfirmPasswordVisible: false,
      isSignupLoading: false,
      signupError: null,
      // Reset API-related fields
      specialties: [],
      searchedLocations: [],
      plans: [],
      isLoadingSpecialties: false,
      isLoadingPlans: false,
      isSearchingLocations: false,
      selectedSpecialty: null,
      selectedLocation: null,
      selectedPlan: null,
      clinicName: '',
      clinicAddress: '',
      mobileNumber: '',
    ));
  }
}
