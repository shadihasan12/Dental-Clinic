// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoginEmailChangedImplCopyWith<$Res> {
  factory _$$LoginEmailChangedImplCopyWith(
    _$LoginEmailChangedImpl value,
    $Res Function(_$LoginEmailChangedImpl) then,
  ) = __$$LoginEmailChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$LoginEmailChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoginEmailChangedImpl>
    implements _$$LoginEmailChangedImplCopyWith<$Res> {
  __$$LoginEmailChangedImplCopyWithImpl(
    _$LoginEmailChangedImpl _value,
    $Res Function(_$LoginEmailChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _$LoginEmailChangedImpl(
        null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoginEmailChangedImpl implements _LoginEmailChanged {
  const _$LoginEmailChangedImpl(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'AuthEvent.loginEmailChanged(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginEmailChangedImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginEmailChangedImplCopyWith<_$LoginEmailChangedImpl> get copyWith =>
      __$$LoginEmailChangedImplCopyWithImpl<_$LoginEmailChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return loginEmailChanged(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return loginEmailChanged?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (loginEmailChanged != null) {
      return loginEmailChanged(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return loginEmailChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return loginEmailChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (loginEmailChanged != null) {
      return loginEmailChanged(this);
    }
    return orElse();
  }
}

abstract class _LoginEmailChanged implements AuthEvent {
  const factory _LoginEmailChanged(final String email) =
      _$LoginEmailChangedImpl;

  String get email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginEmailChangedImplCopyWith<_$LoginEmailChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginPasswordChangedImplCopyWith<$Res> {
  factory _$$LoginPasswordChangedImplCopyWith(
    _$LoginPasswordChangedImpl value,
    $Res Function(_$LoginPasswordChangedImpl) then,
  ) = __$$LoginPasswordChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String password});
}

/// @nodoc
class __$$LoginPasswordChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoginPasswordChangedImpl>
    implements _$$LoginPasswordChangedImplCopyWith<$Res> {
  __$$LoginPasswordChangedImplCopyWithImpl(
    _$LoginPasswordChangedImpl _value,
    $Res Function(_$LoginPasswordChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? password = null}) {
    return _then(
      _$LoginPasswordChangedImpl(
        null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoginPasswordChangedImpl implements _LoginPasswordChanged {
  const _$LoginPasswordChangedImpl(this.password);

  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.loginPasswordChanged(password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginPasswordChangedImpl &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginPasswordChangedImplCopyWith<_$LoginPasswordChangedImpl>
  get copyWith =>
      __$$LoginPasswordChangedImplCopyWithImpl<_$LoginPasswordChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return loginPasswordChanged(password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return loginPasswordChanged?.call(password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (loginPasswordChanged != null) {
      return loginPasswordChanged(password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return loginPasswordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return loginPasswordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (loginPasswordChanged != null) {
      return loginPasswordChanged(this);
    }
    return orElse();
  }
}

abstract class _LoginPasswordChanged implements AuthEvent {
  const factory _LoginPasswordChanged(final String password) =
      _$LoginPasswordChangedImpl;

  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginPasswordChangedImplCopyWith<_$LoginPasswordChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginPasswordVisibilityToggledImplCopyWith<$Res> {
  factory _$$LoginPasswordVisibilityToggledImplCopyWith(
    _$LoginPasswordVisibilityToggledImpl value,
    $Res Function(_$LoginPasswordVisibilityToggledImpl) then,
  ) = __$$LoginPasswordVisibilityToggledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginPasswordVisibilityToggledImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoginPasswordVisibilityToggledImpl>
    implements _$$LoginPasswordVisibilityToggledImplCopyWith<$Res> {
  __$$LoginPasswordVisibilityToggledImplCopyWithImpl(
    _$LoginPasswordVisibilityToggledImpl _value,
    $Res Function(_$LoginPasswordVisibilityToggledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginPasswordVisibilityToggledImpl
    implements _LoginPasswordVisibilityToggled {
  const _$LoginPasswordVisibilityToggledImpl();

  @override
  String toString() {
    return 'AuthEvent.loginPasswordVisibilityToggled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginPasswordVisibilityToggledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return loginPasswordVisibilityToggled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return loginPasswordVisibilityToggled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (loginPasswordVisibilityToggled != null) {
      return loginPasswordVisibilityToggled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return loginPasswordVisibilityToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return loginPasswordVisibilityToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (loginPasswordVisibilityToggled != null) {
      return loginPasswordVisibilityToggled(this);
    }
    return orElse();
  }
}

abstract class _LoginPasswordVisibilityToggled implements AuthEvent {
  const factory _LoginPasswordVisibilityToggled() =
      _$LoginPasswordVisibilityToggledImpl;
}

/// @nodoc
abstract class _$$LoginSubmittedImplCopyWith<$Res> {
  factory _$$LoginSubmittedImplCopyWith(
    _$LoginSubmittedImpl value,
    $Res Function(_$LoginSubmittedImpl) then,
  ) = __$$LoginSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginSubmittedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoginSubmittedImpl>
    implements _$$LoginSubmittedImplCopyWith<$Res> {
  __$$LoginSubmittedImplCopyWithImpl(
    _$LoginSubmittedImpl _value,
    $Res Function(_$LoginSubmittedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginSubmittedImpl implements _LoginSubmitted {
  const _$LoginSubmittedImpl();

  @override
  String toString() {
    return 'AuthEvent.loginSubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return loginSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return loginSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (loginSubmitted != null) {
      return loginSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return loginSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return loginSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (loginSubmitted != null) {
      return loginSubmitted(this);
    }
    return orElse();
  }
}

abstract class _LoginSubmitted implements AuthEvent {
  const factory _LoginSubmitted() = _$LoginSubmittedImpl;
}

/// @nodoc
abstract class _$$SignupNameChangedImplCopyWith<$Res> {
  factory _$$SignupNameChangedImplCopyWith(
    _$SignupNameChangedImpl value,
    $Res Function(_$SignupNameChangedImpl) then,
  ) = __$$SignupNameChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$SignupNameChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupNameChangedImpl>
    implements _$$SignupNameChangedImplCopyWith<$Res> {
  __$$SignupNameChangedImplCopyWithImpl(
    _$SignupNameChangedImpl _value,
    $Res Function(_$SignupNameChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _$SignupNameChangedImpl(
        null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SignupNameChangedImpl implements _SignupNameChanged {
  const _$SignupNameChangedImpl(this.name);

  @override
  final String name;

  @override
  String toString() {
    return 'AuthEvent.signupNameChanged(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupNameChangedImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupNameChangedImplCopyWith<_$SignupNameChangedImpl> get copyWith =>
      __$$SignupNameChangedImplCopyWithImpl<_$SignupNameChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupNameChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupNameChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupNameChanged != null) {
      return signupNameChanged(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupNameChanged != null) {
      return signupNameChanged(this);
    }
    return orElse();
  }
}

abstract class _SignupNameChanged implements AuthEvent {
  const factory _SignupNameChanged(final String name) = _$SignupNameChangedImpl;

  String get name;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupNameChangedImplCopyWith<_$SignupNameChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupEmailChangedImplCopyWith<$Res> {
  factory _$$SignupEmailChangedImplCopyWith(
    _$SignupEmailChangedImpl value,
    $Res Function(_$SignupEmailChangedImpl) then,
  ) = __$$SignupEmailChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$SignupEmailChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupEmailChangedImpl>
    implements _$$SignupEmailChangedImplCopyWith<$Res> {
  __$$SignupEmailChangedImplCopyWithImpl(
    _$SignupEmailChangedImpl _value,
    $Res Function(_$SignupEmailChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _$SignupEmailChangedImpl(
        null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SignupEmailChangedImpl implements _SignupEmailChanged {
  const _$SignupEmailChangedImpl(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'AuthEvent.signupEmailChanged(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupEmailChangedImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupEmailChangedImplCopyWith<_$SignupEmailChangedImpl> get copyWith =>
      __$$SignupEmailChangedImplCopyWithImpl<_$SignupEmailChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupEmailChanged(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupEmailChanged?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupEmailChanged != null) {
      return signupEmailChanged(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupEmailChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupEmailChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupEmailChanged != null) {
      return signupEmailChanged(this);
    }
    return orElse();
  }
}

abstract class _SignupEmailChanged implements AuthEvent {
  const factory _SignupEmailChanged(final String email) =
      _$SignupEmailChangedImpl;

  String get email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupEmailChangedImplCopyWith<_$SignupEmailChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupPasswordChangedImplCopyWith<$Res> {
  factory _$$SignupPasswordChangedImplCopyWith(
    _$SignupPasswordChangedImpl value,
    $Res Function(_$SignupPasswordChangedImpl) then,
  ) = __$$SignupPasswordChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String password});
}

/// @nodoc
class __$$SignupPasswordChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupPasswordChangedImpl>
    implements _$$SignupPasswordChangedImplCopyWith<$Res> {
  __$$SignupPasswordChangedImplCopyWithImpl(
    _$SignupPasswordChangedImpl _value,
    $Res Function(_$SignupPasswordChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? password = null}) {
    return _then(
      _$SignupPasswordChangedImpl(
        null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SignupPasswordChangedImpl implements _SignupPasswordChanged {
  const _$SignupPasswordChangedImpl(this.password);

  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.signupPasswordChanged(password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupPasswordChangedImpl &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupPasswordChangedImplCopyWith<_$SignupPasswordChangedImpl>
  get copyWith =>
      __$$SignupPasswordChangedImplCopyWithImpl<_$SignupPasswordChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupPasswordChanged(password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupPasswordChanged?.call(password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupPasswordChanged != null) {
      return signupPasswordChanged(password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupPasswordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupPasswordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupPasswordChanged != null) {
      return signupPasswordChanged(this);
    }
    return orElse();
  }
}

abstract class _SignupPasswordChanged implements AuthEvent {
  const factory _SignupPasswordChanged(final String password) =
      _$SignupPasswordChangedImpl;

  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupPasswordChangedImplCopyWith<_$SignupPasswordChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupConfirmPasswordChangedImplCopyWith<$Res> {
  factory _$$SignupConfirmPasswordChangedImplCopyWith(
    _$SignupConfirmPasswordChangedImpl value,
    $Res Function(_$SignupConfirmPasswordChangedImpl) then,
  ) = __$$SignupConfirmPasswordChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String confirmPassword});
}

/// @nodoc
class __$$SignupConfirmPasswordChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupConfirmPasswordChangedImpl>
    implements _$$SignupConfirmPasswordChangedImplCopyWith<$Res> {
  __$$SignupConfirmPasswordChangedImplCopyWithImpl(
    _$SignupConfirmPasswordChangedImpl _value,
    $Res Function(_$SignupConfirmPasswordChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? confirmPassword = null}) {
    return _then(
      _$SignupConfirmPasswordChangedImpl(
        null == confirmPassword
            ? _value.confirmPassword
            : confirmPassword // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SignupConfirmPasswordChangedImpl
    implements _SignupConfirmPasswordChanged {
  const _$SignupConfirmPasswordChangedImpl(this.confirmPassword);

  @override
  final String confirmPassword;

  @override
  String toString() {
    return 'AuthEvent.signupConfirmPasswordChanged(confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupConfirmPasswordChangedImpl &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, confirmPassword);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupConfirmPasswordChangedImplCopyWith<
    _$SignupConfirmPasswordChangedImpl
  >
  get copyWith =>
      __$$SignupConfirmPasswordChangedImplCopyWithImpl<
        _$SignupConfirmPasswordChangedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupConfirmPasswordChanged(confirmPassword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupConfirmPasswordChanged?.call(confirmPassword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupConfirmPasswordChanged != null) {
      return signupConfirmPasswordChanged(confirmPassword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupConfirmPasswordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupConfirmPasswordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupConfirmPasswordChanged != null) {
      return signupConfirmPasswordChanged(this);
    }
    return orElse();
  }
}

abstract class _SignupConfirmPasswordChanged implements AuthEvent {
  const factory _SignupConfirmPasswordChanged(final String confirmPassword) =
      _$SignupConfirmPasswordChangedImpl;

  String get confirmPassword;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupConfirmPasswordChangedImplCopyWith<
    _$SignupConfirmPasswordChangedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupPasswordVisibilityToggledImplCopyWith<$Res> {
  factory _$$SignupPasswordVisibilityToggledImplCopyWith(
    _$SignupPasswordVisibilityToggledImpl value,
    $Res Function(_$SignupPasswordVisibilityToggledImpl) then,
  ) = __$$SignupPasswordVisibilityToggledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignupPasswordVisibilityToggledImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupPasswordVisibilityToggledImpl>
    implements _$$SignupPasswordVisibilityToggledImplCopyWith<$Res> {
  __$$SignupPasswordVisibilityToggledImplCopyWithImpl(
    _$SignupPasswordVisibilityToggledImpl _value,
    $Res Function(_$SignupPasswordVisibilityToggledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignupPasswordVisibilityToggledImpl
    implements _SignupPasswordVisibilityToggled {
  const _$SignupPasswordVisibilityToggledImpl();

  @override
  String toString() {
    return 'AuthEvent.signupPasswordVisibilityToggled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupPasswordVisibilityToggledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupPasswordVisibilityToggled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupPasswordVisibilityToggled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupPasswordVisibilityToggled != null) {
      return signupPasswordVisibilityToggled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupPasswordVisibilityToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupPasswordVisibilityToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupPasswordVisibilityToggled != null) {
      return signupPasswordVisibilityToggled(this);
    }
    return orElse();
  }
}

abstract class _SignupPasswordVisibilityToggled implements AuthEvent {
  const factory _SignupPasswordVisibilityToggled() =
      _$SignupPasswordVisibilityToggledImpl;
}

/// @nodoc
abstract class _$$SignupConfirmPasswordVisibilityToggledImplCopyWith<$Res> {
  factory _$$SignupConfirmPasswordVisibilityToggledImplCopyWith(
    _$SignupConfirmPasswordVisibilityToggledImpl value,
    $Res Function(_$SignupConfirmPasswordVisibilityToggledImpl) then,
  ) = __$$SignupConfirmPasswordVisibilityToggledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignupConfirmPasswordVisibilityToggledImplCopyWithImpl<$Res>
    extends
        _$AuthEventCopyWithImpl<
          $Res,
          _$SignupConfirmPasswordVisibilityToggledImpl
        >
    implements _$$SignupConfirmPasswordVisibilityToggledImplCopyWith<$Res> {
  __$$SignupConfirmPasswordVisibilityToggledImplCopyWithImpl(
    _$SignupConfirmPasswordVisibilityToggledImpl _value,
    $Res Function(_$SignupConfirmPasswordVisibilityToggledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignupConfirmPasswordVisibilityToggledImpl
    implements _SignupConfirmPasswordVisibilityToggled {
  const _$SignupConfirmPasswordVisibilityToggledImpl();

  @override
  String toString() {
    return 'AuthEvent.signupConfirmPasswordVisibilityToggled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupConfirmPasswordVisibilityToggledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupConfirmPasswordVisibilityToggled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupConfirmPasswordVisibilityToggled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupConfirmPasswordVisibilityToggled != null) {
      return signupConfirmPasswordVisibilityToggled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupConfirmPasswordVisibilityToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupConfirmPasswordVisibilityToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupConfirmPasswordVisibilityToggled != null) {
      return signupConfirmPasswordVisibilityToggled(this);
    }
    return orElse();
  }
}

abstract class _SignupConfirmPasswordVisibilityToggled implements AuthEvent {
  const factory _SignupConfirmPasswordVisibilityToggled() =
      _$SignupConfirmPasswordVisibilityToggledImpl;
}

/// @nodoc
abstract class _$$SignupSubmittedImplCopyWith<$Res> {
  factory _$$SignupSubmittedImplCopyWith(
    _$SignupSubmittedImpl value,
    $Res Function(_$SignupSubmittedImpl) then,
  ) = __$$SignupSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignupSubmittedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupSubmittedImpl>
    implements _$$SignupSubmittedImplCopyWith<$Res> {
  __$$SignupSubmittedImplCopyWithImpl(
    _$SignupSubmittedImpl _value,
    $Res Function(_$SignupSubmittedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignupSubmittedImpl implements _SignupSubmitted {
  const _$SignupSubmittedImpl();

  @override
  String toString() {
    return 'AuthEvent.signupSubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignupSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupSubmitted != null) {
      return signupSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupSubmitted != null) {
      return signupSubmitted(this);
    }
    return orElse();
  }
}

abstract class _SignupSubmitted implements AuthEvent {
  const factory _SignupSubmitted() = _$SignupSubmittedImpl;
}

/// @nodoc
abstract class _$$SignupFormResetImplCopyWith<$Res> {
  factory _$$SignupFormResetImplCopyWith(
    _$SignupFormResetImpl value,
    $Res Function(_$SignupFormResetImpl) then,
  ) = __$$SignupFormResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignupFormResetImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupFormResetImpl>
    implements _$$SignupFormResetImplCopyWith<$Res> {
  __$$SignupFormResetImplCopyWithImpl(
    _$SignupFormResetImpl _value,
    $Res Function(_$SignupFormResetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignupFormResetImpl implements _SignupFormReset {
  const _$SignupFormResetImpl();

  @override
  String toString() {
    return 'AuthEvent.signupFormReset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignupFormResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupFormReset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupFormReset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupFormReset != null) {
      return signupFormReset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupFormReset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupFormReset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupFormReset != null) {
      return signupFormReset(this);
    }
    return orElse();
  }
}

abstract class _SignupFormReset implements AuthEvent {
  const factory _SignupFormReset() = _$SignupFormResetImpl;
}

/// @nodoc
abstract class _$$SignupLicenseNumberChangedImplCopyWith<$Res> {
  factory _$$SignupLicenseNumberChangedImplCopyWith(
    _$SignupLicenseNumberChangedImpl value,
    $Res Function(_$SignupLicenseNumberChangedImpl) then,
  ) = __$$SignupLicenseNumberChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String licenseNumber});
}

/// @nodoc
class __$$SignupLicenseNumberChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupLicenseNumberChangedImpl>
    implements _$$SignupLicenseNumberChangedImplCopyWith<$Res> {
  __$$SignupLicenseNumberChangedImplCopyWithImpl(
    _$SignupLicenseNumberChangedImpl _value,
    $Res Function(_$SignupLicenseNumberChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? licenseNumber = null}) {
    return _then(
      _$SignupLicenseNumberChangedImpl(
        null == licenseNumber
            ? _value.licenseNumber
            : licenseNumber // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SignupLicenseNumberChangedImpl implements _SignupLicenseNumberChanged {
  const _$SignupLicenseNumberChangedImpl(this.licenseNumber);

  @override
  final String licenseNumber;

  @override
  String toString() {
    return 'AuthEvent.signupLicenseNumberChanged(licenseNumber: $licenseNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupLicenseNumberChangedImpl &&
            (identical(other.licenseNumber, licenseNumber) ||
                other.licenseNumber == licenseNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, licenseNumber);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupLicenseNumberChangedImplCopyWith<_$SignupLicenseNumberChangedImpl>
  get copyWith =>
      __$$SignupLicenseNumberChangedImplCopyWithImpl<
        _$SignupLicenseNumberChangedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupLicenseNumberChanged(licenseNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupLicenseNumberChanged?.call(licenseNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupLicenseNumberChanged != null) {
      return signupLicenseNumberChanged(licenseNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupLicenseNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupLicenseNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupLicenseNumberChanged != null) {
      return signupLicenseNumberChanged(this);
    }
    return orElse();
  }
}

abstract class _SignupLicenseNumberChanged implements AuthEvent {
  const factory _SignupLicenseNumberChanged(final String licenseNumber) =
      _$SignupLicenseNumberChangedImpl;

  String get licenseNumber;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupLicenseNumberChangedImplCopyWith<_$SignupLicenseNumberChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupSpecializationChangedImplCopyWith<$Res> {
  factory _$$SignupSpecializationChangedImplCopyWith(
    _$SignupSpecializationChangedImpl value,
    $Res Function(_$SignupSpecializationChangedImpl) then,
  ) = __$$SignupSpecializationChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String specialization});
}

/// @nodoc
class __$$SignupSpecializationChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupSpecializationChangedImpl>
    implements _$$SignupSpecializationChangedImplCopyWith<$Res> {
  __$$SignupSpecializationChangedImplCopyWithImpl(
    _$SignupSpecializationChangedImpl _value,
    $Res Function(_$SignupSpecializationChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? specialization = null}) {
    return _then(
      _$SignupSpecializationChangedImpl(
        null == specialization
            ? _value.specialization
            : specialization // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SignupSpecializationChangedImpl
    implements _SignupSpecializationChanged {
  const _$SignupSpecializationChangedImpl(this.specialization);

  @override
  final String specialization;

  @override
  String toString() {
    return 'AuthEvent.signupSpecializationChanged(specialization: $specialization)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupSpecializationChangedImpl &&
            (identical(other.specialization, specialization) ||
                other.specialization == specialization));
  }

  @override
  int get hashCode => Object.hash(runtimeType, specialization);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupSpecializationChangedImplCopyWith<_$SignupSpecializationChangedImpl>
  get copyWith =>
      __$$SignupSpecializationChangedImplCopyWithImpl<
        _$SignupSpecializationChangedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupSpecializationChanged(specialization);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupSpecializationChanged?.call(specialization);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupSpecializationChanged != null) {
      return signupSpecializationChanged(specialization);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupSpecializationChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupSpecializationChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupSpecializationChanged != null) {
      return signupSpecializationChanged(this);
    }
    return orElse();
  }
}

abstract class _SignupSpecializationChanged implements AuthEvent {
  const factory _SignupSpecializationChanged(final String specialization) =
      _$SignupSpecializationChangedImpl;

  String get specialization;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupSpecializationChangedImplCopyWith<_$SignupSpecializationChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupLocationChangedImplCopyWith<$Res> {
  factory _$$SignupLocationChangedImplCopyWith(
    _$SignupLocationChangedImpl value,
    $Res Function(_$SignupLocationChangedImpl) then,
  ) = __$$SignupLocationChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String location});
}

/// @nodoc
class __$$SignupLocationChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupLocationChangedImpl>
    implements _$$SignupLocationChangedImplCopyWith<$Res> {
  __$$SignupLocationChangedImplCopyWithImpl(
    _$SignupLocationChangedImpl _value,
    $Res Function(_$SignupLocationChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? location = null}) {
    return _then(
      _$SignupLocationChangedImpl(
        null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SignupLocationChangedImpl implements _SignupLocationChanged {
  const _$SignupLocationChangedImpl(this.location);

  @override
  final String location;

  @override
  String toString() {
    return 'AuthEvent.signupLocationChanged(location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupLocationChangedImpl &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupLocationChangedImplCopyWith<_$SignupLocationChangedImpl>
  get copyWith =>
      __$$SignupLocationChangedImplCopyWithImpl<_$SignupLocationChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupLocationChanged(location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupLocationChanged?.call(location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupLocationChanged != null) {
      return signupLocationChanged(location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupLocationChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupLocationChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupLocationChanged != null) {
      return signupLocationChanged(this);
    }
    return orElse();
  }
}

abstract class _SignupLocationChanged implements AuthEvent {
  const factory _SignupLocationChanged(final String location) =
      _$SignupLocationChangedImpl;

  String get location;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupLocationChangedImplCopyWith<_$SignupLocationChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SpecialtiesRequestedImplCopyWith<$Res> {
  factory _$$SpecialtiesRequestedImplCopyWith(
    _$SpecialtiesRequestedImpl value,
    $Res Function(_$SpecialtiesRequestedImpl) then,
  ) = __$$SpecialtiesRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SpecialtiesRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SpecialtiesRequestedImpl>
    implements _$$SpecialtiesRequestedImplCopyWith<$Res> {
  __$$SpecialtiesRequestedImplCopyWithImpl(
    _$SpecialtiesRequestedImpl _value,
    $Res Function(_$SpecialtiesRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SpecialtiesRequestedImpl implements _SpecialtiesRequested {
  const _$SpecialtiesRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.specialtiesRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecialtiesRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return specialtiesRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return specialtiesRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (specialtiesRequested != null) {
      return specialtiesRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return specialtiesRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return specialtiesRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (specialtiesRequested != null) {
      return specialtiesRequested(this);
    }
    return orElse();
  }
}

abstract class _SpecialtiesRequested implements AuthEvent {
  const factory _SpecialtiesRequested() = _$SpecialtiesRequestedImpl;
}

/// @nodoc
abstract class _$$PlansRequestedImplCopyWith<$Res> {
  factory _$$PlansRequestedImplCopyWith(
    _$PlansRequestedImpl value,
    $Res Function(_$PlansRequestedImpl) then,
  ) = __$$PlansRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PlansRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$PlansRequestedImpl>
    implements _$$PlansRequestedImplCopyWith<$Res> {
  __$$PlansRequestedImplCopyWithImpl(
    _$PlansRequestedImpl _value,
    $Res Function(_$PlansRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PlansRequestedImpl implements _PlansRequested {
  const _$PlansRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.plansRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PlansRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return plansRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return plansRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (plansRequested != null) {
      return plansRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return plansRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return plansRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (plansRequested != null) {
      return plansRequested(this);
    }
    return orElse();
  }
}

abstract class _PlansRequested implements AuthEvent {
  const factory _PlansRequested() = _$PlansRequestedImpl;
}

/// @nodoc
abstract class _$$LocationSearchRequestedImplCopyWith<$Res> {
  factory _$$LocationSearchRequestedImplCopyWith(
    _$LocationSearchRequestedImpl value,
    $Res Function(_$LocationSearchRequestedImpl) then,
  ) = __$$LocationSearchRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query, String countryCode});
}

/// @nodoc
class __$$LocationSearchRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LocationSearchRequestedImpl>
    implements _$$LocationSearchRequestedImplCopyWith<$Res> {
  __$$LocationSearchRequestedImplCopyWithImpl(
    _$LocationSearchRequestedImpl _value,
    $Res Function(_$LocationSearchRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null, Object? countryCode = null}) {
    return _then(
      _$LocationSearchRequestedImpl(
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
        countryCode: null == countryCode
            ? _value.countryCode
            : countryCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LocationSearchRequestedImpl implements _LocationSearchRequested {
  const _$LocationSearchRequestedImpl({
    required this.query,
    required this.countryCode,
  });

  @override
  final String query;
  @override
  final String countryCode;

  @override
  String toString() {
    return 'AuthEvent.locationSearchRequested(query: $query, countryCode: $countryCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationSearchRequestedImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query, countryCode);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationSearchRequestedImplCopyWith<_$LocationSearchRequestedImpl>
  get copyWith =>
      __$$LocationSearchRequestedImplCopyWithImpl<
        _$LocationSearchRequestedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return locationSearchRequested(query, countryCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return locationSearchRequested?.call(query, countryCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (locationSearchRequested != null) {
      return locationSearchRequested(query, countryCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return locationSearchRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return locationSearchRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (locationSearchRequested != null) {
      return locationSearchRequested(this);
    }
    return orElse();
  }
}

abstract class _LocationSearchRequested implements AuthEvent {
  const factory _LocationSearchRequested({
    required final String query,
    required final String countryCode,
  }) = _$LocationSearchRequestedImpl;

  String get query;
  String get countryCode;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationSearchRequestedImplCopyWith<_$LocationSearchRequestedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupSpecialtyEntitySelectedImplCopyWith<$Res> {
  factory _$$SignupSpecialtyEntitySelectedImplCopyWith(
    _$SignupSpecialtyEntitySelectedImpl value,
    $Res Function(_$SignupSpecialtyEntitySelectedImpl) then,
  ) = __$$SignupSpecialtyEntitySelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SpecialtyEntity specialty});

  $SpecialtyEntityCopyWith<$Res> get specialty;
}

/// @nodoc
class __$$SignupSpecialtyEntitySelectedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupSpecialtyEntitySelectedImpl>
    implements _$$SignupSpecialtyEntitySelectedImplCopyWith<$Res> {
  __$$SignupSpecialtyEntitySelectedImplCopyWithImpl(
    _$SignupSpecialtyEntitySelectedImpl _value,
    $Res Function(_$SignupSpecialtyEntitySelectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? specialty = null}) {
    return _then(
      _$SignupSpecialtyEntitySelectedImpl(
        null == specialty
            ? _value.specialty
            : specialty // ignore: cast_nullable_to_non_nullable
                  as SpecialtyEntity,
      ),
    );
  }

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpecialtyEntityCopyWith<$Res> get specialty {
    return $SpecialtyEntityCopyWith<$Res>(_value.specialty, (value) {
      return _then(_value.copyWith(specialty: value));
    });
  }
}

/// @nodoc

class _$SignupSpecialtyEntitySelectedImpl
    implements _SignupSpecialtyEntitySelected {
  const _$SignupSpecialtyEntitySelectedImpl(this.specialty);

  @override
  final SpecialtyEntity specialty;

  @override
  String toString() {
    return 'AuthEvent.signupSpecialtyEntitySelected(specialty: $specialty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupSpecialtyEntitySelectedImpl &&
            (identical(other.specialty, specialty) ||
                other.specialty == specialty));
  }

  @override
  int get hashCode => Object.hash(runtimeType, specialty);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupSpecialtyEntitySelectedImplCopyWith<
    _$SignupSpecialtyEntitySelectedImpl
  >
  get copyWith =>
      __$$SignupSpecialtyEntitySelectedImplCopyWithImpl<
        _$SignupSpecialtyEntitySelectedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupSpecialtyEntitySelected(specialty);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupSpecialtyEntitySelected?.call(specialty);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupSpecialtyEntitySelected != null) {
      return signupSpecialtyEntitySelected(specialty);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupSpecialtyEntitySelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupSpecialtyEntitySelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupSpecialtyEntitySelected != null) {
      return signupSpecialtyEntitySelected(this);
    }
    return orElse();
  }
}

abstract class _SignupSpecialtyEntitySelected implements AuthEvent {
  const factory _SignupSpecialtyEntitySelected(
    final SpecialtyEntity specialty,
  ) = _$SignupSpecialtyEntitySelectedImpl;

  SpecialtyEntity get specialty;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupSpecialtyEntitySelectedImplCopyWith<
    _$SignupSpecialtyEntitySelectedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupLocationEntitySelectedImplCopyWith<$Res> {
  factory _$$SignupLocationEntitySelectedImplCopyWith(
    _$SignupLocationEntitySelectedImpl value,
    $Res Function(_$SignupLocationEntitySelectedImpl) then,
  ) = __$$SignupLocationEntitySelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LocationEntity location});

  $LocationEntityCopyWith<$Res> get location;
}

/// @nodoc
class __$$SignupLocationEntitySelectedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupLocationEntitySelectedImpl>
    implements _$$SignupLocationEntitySelectedImplCopyWith<$Res> {
  __$$SignupLocationEntitySelectedImplCopyWithImpl(
    _$SignupLocationEntitySelectedImpl _value,
    $Res Function(_$SignupLocationEntitySelectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? location = null}) {
    return _then(
      _$SignupLocationEntitySelectedImpl(
        null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as LocationEntity,
      ),
    );
  }

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationEntityCopyWith<$Res> get location {
    return $LocationEntityCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value));
    });
  }
}

/// @nodoc

class _$SignupLocationEntitySelectedImpl
    implements _SignupLocationEntitySelected {
  const _$SignupLocationEntitySelectedImpl(this.location);

  @override
  final LocationEntity location;

  @override
  String toString() {
    return 'AuthEvent.signupLocationEntitySelected(location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupLocationEntitySelectedImpl &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupLocationEntitySelectedImplCopyWith<
    _$SignupLocationEntitySelectedImpl
  >
  get copyWith =>
      __$$SignupLocationEntitySelectedImplCopyWithImpl<
        _$SignupLocationEntitySelectedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupLocationEntitySelected(location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupLocationEntitySelected?.call(location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupLocationEntitySelected != null) {
      return signupLocationEntitySelected(location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupLocationEntitySelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupLocationEntitySelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupLocationEntitySelected != null) {
      return signupLocationEntitySelected(this);
    }
    return orElse();
  }
}

abstract class _SignupLocationEntitySelected implements AuthEvent {
  const factory _SignupLocationEntitySelected(final LocationEntity location) =
      _$SignupLocationEntitySelectedImpl;

  LocationEntity get location;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupLocationEntitySelectedImplCopyWith<
    _$SignupLocationEntitySelectedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupPlanEntitySelectedImplCopyWith<$Res> {
  factory _$$SignupPlanEntitySelectedImplCopyWith(
    _$SignupPlanEntitySelectedImpl value,
    $Res Function(_$SignupPlanEntitySelectedImpl) then,
  ) = __$$SignupPlanEntitySelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PlanEntity plan});

  $PlanEntityCopyWith<$Res> get plan;
}

/// @nodoc
class __$$SignupPlanEntitySelectedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupPlanEntitySelectedImpl>
    implements _$$SignupPlanEntitySelectedImplCopyWith<$Res> {
  __$$SignupPlanEntitySelectedImplCopyWithImpl(
    _$SignupPlanEntitySelectedImpl _value,
    $Res Function(_$SignupPlanEntitySelectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? plan = null}) {
    return _then(
      _$SignupPlanEntitySelectedImpl(
        null == plan
            ? _value.plan
            : plan // ignore: cast_nullable_to_non_nullable
                  as PlanEntity,
      ),
    );
  }

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlanEntityCopyWith<$Res> get plan {
    return $PlanEntityCopyWith<$Res>(_value.plan, (value) {
      return _then(_value.copyWith(plan: value));
    });
  }
}

/// @nodoc

class _$SignupPlanEntitySelectedImpl implements _SignupPlanEntitySelected {
  const _$SignupPlanEntitySelectedImpl(this.plan);

  @override
  final PlanEntity plan;

  @override
  String toString() {
    return 'AuthEvent.signupPlanEntitySelected(plan: $plan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupPlanEntitySelectedImpl &&
            (identical(other.plan, plan) || other.plan == plan));
  }

  @override
  int get hashCode => Object.hash(runtimeType, plan);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupPlanEntitySelectedImplCopyWith<_$SignupPlanEntitySelectedImpl>
  get copyWith =>
      __$$SignupPlanEntitySelectedImplCopyWithImpl<
        _$SignupPlanEntitySelectedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupPlanEntitySelected(plan);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupPlanEntitySelected?.call(plan);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupPlanEntitySelected != null) {
      return signupPlanEntitySelected(plan);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupPlanEntitySelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupPlanEntitySelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupPlanEntitySelected != null) {
      return signupPlanEntitySelected(this);
    }
    return orElse();
  }
}

abstract class _SignupPlanEntitySelected implements AuthEvent {
  const factory _SignupPlanEntitySelected(final PlanEntity plan) =
      _$SignupPlanEntitySelectedImpl;

  PlanEntity get plan;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupPlanEntitySelectedImplCopyWith<_$SignupPlanEntitySelectedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupClinicNameChangedImplCopyWith<$Res> {
  factory _$$SignupClinicNameChangedImplCopyWith(
    _$SignupClinicNameChangedImpl value,
    $Res Function(_$SignupClinicNameChangedImpl) then,
  ) = __$$SignupClinicNameChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$SignupClinicNameChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupClinicNameChangedImpl>
    implements _$$SignupClinicNameChangedImplCopyWith<$Res> {
  __$$SignupClinicNameChangedImplCopyWithImpl(
    _$SignupClinicNameChangedImpl _value,
    $Res Function(_$SignupClinicNameChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _$SignupClinicNameChangedImpl(
        null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SignupClinicNameChangedImpl implements _SignupClinicNameChanged {
  const _$SignupClinicNameChangedImpl(this.name);

  @override
  final String name;

  @override
  String toString() {
    return 'AuthEvent.signupClinicNameChanged(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupClinicNameChangedImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupClinicNameChangedImplCopyWith<_$SignupClinicNameChangedImpl>
  get copyWith =>
      __$$SignupClinicNameChangedImplCopyWithImpl<
        _$SignupClinicNameChangedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupClinicNameChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupClinicNameChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupClinicNameChanged != null) {
      return signupClinicNameChanged(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupClinicNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupClinicNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupClinicNameChanged != null) {
      return signupClinicNameChanged(this);
    }
    return orElse();
  }
}

abstract class _SignupClinicNameChanged implements AuthEvent {
  const factory _SignupClinicNameChanged(final String name) =
      _$SignupClinicNameChangedImpl;

  String get name;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupClinicNameChangedImplCopyWith<_$SignupClinicNameChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupClinicAddressChangedImplCopyWith<$Res> {
  factory _$$SignupClinicAddressChangedImplCopyWith(
    _$SignupClinicAddressChangedImpl value,
    $Res Function(_$SignupClinicAddressChangedImpl) then,
  ) = __$$SignupClinicAddressChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String address});
}

/// @nodoc
class __$$SignupClinicAddressChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupClinicAddressChangedImpl>
    implements _$$SignupClinicAddressChangedImplCopyWith<$Res> {
  __$$SignupClinicAddressChangedImplCopyWithImpl(
    _$SignupClinicAddressChangedImpl _value,
    $Res Function(_$SignupClinicAddressChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? address = null}) {
    return _then(
      _$SignupClinicAddressChangedImpl(
        null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SignupClinicAddressChangedImpl implements _SignupClinicAddressChanged {
  const _$SignupClinicAddressChangedImpl(this.address);

  @override
  final String address;

  @override
  String toString() {
    return 'AuthEvent.signupClinicAddressChanged(address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupClinicAddressChangedImpl &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupClinicAddressChangedImplCopyWith<_$SignupClinicAddressChangedImpl>
  get copyWith =>
      __$$SignupClinicAddressChangedImplCopyWithImpl<
        _$SignupClinicAddressChangedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupClinicAddressChanged(address);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupClinicAddressChanged?.call(address);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupClinicAddressChanged != null) {
      return signupClinicAddressChanged(address);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupClinicAddressChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupClinicAddressChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupClinicAddressChanged != null) {
      return signupClinicAddressChanged(this);
    }
    return orElse();
  }
}

abstract class _SignupClinicAddressChanged implements AuthEvent {
  const factory _SignupClinicAddressChanged(final String address) =
      _$SignupClinicAddressChangedImpl;

  String get address;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupClinicAddressChangedImplCopyWith<_$SignupClinicAddressChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupMobileNumberChangedImplCopyWith<$Res> {
  factory _$$SignupMobileNumberChangedImplCopyWith(
    _$SignupMobileNumberChangedImpl value,
    $Res Function(_$SignupMobileNumberChangedImpl) then,
  ) = __$$SignupMobileNumberChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String mobile});
}

/// @nodoc
class __$$SignupMobileNumberChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignupMobileNumberChangedImpl>
    implements _$$SignupMobileNumberChangedImplCopyWith<$Res> {
  __$$SignupMobileNumberChangedImplCopyWithImpl(
    _$SignupMobileNumberChangedImpl _value,
    $Res Function(_$SignupMobileNumberChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? mobile = null}) {
    return _then(
      _$SignupMobileNumberChangedImpl(
        null == mobile
            ? _value.mobile
            : mobile // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SignupMobileNumberChangedImpl implements _SignupMobileNumberChanged {
  const _$SignupMobileNumberChangedImpl(this.mobile);

  @override
  final String mobile;

  @override
  String toString() {
    return 'AuthEvent.signupMobileNumberChanged(mobile: $mobile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupMobileNumberChangedImpl &&
            (identical(other.mobile, mobile) || other.mobile == mobile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mobile);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupMobileNumberChangedImplCopyWith<_$SignupMobileNumberChangedImpl>
  get copyWith =>
      __$$SignupMobileNumberChangedImplCopyWithImpl<
        _$SignupMobileNumberChangedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return signupMobileNumberChanged(mobile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return signupMobileNumberChanged?.call(mobile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupMobileNumberChanged != null) {
      return signupMobileNumberChanged(mobile);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return signupMobileNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return signupMobileNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (signupMobileNumberChanged != null) {
      return signupMobileNumberChanged(this);
    }
    return orElse();
  }
}

abstract class _SignupMobileNumberChanged implements AuthEvent {
  const factory _SignupMobileNumberChanged(final String mobile) =
      _$SignupMobileNumberChangedImpl;

  String get mobile;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupMobileNumberChangedImplCopyWith<_$SignupMobileNumberChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtpRequestedImplCopyWith<$Res> {
  factory _$$OtpRequestedImplCopyWith(
    _$OtpRequestedImpl value,
    $Res Function(_$OtpRequestedImpl) then,
  ) = __$$OtpRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtpRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$OtpRequestedImpl>
    implements _$$OtpRequestedImplCopyWith<$Res> {
  __$$OtpRequestedImplCopyWithImpl(
    _$OtpRequestedImpl _value,
    $Res Function(_$OtpRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OtpRequestedImpl implements _OtpRequested {
  const _$OtpRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.otpRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtpRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return otpRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return otpRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (otpRequested != null) {
      return otpRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return otpRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return otpRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (otpRequested != null) {
      return otpRequested(this);
    }
    return orElse();
  }
}

abstract class _OtpRequested implements AuthEvent {
  const factory _OtpRequested() = _$OtpRequestedImpl;
}

/// @nodoc
abstract class _$$OtpCodeChangedImplCopyWith<$Res> {
  factory _$$OtpCodeChangedImplCopyWith(
    _$OtpCodeChangedImpl value,
    $Res Function(_$OtpCodeChangedImpl) then,
  ) = __$$OtpCodeChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String code});
}

/// @nodoc
class __$$OtpCodeChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$OtpCodeChangedImpl>
    implements _$$OtpCodeChangedImplCopyWith<$Res> {
  __$$OtpCodeChangedImplCopyWithImpl(
    _$OtpCodeChangedImpl _value,
    $Res Function(_$OtpCodeChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? code = null}) {
    return _then(
      _$OtpCodeChangedImpl(
        null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$OtpCodeChangedImpl implements _OtpCodeChanged {
  const _$OtpCodeChangedImpl(this.code);

  @override
  final String code;

  @override
  String toString() {
    return 'AuthEvent.otpCodeChanged(code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpCodeChangedImpl &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpCodeChangedImplCopyWith<_$OtpCodeChangedImpl> get copyWith =>
      __$$OtpCodeChangedImplCopyWithImpl<_$OtpCodeChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return otpCodeChanged(code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return otpCodeChanged?.call(code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (otpCodeChanged != null) {
      return otpCodeChanged(code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return otpCodeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return otpCodeChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (otpCodeChanged != null) {
      return otpCodeChanged(this);
    }
    return orElse();
  }
}

abstract class _OtpCodeChanged implements AuthEvent {
  const factory _OtpCodeChanged(final String code) = _$OtpCodeChangedImpl;

  String get code;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpCodeChangedImplCopyWith<_$OtpCodeChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtpVerifiedImplCopyWith<$Res> {
  factory _$$OtpVerifiedImplCopyWith(
    _$OtpVerifiedImpl value,
    $Res Function(_$OtpVerifiedImpl) then,
  ) = __$$OtpVerifiedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtpVerifiedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$OtpVerifiedImpl>
    implements _$$OtpVerifiedImplCopyWith<$Res> {
  __$$OtpVerifiedImplCopyWithImpl(
    _$OtpVerifiedImpl _value,
    $Res Function(_$OtpVerifiedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OtpVerifiedImpl implements _OtpVerified {
  const _$OtpVerifiedImpl();

  @override
  String toString() {
    return 'AuthEvent.otpVerified()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtpVerifiedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return otpVerified();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return otpVerified?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (otpVerified != null) {
      return otpVerified();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return otpVerified(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return otpVerified?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (otpVerified != null) {
      return otpVerified(this);
    }
    return orElse();
  }
}

abstract class _OtpVerified implements AuthEvent {
  const factory _OtpVerified() = _$OtpVerifiedImpl;
}

/// @nodoc
abstract class _$$OtpResendRequestedImplCopyWith<$Res> {
  factory _$$OtpResendRequestedImplCopyWith(
    _$OtpResendRequestedImpl value,
    $Res Function(_$OtpResendRequestedImpl) then,
  ) = __$$OtpResendRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtpResendRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$OtpResendRequestedImpl>
    implements _$$OtpResendRequestedImplCopyWith<$Res> {
  __$$OtpResendRequestedImplCopyWithImpl(
    _$OtpResendRequestedImpl _value,
    $Res Function(_$OtpResendRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OtpResendRequestedImpl implements _OtpResendRequested {
  const _$OtpResendRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.otpResendRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtpResendRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return otpResendRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return otpResendRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (otpResendRequested != null) {
      return otpResendRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return otpResendRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return otpResendRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (otpResendRequested != null) {
      return otpResendRequested(this);
    }
    return orElse();
  }
}

abstract class _OtpResendRequested implements AuthEvent {
  const factory _OtpResendRequested() = _$OtpResendRequestedImpl;
}

/// @nodoc
abstract class _$$ForgotPasswordEmailChangedImplCopyWith<$Res> {
  factory _$$ForgotPasswordEmailChangedImplCopyWith(
    _$ForgotPasswordEmailChangedImpl value,
    $Res Function(_$ForgotPasswordEmailChangedImpl) then,
  ) = __$$ForgotPasswordEmailChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$ForgotPasswordEmailChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$ForgotPasswordEmailChangedImpl>
    implements _$$ForgotPasswordEmailChangedImplCopyWith<$Res> {
  __$$ForgotPasswordEmailChangedImplCopyWithImpl(
    _$ForgotPasswordEmailChangedImpl _value,
    $Res Function(_$ForgotPasswordEmailChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _$ForgotPasswordEmailChangedImpl(
        null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ForgotPasswordEmailChangedImpl implements _ForgotPasswordEmailChanged {
  const _$ForgotPasswordEmailChangedImpl(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'AuthEvent.forgotPasswordEmailChanged(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordEmailChangedImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForgotPasswordEmailChangedImplCopyWith<_$ForgotPasswordEmailChangedImpl>
  get copyWith =>
      __$$ForgotPasswordEmailChangedImplCopyWithImpl<
        _$ForgotPasswordEmailChangedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return forgotPasswordEmailChanged(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return forgotPasswordEmailChanged?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (forgotPasswordEmailChanged != null) {
      return forgotPasswordEmailChanged(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return forgotPasswordEmailChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return forgotPasswordEmailChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (forgotPasswordEmailChanged != null) {
      return forgotPasswordEmailChanged(this);
    }
    return orElse();
  }
}

abstract class _ForgotPasswordEmailChanged implements AuthEvent {
  const factory _ForgotPasswordEmailChanged(final String email) =
      _$ForgotPasswordEmailChangedImpl;

  String get email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForgotPasswordEmailChangedImplCopyWith<_$ForgotPasswordEmailChangedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ForgotPasswordSubmittedImplCopyWith<$Res> {
  factory _$$ForgotPasswordSubmittedImplCopyWith(
    _$ForgotPasswordSubmittedImpl value,
    $Res Function(_$ForgotPasswordSubmittedImpl) then,
  ) = __$$ForgotPasswordSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ForgotPasswordSubmittedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$ForgotPasswordSubmittedImpl>
    implements _$$ForgotPasswordSubmittedImplCopyWith<$Res> {
  __$$ForgotPasswordSubmittedImplCopyWithImpl(
    _$ForgotPasswordSubmittedImpl _value,
    $Res Function(_$ForgotPasswordSubmittedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ForgotPasswordSubmittedImpl implements _ForgotPasswordSubmitted {
  const _$ForgotPasswordSubmittedImpl();

  @override
  String toString() {
    return 'AuthEvent.forgotPasswordSubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return forgotPasswordSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return forgotPasswordSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (forgotPasswordSubmitted != null) {
      return forgotPasswordSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return forgotPasswordSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return forgotPasswordSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (forgotPasswordSubmitted != null) {
      return forgotPasswordSubmitted(this);
    }
    return orElse();
  }
}

abstract class _ForgotPasswordSubmitted implements AuthEvent {
  const factory _ForgotPasswordSubmitted() = _$ForgotPasswordSubmittedImpl;
}

/// @nodoc
abstract class _$$ForgotPasswordResetImplCopyWith<$Res> {
  factory _$$ForgotPasswordResetImplCopyWith(
    _$ForgotPasswordResetImpl value,
    $Res Function(_$ForgotPasswordResetImpl) then,
  ) = __$$ForgotPasswordResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ForgotPasswordResetImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$ForgotPasswordResetImpl>
    implements _$$ForgotPasswordResetImplCopyWith<$Res> {
  __$$ForgotPasswordResetImplCopyWithImpl(
    _$ForgotPasswordResetImpl _value,
    $Res Function(_$ForgotPasswordResetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ForgotPasswordResetImpl implements _ForgotPasswordReset {
  const _$ForgotPasswordResetImpl();

  @override
  String toString() {
    return 'AuthEvent.forgotPasswordReset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return forgotPasswordReset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return forgotPasswordReset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (forgotPasswordReset != null) {
      return forgotPasswordReset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return forgotPasswordReset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return forgotPasswordReset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (forgotPasswordReset != null) {
      return forgotPasswordReset(this);
    }
    return orElse();
  }
}

abstract class _ForgotPasswordReset implements AuthEvent {
  const factory _ForgotPasswordReset() = _$ForgotPasswordResetImpl;
}

/// @nodoc
abstract class _$$ActiveClinicChangedImplCopyWith<$Res> {
  factory _$$ActiveClinicChangedImplCopyWith(
    _$ActiveClinicChangedImpl value,
    $Res Function(_$ActiveClinicChangedImpl) then,
  ) = __$$ActiveClinicChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? clinicId});
}

/// @nodoc
class __$$ActiveClinicChangedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$ActiveClinicChangedImpl>
    implements _$$ActiveClinicChangedImplCopyWith<$Res> {
  __$$ActiveClinicChangedImplCopyWithImpl(
    _$ActiveClinicChangedImpl _value,
    $Res Function(_$ActiveClinicChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clinicId = freezed}) {
    return _then(
      _$ActiveClinicChangedImpl(
        freezed == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ActiveClinicChangedImpl implements _ActiveClinicChanged {
  const _$ActiveClinicChangedImpl(this.clinicId);

  @override
  final String? clinicId;

  @override
  String toString() {
    return 'AuthEvent.activeClinicChanged(clinicId: $clinicId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveClinicChangedImpl &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clinicId);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveClinicChangedImplCopyWith<_$ActiveClinicChangedImpl> get copyWith =>
      __$$ActiveClinicChangedImplCopyWithImpl<_$ActiveClinicChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return activeClinicChanged(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return activeClinicChanged?.call(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (activeClinicChanged != null) {
      return activeClinicChanged(clinicId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return activeClinicChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return activeClinicChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (activeClinicChanged != null) {
      return activeClinicChanged(this);
    }
    return orElse();
  }
}

abstract class _ActiveClinicChanged implements AuthEvent {
  const factory _ActiveClinicChanged(final String? clinicId) =
      _$ActiveClinicChangedImpl;

  String? get clinicId;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveClinicChangedImplCopyWith<_$ActiveClinicChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthCheckRequestedImplCopyWith<$Res> {
  factory _$$AuthCheckRequestedImplCopyWith(
    _$AuthCheckRequestedImpl value,
    $Res Function(_$AuthCheckRequestedImpl) then,
  ) = __$$AuthCheckRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthCheckRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthCheckRequestedImpl>
    implements _$$AuthCheckRequestedImplCopyWith<$Res> {
  __$$AuthCheckRequestedImplCopyWithImpl(
    _$AuthCheckRequestedImpl _value,
    $Res Function(_$AuthCheckRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthCheckRequestedImpl implements _AuthCheckRequested {
  const _$AuthCheckRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.authCheckRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthCheckRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return authCheckRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return authCheckRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (authCheckRequested != null) {
      return authCheckRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return authCheckRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return authCheckRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (authCheckRequested != null) {
      return authCheckRequested(this);
    }
    return orElse();
  }
}

abstract class _AuthCheckRequested implements AuthEvent {
  const factory _AuthCheckRequested() = _$AuthCheckRequestedImpl;
}

/// @nodoc
abstract class _$$LogoutRequestedImplCopyWith<$Res> {
  factory _$$LogoutRequestedImplCopyWith(
    _$LogoutRequestedImpl value,
    $Res Function(_$LogoutRequestedImpl) then,
  ) = __$$LogoutRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogoutRequestedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LogoutRequestedImpl>
    implements _$$LogoutRequestedImplCopyWith<$Res> {
  __$$LogoutRequestedImplCopyWithImpl(
    _$LogoutRequestedImpl _value,
    $Res Function(_$LogoutRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LogoutRequestedImpl implements _LogoutRequested {
  const _$LogoutRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.logoutRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LogoutRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) loginEmailChanged,
    required TResult Function(String password) loginPasswordChanged,
    required TResult Function() loginPasswordVisibilityToggled,
    required TResult Function() loginSubmitted,
    required TResult Function(String name) signupNameChanged,
    required TResult Function(String email) signupEmailChanged,
    required TResult Function(String password) signupPasswordChanged,
    required TResult Function(String confirmPassword)
    signupConfirmPasswordChanged,
    required TResult Function() signupPasswordVisibilityToggled,
    required TResult Function() signupConfirmPasswordVisibilityToggled,
    required TResult Function() signupSubmitted,
    required TResult Function() signupFormReset,
    required TResult Function(String licenseNumber) signupLicenseNumberChanged,
    required TResult Function(String specialization)
    signupSpecializationChanged,
    required TResult Function(String location) signupLocationChanged,
    required TResult Function() specialtiesRequested,
    required TResult Function() plansRequested,
    required TResult Function(String query, String countryCode)
    locationSearchRequested,
    required TResult Function(SpecialtyEntity specialty)
    signupSpecialtyEntitySelected,
    required TResult Function(LocationEntity location)
    signupLocationEntitySelected,
    required TResult Function(PlanEntity plan) signupPlanEntitySelected,
    required TResult Function(String name) signupClinicNameChanged,
    required TResult Function(String address) signupClinicAddressChanged,
    required TResult Function(String mobile) signupMobileNumberChanged,
    required TResult Function() otpRequested,
    required TResult Function(String code) otpCodeChanged,
    required TResult Function() otpVerified,
    required TResult Function() otpResendRequested,
    required TResult Function(String email) forgotPasswordEmailChanged,
    required TResult Function() forgotPasswordSubmitted,
    required TResult Function() forgotPasswordReset,
    required TResult Function(String? clinicId) activeClinicChanged,
    required TResult Function() authCheckRequested,
    required TResult Function() logoutRequested,
  }) {
    return logoutRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? loginEmailChanged,
    TResult? Function(String password)? loginPasswordChanged,
    TResult? Function()? loginPasswordVisibilityToggled,
    TResult? Function()? loginSubmitted,
    TResult? Function(String name)? signupNameChanged,
    TResult? Function(String email)? signupEmailChanged,
    TResult? Function(String password)? signupPasswordChanged,
    TResult? Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult? Function()? signupPasswordVisibilityToggled,
    TResult? Function()? signupConfirmPasswordVisibilityToggled,
    TResult? Function()? signupSubmitted,
    TResult? Function()? signupFormReset,
    TResult? Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult? Function(String specialization)? signupSpecializationChanged,
    TResult? Function(String location)? signupLocationChanged,
    TResult? Function()? specialtiesRequested,
    TResult? Function()? plansRequested,
    TResult? Function(String query, String countryCode)?
    locationSearchRequested,
    TResult? Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult? Function(LocationEntity location)? signupLocationEntitySelected,
    TResult? Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult? Function(String name)? signupClinicNameChanged,
    TResult? Function(String address)? signupClinicAddressChanged,
    TResult? Function(String mobile)? signupMobileNumberChanged,
    TResult? Function()? otpRequested,
    TResult? Function(String code)? otpCodeChanged,
    TResult? Function()? otpVerified,
    TResult? Function()? otpResendRequested,
    TResult? Function(String email)? forgotPasswordEmailChanged,
    TResult? Function()? forgotPasswordSubmitted,
    TResult? Function()? forgotPasswordReset,
    TResult? Function(String? clinicId)? activeClinicChanged,
    TResult? Function()? authCheckRequested,
    TResult? Function()? logoutRequested,
  }) {
    return logoutRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? loginEmailChanged,
    TResult Function(String password)? loginPasswordChanged,
    TResult Function()? loginPasswordVisibilityToggled,
    TResult Function()? loginSubmitted,
    TResult Function(String name)? signupNameChanged,
    TResult Function(String email)? signupEmailChanged,
    TResult Function(String password)? signupPasswordChanged,
    TResult Function(String confirmPassword)? signupConfirmPasswordChanged,
    TResult Function()? signupPasswordVisibilityToggled,
    TResult Function()? signupConfirmPasswordVisibilityToggled,
    TResult Function()? signupSubmitted,
    TResult Function()? signupFormReset,
    TResult Function(String licenseNumber)? signupLicenseNumberChanged,
    TResult Function(String specialization)? signupSpecializationChanged,
    TResult Function(String location)? signupLocationChanged,
    TResult Function()? specialtiesRequested,
    TResult Function()? plansRequested,
    TResult Function(String query, String countryCode)? locationSearchRequested,
    TResult Function(SpecialtyEntity specialty)? signupSpecialtyEntitySelected,
    TResult Function(LocationEntity location)? signupLocationEntitySelected,
    TResult Function(PlanEntity plan)? signupPlanEntitySelected,
    TResult Function(String name)? signupClinicNameChanged,
    TResult Function(String address)? signupClinicAddressChanged,
    TResult Function(String mobile)? signupMobileNumberChanged,
    TResult Function()? otpRequested,
    TResult Function(String code)? otpCodeChanged,
    TResult Function()? otpVerified,
    TResult Function()? otpResendRequested,
    TResult Function(String email)? forgotPasswordEmailChanged,
    TResult Function()? forgotPasswordSubmitted,
    TResult Function()? forgotPasswordReset,
    TResult Function(String? clinicId)? activeClinicChanged,
    TResult Function()? authCheckRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (logoutRequested != null) {
      return logoutRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginEmailChanged value) loginEmailChanged,
    required TResult Function(_LoginPasswordChanged value) loginPasswordChanged,
    required TResult Function(_LoginPasswordVisibilityToggled value)
    loginPasswordVisibilityToggled,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_SignupNameChanged value) signupNameChanged,
    required TResult Function(_SignupEmailChanged value) signupEmailChanged,
    required TResult Function(_SignupPasswordChanged value)
    signupPasswordChanged,
    required TResult Function(_SignupConfirmPasswordChanged value)
    signupConfirmPasswordChanged,
    required TResult Function(_SignupPasswordVisibilityToggled value)
    signupPasswordVisibilityToggled,
    required TResult Function(_SignupConfirmPasswordVisibilityToggled value)
    signupConfirmPasswordVisibilityToggled,
    required TResult Function(_SignupSubmitted value) signupSubmitted,
    required TResult Function(_SignupFormReset value) signupFormReset,
    required TResult Function(_SignupLicenseNumberChanged value)
    signupLicenseNumberChanged,
    required TResult Function(_SignupSpecializationChanged value)
    signupSpecializationChanged,
    required TResult Function(_SignupLocationChanged value)
    signupLocationChanged,
    required TResult Function(_SpecialtiesRequested value) specialtiesRequested,
    required TResult Function(_PlansRequested value) plansRequested,
    required TResult Function(_LocationSearchRequested value)
    locationSearchRequested,
    required TResult Function(_SignupSpecialtyEntitySelected value)
    signupSpecialtyEntitySelected,
    required TResult Function(_SignupLocationEntitySelected value)
    signupLocationEntitySelected,
    required TResult Function(_SignupPlanEntitySelected value)
    signupPlanEntitySelected,
    required TResult Function(_SignupClinicNameChanged value)
    signupClinicNameChanged,
    required TResult Function(_SignupClinicAddressChanged value)
    signupClinicAddressChanged,
    required TResult Function(_SignupMobileNumberChanged value)
    signupMobileNumberChanged,
    required TResult Function(_OtpRequested value) otpRequested,
    required TResult Function(_OtpCodeChanged value) otpCodeChanged,
    required TResult Function(_OtpVerified value) otpVerified,
    required TResult Function(_OtpResendRequested value) otpResendRequested,
    required TResult Function(_ForgotPasswordEmailChanged value)
    forgotPasswordEmailChanged,
    required TResult Function(_ForgotPasswordSubmitted value)
    forgotPasswordSubmitted,
    required TResult Function(_ForgotPasswordReset value) forgotPasswordReset,
    required TResult Function(_ActiveClinicChanged value) activeClinicChanged,
    required TResult Function(_AuthCheckRequested value) authCheckRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return logoutRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult? Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult? Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_SignupNameChanged value)? signupNameChanged,
    TResult? Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult? Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult? Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult? Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult? Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult? Function(_SignupSubmitted value)? signupSubmitted,
    TResult? Function(_SignupFormReset value)? signupFormReset,
    TResult? Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult? Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult? Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult? Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult? Function(_PlansRequested value)? plansRequested,
    TResult? Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult? Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult? Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult? Function(_SignupPlanEntitySelected value)?
    signupPlanEntitySelected,
    TResult? Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult? Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult? Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult? Function(_OtpRequested value)? otpRequested,
    TResult? Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(_OtpVerified value)? otpVerified,
    TResult? Function(_OtpResendRequested value)? otpResendRequested,
    TResult? Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult? Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult? Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult? Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult? Function(_AuthCheckRequested value)? authCheckRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return logoutRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginEmailChanged value)? loginEmailChanged,
    TResult Function(_LoginPasswordChanged value)? loginPasswordChanged,
    TResult Function(_LoginPasswordVisibilityToggled value)?
    loginPasswordVisibilityToggled,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_SignupNameChanged value)? signupNameChanged,
    TResult Function(_SignupEmailChanged value)? signupEmailChanged,
    TResult Function(_SignupPasswordChanged value)? signupPasswordChanged,
    TResult Function(_SignupConfirmPasswordChanged value)?
    signupConfirmPasswordChanged,
    TResult Function(_SignupPasswordVisibilityToggled value)?
    signupPasswordVisibilityToggled,
    TResult Function(_SignupConfirmPasswordVisibilityToggled value)?
    signupConfirmPasswordVisibilityToggled,
    TResult Function(_SignupSubmitted value)? signupSubmitted,
    TResult Function(_SignupFormReset value)? signupFormReset,
    TResult Function(_SignupLicenseNumberChanged value)?
    signupLicenseNumberChanged,
    TResult Function(_SignupSpecializationChanged value)?
    signupSpecializationChanged,
    TResult Function(_SignupLocationChanged value)? signupLocationChanged,
    TResult Function(_SpecialtiesRequested value)? specialtiesRequested,
    TResult Function(_PlansRequested value)? plansRequested,
    TResult Function(_LocationSearchRequested value)? locationSearchRequested,
    TResult Function(_SignupSpecialtyEntitySelected value)?
    signupSpecialtyEntitySelected,
    TResult Function(_SignupLocationEntitySelected value)?
    signupLocationEntitySelected,
    TResult Function(_SignupPlanEntitySelected value)? signupPlanEntitySelected,
    TResult Function(_SignupClinicNameChanged value)? signupClinicNameChanged,
    TResult Function(_SignupClinicAddressChanged value)?
    signupClinicAddressChanged,
    TResult Function(_SignupMobileNumberChanged value)?
    signupMobileNumberChanged,
    TResult Function(_OtpRequested value)? otpRequested,
    TResult Function(_OtpCodeChanged value)? otpCodeChanged,
    TResult Function(_OtpVerified value)? otpVerified,
    TResult Function(_OtpResendRequested value)? otpResendRequested,
    TResult Function(_ForgotPasswordEmailChanged value)?
    forgotPasswordEmailChanged,
    TResult Function(_ForgotPasswordSubmitted value)? forgotPasswordSubmitted,
    TResult Function(_ForgotPasswordReset value)? forgotPasswordReset,
    TResult Function(_ActiveClinicChanged value)? activeClinicChanged,
    TResult Function(_AuthCheckRequested value)? authCheckRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (logoutRequested != null) {
      return logoutRequested(this);
    }
    return orElse();
  }
}

abstract class _LogoutRequested implements AuthEvent {
  const factory _LogoutRequested() = _$LogoutRequestedImpl;
}

/// @nodoc
mixin _$AuthState {
  // Login fields
  String get loginEmail => throw _privateConstructorUsedError;
  String get loginPassword => throw _privateConstructorUsedError;
  bool get isLoginPasswordVisible => throw _privateConstructorUsedError;
  bool get isLoginLoading => throw _privateConstructorUsedError;
  String? get loginError =>
      throw _privateConstructorUsedError; // Signup fields - Unified (all users are dental professionals)
  String get signupName => throw _privateConstructorUsedError;
  String get signupEmail => throw _privateConstructorUsedError;
  String get signupPassword => throw _privateConstructorUsedError;
  String get signupConfirmPassword => throw _privateConstructorUsedError;
  bool get isSignupPasswordVisible => throw _privateConstructorUsedError;
  bool get isSignupConfirmPasswordVisible => throw _privateConstructorUsedError;
  bool get isSignupLoading => throw _privateConstructorUsedError;
  String? get signupError =>
      throw _privateConstructorUsedError; // Optional professional fields
  String get signupLicenseNumber => throw _privateConstructorUsedError;
  String get signupSpecialization => throw _privateConstructorUsedError;
  String get signupLocation =>
      throw _privateConstructorUsedError; // API fetched data
  List<SpecialtyEntity> get specialties => throw _privateConstructorUsedError;
  List<LocationEntity> get searchedLocations =>
      throw _privateConstructorUsedError;
  List<PlanEntity> get plans =>
      throw _privateConstructorUsedError; // API loading states
  bool get isLoadingSpecialties => throw _privateConstructorUsedError;
  bool get isLoadingPlans => throw _privateConstructorUsedError;
  bool get isSearchingLocations =>
      throw _privateConstructorUsedError; // Selected entities for registration
  SpecialtyEntity? get selectedSpecialty => throw _privateConstructorUsedError;
  LocationEntity? get selectedLocation => throw _privateConstructorUsedError;
  PlanEntity? get selectedPlan =>
      throw _privateConstructorUsedError; // Clinic information for registration
  String get clinicName => throw _privateConstructorUsedError;
  String get clinicAddress => throw _privateConstructorUsedError;
  String get mobileNumber =>
      throw _privateConstructorUsedError; // OTP verification fields
  String get otpCode => throw _privateConstructorUsedError;
  bool get isOtpLoading => throw _privateConstructorUsedError;
  bool get isOtpVerifying => throw _privateConstructorUsedError;
  String? get otpError => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;
  int get otpSecondsRemaining => throw _privateConstructorUsedError;
  bool get canResendOtp =>
      throw _privateConstructorUsedError; // Forgot password fields
  String get forgotPasswordEmail => throw _privateConstructorUsedError;
  bool get isForgotPasswordLoading => throw _privateConstructorUsedError;
  bool get isForgotPasswordSuccess => throw _privateConstructorUsedError;
  String? get forgotPasswordError =>
      throw _privateConstructorUsedError; // Authenticated user data
  UserEntity? get currentUser => throw _privateConstructorUsedError;
  List<ClinicMembershipEntity> get memberships =>
      throw _privateConstructorUsedError;
  List<InvitationEntity> get pendingInvitations =>
      throw _privateConstructorUsedError;
  String? get activeClinicId =>
      throw _privateConstructorUsedError; // Auth status
  AuthStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({
    String loginEmail,
    String loginPassword,
    bool isLoginPasswordVisible,
    bool isLoginLoading,
    String? loginError,
    String signupName,
    String signupEmail,
    String signupPassword,
    String signupConfirmPassword,
    bool isSignupPasswordVisible,
    bool isSignupConfirmPasswordVisible,
    bool isSignupLoading,
    String? signupError,
    String signupLicenseNumber,
    String signupSpecialization,
    String signupLocation,
    List<SpecialtyEntity> specialties,
    List<LocationEntity> searchedLocations,
    List<PlanEntity> plans,
    bool isLoadingSpecialties,
    bool isLoadingPlans,
    bool isSearchingLocations,
    SpecialtyEntity? selectedSpecialty,
    LocationEntity? selectedLocation,
    PlanEntity? selectedPlan,
    String clinicName,
    String clinicAddress,
    String mobileNumber,
    String otpCode,
    bool isOtpLoading,
    bool isOtpVerifying,
    String? otpError,
    String? sessionId,
    int otpSecondsRemaining,
    bool canResendOtp,
    String forgotPasswordEmail,
    bool isForgotPasswordLoading,
    bool isForgotPasswordSuccess,
    String? forgotPasswordError,
    UserEntity? currentUser,
    List<ClinicMembershipEntity> memberships,
    List<InvitationEntity> pendingInvitations,
    String? activeClinicId,
    AuthStatus status,
  });

  $SpecialtyEntityCopyWith<$Res>? get selectedSpecialty;
  $LocationEntityCopyWith<$Res>? get selectedLocation;
  $PlanEntityCopyWith<$Res>? get selectedPlan;
  $UserEntityCopyWith<$Res>? get currentUser;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loginEmail = null,
    Object? loginPassword = null,
    Object? isLoginPasswordVisible = null,
    Object? isLoginLoading = null,
    Object? loginError = freezed,
    Object? signupName = null,
    Object? signupEmail = null,
    Object? signupPassword = null,
    Object? signupConfirmPassword = null,
    Object? isSignupPasswordVisible = null,
    Object? isSignupConfirmPasswordVisible = null,
    Object? isSignupLoading = null,
    Object? signupError = freezed,
    Object? signupLicenseNumber = null,
    Object? signupSpecialization = null,
    Object? signupLocation = null,
    Object? specialties = null,
    Object? searchedLocations = null,
    Object? plans = null,
    Object? isLoadingSpecialties = null,
    Object? isLoadingPlans = null,
    Object? isSearchingLocations = null,
    Object? selectedSpecialty = freezed,
    Object? selectedLocation = freezed,
    Object? selectedPlan = freezed,
    Object? clinicName = null,
    Object? clinicAddress = null,
    Object? mobileNumber = null,
    Object? otpCode = null,
    Object? isOtpLoading = null,
    Object? isOtpVerifying = null,
    Object? otpError = freezed,
    Object? sessionId = freezed,
    Object? otpSecondsRemaining = null,
    Object? canResendOtp = null,
    Object? forgotPasswordEmail = null,
    Object? isForgotPasswordLoading = null,
    Object? isForgotPasswordSuccess = null,
    Object? forgotPasswordError = freezed,
    Object? currentUser = freezed,
    Object? memberships = null,
    Object? pendingInvitations = null,
    Object? activeClinicId = freezed,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            loginEmail: null == loginEmail
                ? _value.loginEmail
                : loginEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            loginPassword: null == loginPassword
                ? _value.loginPassword
                : loginPassword // ignore: cast_nullable_to_non_nullable
                      as String,
            isLoginPasswordVisible: null == isLoginPasswordVisible
                ? _value.isLoginPasswordVisible
                : isLoginPasswordVisible // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoginLoading: null == isLoginLoading
                ? _value.isLoginLoading
                : isLoginLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            loginError: freezed == loginError
                ? _value.loginError
                : loginError // ignore: cast_nullable_to_non_nullable
                      as String?,
            signupName: null == signupName
                ? _value.signupName
                : signupName // ignore: cast_nullable_to_non_nullable
                      as String,
            signupEmail: null == signupEmail
                ? _value.signupEmail
                : signupEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            signupPassword: null == signupPassword
                ? _value.signupPassword
                : signupPassword // ignore: cast_nullable_to_non_nullable
                      as String,
            signupConfirmPassword: null == signupConfirmPassword
                ? _value.signupConfirmPassword
                : signupConfirmPassword // ignore: cast_nullable_to_non_nullable
                      as String,
            isSignupPasswordVisible: null == isSignupPasswordVisible
                ? _value.isSignupPasswordVisible
                : isSignupPasswordVisible // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSignupConfirmPasswordVisible:
                null == isSignupConfirmPasswordVisible
                ? _value.isSignupConfirmPasswordVisible
                : isSignupConfirmPasswordVisible // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSignupLoading: null == isSignupLoading
                ? _value.isSignupLoading
                : isSignupLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            signupError: freezed == signupError
                ? _value.signupError
                : signupError // ignore: cast_nullable_to_non_nullable
                      as String?,
            signupLicenseNumber: null == signupLicenseNumber
                ? _value.signupLicenseNumber
                : signupLicenseNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            signupSpecialization: null == signupSpecialization
                ? _value.signupSpecialization
                : signupSpecialization // ignore: cast_nullable_to_non_nullable
                      as String,
            signupLocation: null == signupLocation
                ? _value.signupLocation
                : signupLocation // ignore: cast_nullable_to_non_nullable
                      as String,
            specialties: null == specialties
                ? _value.specialties
                : specialties // ignore: cast_nullable_to_non_nullable
                      as List<SpecialtyEntity>,
            searchedLocations: null == searchedLocations
                ? _value.searchedLocations
                : searchedLocations // ignore: cast_nullable_to_non_nullable
                      as List<LocationEntity>,
            plans: null == plans
                ? _value.plans
                : plans // ignore: cast_nullable_to_non_nullable
                      as List<PlanEntity>,
            isLoadingSpecialties: null == isLoadingSpecialties
                ? _value.isLoadingSpecialties
                : isLoadingSpecialties // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingPlans: null == isLoadingPlans
                ? _value.isLoadingPlans
                : isLoadingPlans // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSearchingLocations: null == isSearchingLocations
                ? _value.isSearchingLocations
                : isSearchingLocations // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedSpecialty: freezed == selectedSpecialty
                ? _value.selectedSpecialty
                : selectedSpecialty // ignore: cast_nullable_to_non_nullable
                      as SpecialtyEntity?,
            selectedLocation: freezed == selectedLocation
                ? _value.selectedLocation
                : selectedLocation // ignore: cast_nullable_to_non_nullable
                      as LocationEntity?,
            selectedPlan: freezed == selectedPlan
                ? _value.selectedPlan
                : selectedPlan // ignore: cast_nullable_to_non_nullable
                      as PlanEntity?,
            clinicName: null == clinicName
                ? _value.clinicName
                : clinicName // ignore: cast_nullable_to_non_nullable
                      as String,
            clinicAddress: null == clinicAddress
                ? _value.clinicAddress
                : clinicAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            mobileNumber: null == mobileNumber
                ? _value.mobileNumber
                : mobileNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            otpCode: null == otpCode
                ? _value.otpCode
                : otpCode // ignore: cast_nullable_to_non_nullable
                      as String,
            isOtpLoading: null == isOtpLoading
                ? _value.isOtpLoading
                : isOtpLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isOtpVerifying: null == isOtpVerifying
                ? _value.isOtpVerifying
                : isOtpVerifying // ignore: cast_nullable_to_non_nullable
                      as bool,
            otpError: freezed == otpError
                ? _value.otpError
                : otpError // ignore: cast_nullable_to_non_nullable
                      as String?,
            sessionId: freezed == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            otpSecondsRemaining: null == otpSecondsRemaining
                ? _value.otpSecondsRemaining
                : otpSecondsRemaining // ignore: cast_nullable_to_non_nullable
                      as int,
            canResendOtp: null == canResendOtp
                ? _value.canResendOtp
                : canResendOtp // ignore: cast_nullable_to_non_nullable
                      as bool,
            forgotPasswordEmail: null == forgotPasswordEmail
                ? _value.forgotPasswordEmail
                : forgotPasswordEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            isForgotPasswordLoading: null == isForgotPasswordLoading
                ? _value.isForgotPasswordLoading
                : isForgotPasswordLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isForgotPasswordSuccess: null == isForgotPasswordSuccess
                ? _value.isForgotPasswordSuccess
                : isForgotPasswordSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            forgotPasswordError: freezed == forgotPasswordError
                ? _value.forgotPasswordError
                : forgotPasswordError // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentUser: freezed == currentUser
                ? _value.currentUser
                : currentUser // ignore: cast_nullable_to_non_nullable
                      as UserEntity?,
            memberships: null == memberships
                ? _value.memberships
                : memberships // ignore: cast_nullable_to_non_nullable
                      as List<ClinicMembershipEntity>,
            pendingInvitations: null == pendingInvitations
                ? _value.pendingInvitations
                : pendingInvitations // ignore: cast_nullable_to_non_nullable
                      as List<InvitationEntity>,
            activeClinicId: freezed == activeClinicId
                ? _value.activeClinicId
                : activeClinicId // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AuthStatus,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpecialtyEntityCopyWith<$Res>? get selectedSpecialty {
    if (_value.selectedSpecialty == null) {
      return null;
    }

    return $SpecialtyEntityCopyWith<$Res>(_value.selectedSpecialty!, (value) {
      return _then(_value.copyWith(selectedSpecialty: value) as $Val);
    });
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationEntityCopyWith<$Res>? get selectedLocation {
    if (_value.selectedLocation == null) {
      return null;
    }

    return $LocationEntityCopyWith<$Res>(_value.selectedLocation!, (value) {
      return _then(_value.copyWith(selectedLocation: value) as $Val);
    });
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlanEntityCopyWith<$Res>? get selectedPlan {
    if (_value.selectedPlan == null) {
      return null;
    }

    return $PlanEntityCopyWith<$Res>(_value.selectedPlan!, (value) {
      return _then(_value.copyWith(selectedPlan: value) as $Val);
    });
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res>? get currentUser {
    if (_value.currentUser == null) {
      return null;
    }

    return $UserEntityCopyWith<$Res>(_value.currentUser!, (value) {
      return _then(_value.copyWith(currentUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
    _$AuthStateImpl value,
    $Res Function(_$AuthStateImpl) then,
  ) = __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String loginEmail,
    String loginPassword,
    bool isLoginPasswordVisible,
    bool isLoginLoading,
    String? loginError,
    String signupName,
    String signupEmail,
    String signupPassword,
    String signupConfirmPassword,
    bool isSignupPasswordVisible,
    bool isSignupConfirmPasswordVisible,
    bool isSignupLoading,
    String? signupError,
    String signupLicenseNumber,
    String signupSpecialization,
    String signupLocation,
    List<SpecialtyEntity> specialties,
    List<LocationEntity> searchedLocations,
    List<PlanEntity> plans,
    bool isLoadingSpecialties,
    bool isLoadingPlans,
    bool isSearchingLocations,
    SpecialtyEntity? selectedSpecialty,
    LocationEntity? selectedLocation,
    PlanEntity? selectedPlan,
    String clinicName,
    String clinicAddress,
    String mobileNumber,
    String otpCode,
    bool isOtpLoading,
    bool isOtpVerifying,
    String? otpError,
    String? sessionId,
    int otpSecondsRemaining,
    bool canResendOtp,
    String forgotPasswordEmail,
    bool isForgotPasswordLoading,
    bool isForgotPasswordSuccess,
    String? forgotPasswordError,
    UserEntity? currentUser,
    List<ClinicMembershipEntity> memberships,
    List<InvitationEntity> pendingInvitations,
    String? activeClinicId,
    AuthStatus status,
  });

  @override
  $SpecialtyEntityCopyWith<$Res>? get selectedSpecialty;
  @override
  $LocationEntityCopyWith<$Res>? get selectedLocation;
  @override
  $PlanEntityCopyWith<$Res>? get selectedPlan;
  @override
  $UserEntityCopyWith<$Res>? get currentUser;
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
    _$AuthStateImpl _value,
    $Res Function(_$AuthStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loginEmail = null,
    Object? loginPassword = null,
    Object? isLoginPasswordVisible = null,
    Object? isLoginLoading = null,
    Object? loginError = freezed,
    Object? signupName = null,
    Object? signupEmail = null,
    Object? signupPassword = null,
    Object? signupConfirmPassword = null,
    Object? isSignupPasswordVisible = null,
    Object? isSignupConfirmPasswordVisible = null,
    Object? isSignupLoading = null,
    Object? signupError = freezed,
    Object? signupLicenseNumber = null,
    Object? signupSpecialization = null,
    Object? signupLocation = null,
    Object? specialties = null,
    Object? searchedLocations = null,
    Object? plans = null,
    Object? isLoadingSpecialties = null,
    Object? isLoadingPlans = null,
    Object? isSearchingLocations = null,
    Object? selectedSpecialty = freezed,
    Object? selectedLocation = freezed,
    Object? selectedPlan = freezed,
    Object? clinicName = null,
    Object? clinicAddress = null,
    Object? mobileNumber = null,
    Object? otpCode = null,
    Object? isOtpLoading = null,
    Object? isOtpVerifying = null,
    Object? otpError = freezed,
    Object? sessionId = freezed,
    Object? otpSecondsRemaining = null,
    Object? canResendOtp = null,
    Object? forgotPasswordEmail = null,
    Object? isForgotPasswordLoading = null,
    Object? isForgotPasswordSuccess = null,
    Object? forgotPasswordError = freezed,
    Object? currentUser = freezed,
    Object? memberships = null,
    Object? pendingInvitations = null,
    Object? activeClinicId = freezed,
    Object? status = null,
  }) {
    return _then(
      _$AuthStateImpl(
        loginEmail: null == loginEmail
            ? _value.loginEmail
            : loginEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        loginPassword: null == loginPassword
            ? _value.loginPassword
            : loginPassword // ignore: cast_nullable_to_non_nullable
                  as String,
        isLoginPasswordVisible: null == isLoginPasswordVisible
            ? _value.isLoginPasswordVisible
            : isLoginPasswordVisible // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoginLoading: null == isLoginLoading
            ? _value.isLoginLoading
            : isLoginLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        loginError: freezed == loginError
            ? _value.loginError
            : loginError // ignore: cast_nullable_to_non_nullable
                  as String?,
        signupName: null == signupName
            ? _value.signupName
            : signupName // ignore: cast_nullable_to_non_nullable
                  as String,
        signupEmail: null == signupEmail
            ? _value.signupEmail
            : signupEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        signupPassword: null == signupPassword
            ? _value.signupPassword
            : signupPassword // ignore: cast_nullable_to_non_nullable
                  as String,
        signupConfirmPassword: null == signupConfirmPassword
            ? _value.signupConfirmPassword
            : signupConfirmPassword // ignore: cast_nullable_to_non_nullable
                  as String,
        isSignupPasswordVisible: null == isSignupPasswordVisible
            ? _value.isSignupPasswordVisible
            : isSignupPasswordVisible // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSignupConfirmPasswordVisible: null == isSignupConfirmPasswordVisible
            ? _value.isSignupConfirmPasswordVisible
            : isSignupConfirmPasswordVisible // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSignupLoading: null == isSignupLoading
            ? _value.isSignupLoading
            : isSignupLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        signupError: freezed == signupError
            ? _value.signupError
            : signupError // ignore: cast_nullable_to_non_nullable
                  as String?,
        signupLicenseNumber: null == signupLicenseNumber
            ? _value.signupLicenseNumber
            : signupLicenseNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        signupSpecialization: null == signupSpecialization
            ? _value.signupSpecialization
            : signupSpecialization // ignore: cast_nullable_to_non_nullable
                  as String,
        signupLocation: null == signupLocation
            ? _value.signupLocation
            : signupLocation // ignore: cast_nullable_to_non_nullable
                  as String,
        specialties: null == specialties
            ? _value._specialties
            : specialties // ignore: cast_nullable_to_non_nullable
                  as List<SpecialtyEntity>,
        searchedLocations: null == searchedLocations
            ? _value._searchedLocations
            : searchedLocations // ignore: cast_nullable_to_non_nullable
                  as List<LocationEntity>,
        plans: null == plans
            ? _value._plans
            : plans // ignore: cast_nullable_to_non_nullable
                  as List<PlanEntity>,
        isLoadingSpecialties: null == isLoadingSpecialties
            ? _value.isLoadingSpecialties
            : isLoadingSpecialties // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingPlans: null == isLoadingPlans
            ? _value.isLoadingPlans
            : isLoadingPlans // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSearchingLocations: null == isSearchingLocations
            ? _value.isSearchingLocations
            : isSearchingLocations // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedSpecialty: freezed == selectedSpecialty
            ? _value.selectedSpecialty
            : selectedSpecialty // ignore: cast_nullable_to_non_nullable
                  as SpecialtyEntity?,
        selectedLocation: freezed == selectedLocation
            ? _value.selectedLocation
            : selectedLocation // ignore: cast_nullable_to_non_nullable
                  as LocationEntity?,
        selectedPlan: freezed == selectedPlan
            ? _value.selectedPlan
            : selectedPlan // ignore: cast_nullable_to_non_nullable
                  as PlanEntity?,
        clinicName: null == clinicName
            ? _value.clinicName
            : clinicName // ignore: cast_nullable_to_non_nullable
                  as String,
        clinicAddress: null == clinicAddress
            ? _value.clinicAddress
            : clinicAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        mobileNumber: null == mobileNumber
            ? _value.mobileNumber
            : mobileNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        otpCode: null == otpCode
            ? _value.otpCode
            : otpCode // ignore: cast_nullable_to_non_nullable
                  as String,
        isOtpLoading: null == isOtpLoading
            ? _value.isOtpLoading
            : isOtpLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isOtpVerifying: null == isOtpVerifying
            ? _value.isOtpVerifying
            : isOtpVerifying // ignore: cast_nullable_to_non_nullable
                  as bool,
        otpError: freezed == otpError
            ? _value.otpError
            : otpError // ignore: cast_nullable_to_non_nullable
                  as String?,
        sessionId: freezed == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        otpSecondsRemaining: null == otpSecondsRemaining
            ? _value.otpSecondsRemaining
            : otpSecondsRemaining // ignore: cast_nullable_to_non_nullable
                  as int,
        canResendOtp: null == canResendOtp
            ? _value.canResendOtp
            : canResendOtp // ignore: cast_nullable_to_non_nullable
                  as bool,
        forgotPasswordEmail: null == forgotPasswordEmail
            ? _value.forgotPasswordEmail
            : forgotPasswordEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        isForgotPasswordLoading: null == isForgotPasswordLoading
            ? _value.isForgotPasswordLoading
            : isForgotPasswordLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isForgotPasswordSuccess: null == isForgotPasswordSuccess
            ? _value.isForgotPasswordSuccess
            : isForgotPasswordSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        forgotPasswordError: freezed == forgotPasswordError
            ? _value.forgotPasswordError
            : forgotPasswordError // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentUser: freezed == currentUser
            ? _value.currentUser
            : currentUser // ignore: cast_nullable_to_non_nullable
                  as UserEntity?,
        memberships: null == memberships
            ? _value._memberships
            : memberships // ignore: cast_nullable_to_non_nullable
                  as List<ClinicMembershipEntity>,
        pendingInvitations: null == pendingInvitations
            ? _value._pendingInvitations
            : pendingInvitations // ignore: cast_nullable_to_non_nullable
                  as List<InvitationEntity>,
        activeClinicId: freezed == activeClinicId
            ? _value.activeClinicId
            : activeClinicId // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AuthStatus,
      ),
    );
  }
}

/// @nodoc

class _$AuthStateImpl implements _AuthState {
  const _$AuthStateImpl({
    this.loginEmail = '',
    this.loginPassword = '',
    this.isLoginPasswordVisible = false,
    this.isLoginLoading = false,
    this.loginError = null,
    this.signupName = '',
    this.signupEmail = '',
    this.signupPassword = '',
    this.signupConfirmPassword = '',
    this.isSignupPasswordVisible = false,
    this.isSignupConfirmPasswordVisible = false,
    this.isSignupLoading = false,
    this.signupError = null,
    this.signupLicenseNumber = '',
    this.signupSpecialization = '',
    this.signupLocation = '',
    final List<SpecialtyEntity> specialties = const [],
    final List<LocationEntity> searchedLocations = const [],
    final List<PlanEntity> plans = const [],
    this.isLoadingSpecialties = false,
    this.isLoadingPlans = false,
    this.isSearchingLocations = false,
    this.selectedSpecialty = null,
    this.selectedLocation = null,
    this.selectedPlan = null,
    this.clinicName = '',
    this.clinicAddress = '',
    this.mobileNumber = '',
    this.otpCode = '',
    this.isOtpLoading = false,
    this.isOtpVerifying = false,
    this.otpError = null,
    this.sessionId = null,
    this.otpSecondsRemaining = 0,
    this.canResendOtp = false,
    this.forgotPasswordEmail = '',
    this.isForgotPasswordLoading = false,
    this.isForgotPasswordSuccess = false,
    this.forgotPasswordError = null,
    this.currentUser = null,
    final List<ClinicMembershipEntity> memberships = const [],
    final List<InvitationEntity> pendingInvitations = const [],
    this.activeClinicId = null,
    this.status = AuthStatus.unauthenticated,
  }) : _specialties = specialties,
       _searchedLocations = searchedLocations,
       _plans = plans,
       _memberships = memberships,
       _pendingInvitations = pendingInvitations;

  // Login fields
  @override
  @JsonKey()
  final String loginEmail;
  @override
  @JsonKey()
  final String loginPassword;
  @override
  @JsonKey()
  final bool isLoginPasswordVisible;
  @override
  @JsonKey()
  final bool isLoginLoading;
  @override
  @JsonKey()
  final String? loginError;
  // Signup fields - Unified (all users are dental professionals)
  @override
  @JsonKey()
  final String signupName;
  @override
  @JsonKey()
  final String signupEmail;
  @override
  @JsonKey()
  final String signupPassword;
  @override
  @JsonKey()
  final String signupConfirmPassword;
  @override
  @JsonKey()
  final bool isSignupPasswordVisible;
  @override
  @JsonKey()
  final bool isSignupConfirmPasswordVisible;
  @override
  @JsonKey()
  final bool isSignupLoading;
  @override
  @JsonKey()
  final String? signupError;
  // Optional professional fields
  @override
  @JsonKey()
  final String signupLicenseNumber;
  @override
  @JsonKey()
  final String signupSpecialization;
  @override
  @JsonKey()
  final String signupLocation;
  // API fetched data
  final List<SpecialtyEntity> _specialties;
  // API fetched data
  @override
  @JsonKey()
  List<SpecialtyEntity> get specialties {
    if (_specialties is EqualUnmodifiableListView) return _specialties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_specialties);
  }

  final List<LocationEntity> _searchedLocations;
  @override
  @JsonKey()
  List<LocationEntity> get searchedLocations {
    if (_searchedLocations is EqualUnmodifiableListView)
      return _searchedLocations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchedLocations);
  }

  final List<PlanEntity> _plans;
  @override
  @JsonKey()
  List<PlanEntity> get plans {
    if (_plans is EqualUnmodifiableListView) return _plans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_plans);
  }

  // API loading states
  @override
  @JsonKey()
  final bool isLoadingSpecialties;
  @override
  @JsonKey()
  final bool isLoadingPlans;
  @override
  @JsonKey()
  final bool isSearchingLocations;
  // Selected entities for registration
  @override
  @JsonKey()
  final SpecialtyEntity? selectedSpecialty;
  @override
  @JsonKey()
  final LocationEntity? selectedLocation;
  @override
  @JsonKey()
  final PlanEntity? selectedPlan;
  // Clinic information for registration
  @override
  @JsonKey()
  final String clinicName;
  @override
  @JsonKey()
  final String clinicAddress;
  @override
  @JsonKey()
  final String mobileNumber;
  // OTP verification fields
  @override
  @JsonKey()
  final String otpCode;
  @override
  @JsonKey()
  final bool isOtpLoading;
  @override
  @JsonKey()
  final bool isOtpVerifying;
  @override
  @JsonKey()
  final String? otpError;
  @override
  @JsonKey()
  final String? sessionId;
  @override
  @JsonKey()
  final int otpSecondsRemaining;
  @override
  @JsonKey()
  final bool canResendOtp;
  // Forgot password fields
  @override
  @JsonKey()
  final String forgotPasswordEmail;
  @override
  @JsonKey()
  final bool isForgotPasswordLoading;
  @override
  @JsonKey()
  final bool isForgotPasswordSuccess;
  @override
  @JsonKey()
  final String? forgotPasswordError;
  // Authenticated user data
  @override
  @JsonKey()
  final UserEntity? currentUser;
  final List<ClinicMembershipEntity> _memberships;
  @override
  @JsonKey()
  List<ClinicMembershipEntity> get memberships {
    if (_memberships is EqualUnmodifiableListView) return _memberships;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberships);
  }

  final List<InvitationEntity> _pendingInvitations;
  @override
  @JsonKey()
  List<InvitationEntity> get pendingInvitations {
    if (_pendingInvitations is EqualUnmodifiableListView)
      return _pendingInvitations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingInvitations);
  }

  @override
  @JsonKey()
  final String? activeClinicId;
  // Auth status
  @override
  @JsonKey()
  final AuthStatus status;

  @override
  String toString() {
    return 'AuthState(loginEmail: $loginEmail, loginPassword: $loginPassword, isLoginPasswordVisible: $isLoginPasswordVisible, isLoginLoading: $isLoginLoading, loginError: $loginError, signupName: $signupName, signupEmail: $signupEmail, signupPassword: $signupPassword, signupConfirmPassword: $signupConfirmPassword, isSignupPasswordVisible: $isSignupPasswordVisible, isSignupConfirmPasswordVisible: $isSignupConfirmPasswordVisible, isSignupLoading: $isSignupLoading, signupError: $signupError, signupLicenseNumber: $signupLicenseNumber, signupSpecialization: $signupSpecialization, signupLocation: $signupLocation, specialties: $specialties, searchedLocations: $searchedLocations, plans: $plans, isLoadingSpecialties: $isLoadingSpecialties, isLoadingPlans: $isLoadingPlans, isSearchingLocations: $isSearchingLocations, selectedSpecialty: $selectedSpecialty, selectedLocation: $selectedLocation, selectedPlan: $selectedPlan, clinicName: $clinicName, clinicAddress: $clinicAddress, mobileNumber: $mobileNumber, otpCode: $otpCode, isOtpLoading: $isOtpLoading, isOtpVerifying: $isOtpVerifying, otpError: $otpError, sessionId: $sessionId, otpSecondsRemaining: $otpSecondsRemaining, canResendOtp: $canResendOtp, forgotPasswordEmail: $forgotPasswordEmail, isForgotPasswordLoading: $isForgotPasswordLoading, isForgotPasswordSuccess: $isForgotPasswordSuccess, forgotPasswordError: $forgotPasswordError, currentUser: $currentUser, memberships: $memberships, pendingInvitations: $pendingInvitations, activeClinicId: $activeClinicId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.loginEmail, loginEmail) ||
                other.loginEmail == loginEmail) &&
            (identical(other.loginPassword, loginPassword) ||
                other.loginPassword == loginPassword) &&
            (identical(other.isLoginPasswordVisible, isLoginPasswordVisible) ||
                other.isLoginPasswordVisible == isLoginPasswordVisible) &&
            (identical(other.isLoginLoading, isLoginLoading) ||
                other.isLoginLoading == isLoginLoading) &&
            (identical(other.loginError, loginError) ||
                other.loginError == loginError) &&
            (identical(other.signupName, signupName) ||
                other.signupName == signupName) &&
            (identical(other.signupEmail, signupEmail) ||
                other.signupEmail == signupEmail) &&
            (identical(other.signupPassword, signupPassword) ||
                other.signupPassword == signupPassword) &&
            (identical(other.signupConfirmPassword, signupConfirmPassword) ||
                other.signupConfirmPassword == signupConfirmPassword) &&
            (identical(
                  other.isSignupPasswordVisible,
                  isSignupPasswordVisible,
                ) ||
                other.isSignupPasswordVisible == isSignupPasswordVisible) &&
            (identical(
                  other.isSignupConfirmPasswordVisible,
                  isSignupConfirmPasswordVisible,
                ) ||
                other.isSignupConfirmPasswordVisible ==
                    isSignupConfirmPasswordVisible) &&
            (identical(other.isSignupLoading, isSignupLoading) ||
                other.isSignupLoading == isSignupLoading) &&
            (identical(other.signupError, signupError) ||
                other.signupError == signupError) &&
            (identical(other.signupLicenseNumber, signupLicenseNumber) ||
                other.signupLicenseNumber == signupLicenseNumber) &&
            (identical(other.signupSpecialization, signupSpecialization) ||
                other.signupSpecialization == signupSpecialization) &&
            (identical(other.signupLocation, signupLocation) ||
                other.signupLocation == signupLocation) &&
            const DeepCollectionEquality().equals(
              other._specialties,
              _specialties,
            ) &&
            const DeepCollectionEquality().equals(
              other._searchedLocations,
              _searchedLocations,
            ) &&
            const DeepCollectionEquality().equals(other._plans, _plans) &&
            (identical(other.isLoadingSpecialties, isLoadingSpecialties) ||
                other.isLoadingSpecialties == isLoadingSpecialties) &&
            (identical(other.isLoadingPlans, isLoadingPlans) ||
                other.isLoadingPlans == isLoadingPlans) &&
            (identical(other.isSearchingLocations, isSearchingLocations) ||
                other.isSearchingLocations == isSearchingLocations) &&
            (identical(other.selectedSpecialty, selectedSpecialty) ||
                other.selectedSpecialty == selectedSpecialty) &&
            (identical(other.selectedLocation, selectedLocation) ||
                other.selectedLocation == selectedLocation) &&
            (identical(other.selectedPlan, selectedPlan) ||
                other.selectedPlan == selectedPlan) &&
            (identical(other.clinicName, clinicName) ||
                other.clinicName == clinicName) &&
            (identical(other.clinicAddress, clinicAddress) ||
                other.clinicAddress == clinicAddress) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.otpCode, otpCode) || other.otpCode == otpCode) &&
            (identical(other.isOtpLoading, isOtpLoading) ||
                other.isOtpLoading == isOtpLoading) &&
            (identical(other.isOtpVerifying, isOtpVerifying) ||
                other.isOtpVerifying == isOtpVerifying) &&
            (identical(other.otpError, otpError) ||
                other.otpError == otpError) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.otpSecondsRemaining, otpSecondsRemaining) ||
                other.otpSecondsRemaining == otpSecondsRemaining) &&
            (identical(other.canResendOtp, canResendOtp) ||
                other.canResendOtp == canResendOtp) &&
            (identical(other.forgotPasswordEmail, forgotPasswordEmail) ||
                other.forgotPasswordEmail == forgotPasswordEmail) &&
            (identical(
                  other.isForgotPasswordLoading,
                  isForgotPasswordLoading,
                ) ||
                other.isForgotPasswordLoading == isForgotPasswordLoading) &&
            (identical(
                  other.isForgotPasswordSuccess,
                  isForgotPasswordSuccess,
                ) ||
                other.isForgotPasswordSuccess == isForgotPasswordSuccess) &&
            (identical(other.forgotPasswordError, forgotPasswordError) ||
                other.forgotPasswordError == forgotPasswordError) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser) &&
            const DeepCollectionEquality().equals(
              other._memberships,
              _memberships,
            ) &&
            const DeepCollectionEquality().equals(
              other._pendingInvitations,
              _pendingInvitations,
            ) &&
            (identical(other.activeClinicId, activeClinicId) ||
                other.activeClinicId == activeClinicId) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    loginEmail,
    loginPassword,
    isLoginPasswordVisible,
    isLoginLoading,
    loginError,
    signupName,
    signupEmail,
    signupPassword,
    signupConfirmPassword,
    isSignupPasswordVisible,
    isSignupConfirmPasswordVisible,
    isSignupLoading,
    signupError,
    signupLicenseNumber,
    signupSpecialization,
    signupLocation,
    const DeepCollectionEquality().hash(_specialties),
    const DeepCollectionEquality().hash(_searchedLocations),
    const DeepCollectionEquality().hash(_plans),
    isLoadingSpecialties,
    isLoadingPlans,
    isSearchingLocations,
    selectedSpecialty,
    selectedLocation,
    selectedPlan,
    clinicName,
    clinicAddress,
    mobileNumber,
    otpCode,
    isOtpLoading,
    isOtpVerifying,
    otpError,
    sessionId,
    otpSecondsRemaining,
    canResendOtp,
    forgotPasswordEmail,
    isForgotPasswordLoading,
    isForgotPasswordSuccess,
    forgotPasswordError,
    currentUser,
    const DeepCollectionEquality().hash(_memberships),
    const DeepCollectionEquality().hash(_pendingInvitations),
    activeClinicId,
    status,
  ]);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState({
    final String loginEmail,
    final String loginPassword,
    final bool isLoginPasswordVisible,
    final bool isLoginLoading,
    final String? loginError,
    final String signupName,
    final String signupEmail,
    final String signupPassword,
    final String signupConfirmPassword,
    final bool isSignupPasswordVisible,
    final bool isSignupConfirmPasswordVisible,
    final bool isSignupLoading,
    final String? signupError,
    final String signupLicenseNumber,
    final String signupSpecialization,
    final String signupLocation,
    final List<SpecialtyEntity> specialties,
    final List<LocationEntity> searchedLocations,
    final List<PlanEntity> plans,
    final bool isLoadingSpecialties,
    final bool isLoadingPlans,
    final bool isSearchingLocations,
    final SpecialtyEntity? selectedSpecialty,
    final LocationEntity? selectedLocation,
    final PlanEntity? selectedPlan,
    final String clinicName,
    final String clinicAddress,
    final String mobileNumber,
    final String otpCode,
    final bool isOtpLoading,
    final bool isOtpVerifying,
    final String? otpError,
    final String? sessionId,
    final int otpSecondsRemaining,
    final bool canResendOtp,
    final String forgotPasswordEmail,
    final bool isForgotPasswordLoading,
    final bool isForgotPasswordSuccess,
    final String? forgotPasswordError,
    final UserEntity? currentUser,
    final List<ClinicMembershipEntity> memberships,
    final List<InvitationEntity> pendingInvitations,
    final String? activeClinicId,
    final AuthStatus status,
  }) = _$AuthStateImpl;

  // Login fields
  @override
  String get loginEmail;
  @override
  String get loginPassword;
  @override
  bool get isLoginPasswordVisible;
  @override
  bool get isLoginLoading;
  @override
  String? get loginError; // Signup fields - Unified (all users are dental professionals)
  @override
  String get signupName;
  @override
  String get signupEmail;
  @override
  String get signupPassword;
  @override
  String get signupConfirmPassword;
  @override
  bool get isSignupPasswordVisible;
  @override
  bool get isSignupConfirmPasswordVisible;
  @override
  bool get isSignupLoading;
  @override
  String? get signupError; // Optional professional fields
  @override
  String get signupLicenseNumber;
  @override
  String get signupSpecialization;
  @override
  String get signupLocation; // API fetched data
  @override
  List<SpecialtyEntity> get specialties;
  @override
  List<LocationEntity> get searchedLocations;
  @override
  List<PlanEntity> get plans; // API loading states
  @override
  bool get isLoadingSpecialties;
  @override
  bool get isLoadingPlans;
  @override
  bool get isSearchingLocations; // Selected entities for registration
  @override
  SpecialtyEntity? get selectedSpecialty;
  @override
  LocationEntity? get selectedLocation;
  @override
  PlanEntity? get selectedPlan; // Clinic information for registration
  @override
  String get clinicName;
  @override
  String get clinicAddress;
  @override
  String get mobileNumber; // OTP verification fields
  @override
  String get otpCode;
  @override
  bool get isOtpLoading;
  @override
  bool get isOtpVerifying;
  @override
  String? get otpError;
  @override
  String? get sessionId;
  @override
  int get otpSecondsRemaining;
  @override
  bool get canResendOtp; // Forgot password fields
  @override
  String get forgotPasswordEmail;
  @override
  bool get isForgotPasswordLoading;
  @override
  bool get isForgotPasswordSuccess;
  @override
  String? get forgotPasswordError; // Authenticated user data
  @override
  UserEntity? get currentUser;
  @override
  List<ClinicMembershipEntity> get memberships;
  @override
  List<InvitationEntity> get pendingInvitations;
  @override
  String? get activeClinicId; // Auth status
  @override
  AuthStatus get status;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
