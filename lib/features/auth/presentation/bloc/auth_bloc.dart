import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/user_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_membership_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    // Login events
    on<_LoginEmailChanged>(_onLoginEmailChanged);
    on<_LoginPasswordChanged>(_onLoginPasswordChanged);
    on<_LoginPasswordVisibilityToggled>(_onLoginPasswordVisibilityToggled);
    on<_LoginSubmitted>(_onLoginSubmitted);

    // Signup events - Unified
    on<_SignupNameChanged>(_onSignupNameChanged);
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

    // Forgot password events
    on<_ForgotPasswordEmailChanged>(_onForgotPasswordEmailChanged);
    on<_ForgotPasswordSubmitted>(_onForgotPasswordSubmitted);
    on<_ForgotPasswordReset>(_onForgotPasswordReset);

    // Clinic context
    on<_ActiveClinicChanged>(_onActiveClinicChanged);

    // Auth check
    on<_AuthCheckRequested>(_onAuthCheckRequested);

    // Logout
    on<_LogoutRequested>(_onLogoutRequested);
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

  Future<void> _onLoginSubmitted(_LoginSubmitted event, Emitter<AuthState> emit) async {
    if (!state.isLoginFormValid) {
      emit(state.copyWith(loginError: 'Please fill in all fields correctly'));
      return;
    }

    emit(state.copyWith(isLoginLoading: true, loginError: null));

    try {
      // TODO: Implement actual login API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock successful login - create a mock user based on email
      // In real app, this would come from API response
      final mockUser = UserEntity(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: state.loginEmail,
        name: 'Dr. ${state.loginEmail.split('@').first}',
      );

      emit(state.copyWith(
        isLoginLoading: false,
        status: AuthStatus.authenticated,
        currentUser: mockUser,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoginLoading: false,
        loginError: 'Login failed. Please try again.',
      ));
    }
  }

  // Signup handlers
  void _onSignupNameChanged(_SignupNameChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      signupName: event.name,
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

  Future<void> _onSignupSubmitted(_SignupSubmitted event, Emitter<AuthState> emit) async {
    // Validate form fields
    if (!state.isSignupNameValid) {
      emit(state.copyWith(signupError: 'Name must be at least 2 characters'));
      return;
    }
    if (!state.isSignupEmailValid) {
      emit(state.copyWith(signupError: 'Please enter a valid email address'));
      return;
    }
    if (!state.isSignupPasswordValid) {
      emit(state.copyWith(signupError: 'Password must be at least 6 characters'));
      return;
    }
    if (!state.isSignupConfirmPasswordValid) {
      emit(state.copyWith(signupError: 'Passwords do not match'));
      return;
    }

    emit(state.copyWith(isSignupLoading: true, signupError: null));

    try {
      // TODO: Implement actual signup API call
      await Future.delayed(const Duration(seconds: 2));

      // Create user - all users are dental professionals
      // They can later create/join clinics from the dashboard
      final mockUser = UserEntity(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: state.signupEmail,
        name: state.signupName,
        licenseNumber: state.signupLicenseNumber.isNotEmpty ? state.signupLicenseNumber : null,
        specialization: state.signupSpecialization.isNotEmpty ? state.signupSpecialization : null,
      );

      emit(state.copyWith(
        isSignupLoading: false,
        status: AuthStatus.authenticated,
        currentUser: mockUser,
        // User starts with no clinic memberships
        // They can create a clinic or join one from the dashboard
        memberships: [],
        activeClinicId: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isSignupLoading: false,
        signupError: 'Signup failed. Please try again.',
      ));
    }
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

    try {
      // TODO: Implement actual forgot password API call
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(
        isForgotPasswordLoading: false,
        isForgotPasswordSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isForgotPasswordLoading: false,
        forgotPasswordError: 'Failed to send reset email. Please try again.',
      ));
    }
  }

  void _onForgotPasswordReset(_ForgotPasswordReset event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      forgotPasswordEmail: '',
      isForgotPasswordSuccess: false,
      forgotPasswordError: null,
    ));
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

    // TODO: Clear local storage, tokens, etc.
    await Future.delayed(const Duration(milliseconds: 500));

    emit(const AuthState());
  }

  // Reset signup form
  void _onSignupFormReset(_SignupFormReset event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      signupName: '',
      signupEmail: '',
      signupPassword: '',
      signupConfirmPassword: '',
      signupLicenseNumber: '',
      signupSpecialization: '',
      isSignupPasswordVisible: false,
      isSignupConfirmPasswordVisible: false,
      isSignupLoading: false,
      signupError: null,
    ));
  }
}
