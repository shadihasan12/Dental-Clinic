import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_poller.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_topics_synchronizer.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/features/home/presentation/manager/unread_count_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

/// What the account screens do with the answers the server gives to a code
/// request, a code, and a session: the wait before another code, a code
/// ended by wrong answers, a session that is used up, and a number sent the
/// way it is stored.
void main() {
  late _Repository repository;
  late AuthBloc bloc;

  setUp(() {
    repository = _Repository();
    bloc = AuthBloc(
      repository,
      _Unused<TokenStorage>() as TokenStorage,
      _Unused<UserStorage>() as UserStorage,
      _Unused<NotificationService>() as NotificationService,
      _Unused<NotificationTopicsSynchronizer>()
          as NotificationTopicsSynchronizer,
      _Unused<NotificationPoller>() as NotificationPoller,
      _Unused<UnreadCountCubit>() as UnreadCountCubit,
    );
  });

  tearDown(() => bloc.close());

  /// Lets the handlers of the events just added run to the end.
  Future<void> settle() =>
      Future<void>.delayed(const Duration(milliseconds: 20));

  group('asking for a sign-up code', () {
    test('every code sent starts a new wait, same seconds or not', () async {
      repository.otp = Right(OtpResponse(sent: true, secondsRemaining: 300));
      bloc
        ..add(const AuthEvent.signupEmailChanged('a@x.com'))
        ..add(const AuthEvent.otpRequested());
      await settle();
      final first = bloc.state.otpWaitTick;

      bloc.add(const AuthEvent.otpResendRequested());
      await settle();

      expect(bloc.state.otpSecondsRemaining, 300);
      expect(bloc.state.otpWaitTick, greaterThan(first));
      expect(bloc.state.otpError, isNull);
    });

    test('a code still out counts as sent, with the seconds it has left',
        () async {
      // The wait between two codes: meta.seconds_remaining, no Retry-After.
      repository.otp = const Left(
        NetworkExceptions.tooManyRequests(
          'يرجى إعادة المحاولة بعد 299 ثانية',
          secondsRemaining: 299,
        ),
      );
      bloc.add(const AuthEvent.otpRequested());
      await settle();

      expect(bloc.state.otpError, isNull);
      expect(bloc.state.otpSecondsRemaining, 299);
      expect(bloc.state.otpWaitTick, 1);
    });

    test('the limit is an error, and the countdown follows Retry-After',
        () async {
      repository.otp = const Left(
        NetworkExceptions.tooManyRequests(
          'طلبات كثيرة جداً',
          retryAfterSeconds: 600,
        ),
      );
      bloc.add(const AuthEvent.otpRequested());
      await settle();

      expect(bloc.state.otpError, 'طلبات كثيرة جداً');
      expect(bloc.state.otpSecondsRemaining, 600);
      expect(bloc.state.otpWaitTick, 1);
    });
  });

  group('answering a code', () {
    test('the fifth wrong answer ends it, and the wait with it', () async {
      repository.otp = Right(OtpResponse(sent: true, secondsRemaining: 300));
      repository.verify = const Left(
        NetworkExceptions.unprocessableEntity('رمز التحقق غير صالح'),
      );
      bloc
        ..add(const AuthEvent.otpRequested())
        ..add(const AuthEvent.otpCodeChanged('000000'));
      await settle();

      for (var i = 0; i < 4; i++) {
        bloc.add(const AuthEvent.otpVerified());
        await settle();
      }
      expect(bloc.state.isOtpCodeSpent, isFalse);
      expect(bloc.state.otpSecondsRemaining, 300);

      bloc.add(const AuthEvent.otpVerified());
      await settle();

      expect(bloc.state.isOtpCodeSpent, isTrue);
      expect(bloc.state.otpSecondsRemaining, 0);

      // A new code starts the count again.
      bloc.add(const AuthEvent.otpResendRequested());
      await settle();
      expect(bloc.state.isOtpCodeSpent, isFalse);
    });

    test('being asked to slow down is not a wrong answer', () async {
      repository.verify = const Left(
        NetworkExceptions.tooManyRequests('wait', retryAfterSeconds: 60),
      );
      bloc.add(const AuthEvent.otpCodeChanged('000000'));
      for (var i = 0; i < 6; i++) {
        bloc.add(const AuthEvent.otpVerified());
        await settle();
      }

      expect(bloc.state.isOtpCodeSpent, isFalse);
    });
  });

  group('setting a new password', () {
    Future<void> openSession() async {
      repository.verify = Right(VerifyOtpResponse(sessionId: 'a' * 64));
      bloc
        ..add(const AuthEvent.forgotPasswordEmailChanged('a@x.com'))
        ..add(const AuthEvent.otpCodeChanged('123456'))
        ..add(const AuthEvent.resetPasswordOtpVerified());
      await settle();
    }

    void type(String password) {
      bloc
        ..add(AuthEvent.resetPasswordNewChanged(password))
        ..add(AuthEvent.resetPasswordConfirmChanged(password));
    }

    test('a password without a digit never reaches the server', () async {
      await openSession();
      type('abcdefgh');
      bloc.add(const AuthEvent.resetPasswordSubmitted());
      await settle();

      expect(repository.resetCalls, 0);
      expect(bloc.state.resetPasswordError, isNotNull);
    });

    test('a 422 is the session: it is dropped and the flow starts again',
        () async {
      await openSession();
      repository.reset = const Left(
        NetworkExceptions.unprocessableEntity('جلسة غير صالحة'),
      );
      type('abcdefg1');
      bloc.add(const AuthEvent.resetPasswordSubmitted());
      await settle();

      expect(bloc.state.resetSessionExpired, isTrue);
      expect(bloc.state.resetPasswordSessionId, isNull);
    });

    test('a 400 is the fields: the session is kept for another try', () async {
      await openSession();
      repository.reset = const Left(NetworkExceptions.badRequest('طلب خاطئ'));
      type('abcdefg1');
      bloc.add(const AuthEvent.resetPasswordSubmitted());
      await settle();

      expect(bloc.state.resetSessionExpired, isFalse);
      expect(bloc.state.resetPasswordSessionId, 'a' * 64);
      expect(bloc.state.resetPasswordError, 'طلب خاطئ');
    });

    test('a double tap sends the session once', () async {
      await openSession();
      type('abcdefg1');
      bloc
        ..add(const AuthEvent.resetPasswordSubmitted())
        ..add(const AuthEvent.resetPasswordSubmitted());
      await settle();

      expect(repository.resetCalls, 1);

      // Nor does a tap after it went through: the session is used up.
      bloc.add(const AuthEvent.resetPasswordSubmitted());
      await settle();
      expect(repository.resetCalls, 1);
    });
  });

  group('signing in', () {
    Future<LoginParams?> signIn(String identifier, String password) async {
      bloc
        ..add(AuthEvent.loginEmailChanged(identifier))
        ..add(AuthEvent.loginPasswordChanged(password))
        ..add(const AuthEvent.loginSubmitted());
      await settle();
      return repository.loginParams;
    }

    test('a number goes out the way the server stores it', () async {
      final params = await signIn('٠٩٣٥ 315-978', 'secret');

      expect(params?.emailOrMobileNumber, '0935315978');
    });

    test('an email is left as typed', () async {
      final params = await signIn('doctor@example.com', 'secret');

      expect(params?.emailOrMobileNumber, 'doctor@example.com');
    });

    test('the password in use is not judged: any length goes', () async {
      final params = await signIn('doctor@example.com', 'abc');

      expect(params?.password, 'abc');
    });
  });
}

class _Repository implements AuthRepository {
  Either<NetworkExceptions, OtpResponse> otp =
      Right(OtpResponse(sent: true, secondsRemaining: 300));
  Either<NetworkExceptions, VerifyOtpResponse> verify =
      Right(VerifyOtpResponse(sessionId: 'session'));
  Either<NetworkExceptions, void> reset = const Right(null);

  int resetCalls = 0;
  LoginParams? loginParams;

  @override
  Future<Either<NetworkExceptions, OtpResponse>> requestOtpForRegister({
    required RequestOtpParams params,
  }) async => otp;

  @override
  Future<Either<NetworkExceptions, OtpResponse>> resendOtp({
    required RequestOtpParams params,
  }) async => otp;

  @override
  Future<Either<NetworkExceptions, OtpResponse>> requestOtpForResetPassword({
    required RequestOtpParams params,
  }) async => otp;

  @override
  Future<Either<NetworkExceptions, VerifyOtpResponse>> verifyOtp({
    required VerifyOtpParams params,
  }) async => verify;

  @override
  Future<Either<NetworkExceptions, void>> resetPassword({
    required ResetPasswordParams params,
  }) async {
    resetCalls++;
    // On its way, as a real call is: long enough for a second tap to land.
    await Future<void>.delayed(const Duration(milliseconds: 5));
    return reset;
  }

  @override
  Future<Either<NetworkExceptions, LoginResult>> login({
    required LoginParams params,
  }) async {
    loginParams = params;
    return const Left(NetworkExceptions.unauthorizedRequest('no'));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Stands in for a collaborator these flows never touch; any call on it
/// fails the test.
class _Unused<T> implements TokenStorage,
        UserStorage,
        NotificationService,
        NotificationTopicsSynchronizer,
        NotificationPoller,
        UnreadCountCubit {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
