import 'package:dental_clinic_app/core/config/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

/// The Apple builds have to ship with no way to register a clinic -
/// guideline 3.1.1, the rejection of 1.0.3 on 2026-10-14. One flag decides
/// that for the whole app: the login page hides its sign-up link on it and
/// RoutesManager closes off every step of the flow with it, so the platform
/// answer below is the thing worth pinning. Getting it wrong on an iOS
/// release costs another review cycle.
void main() {
  tearDown(() => debugDefaultTargetPlatformOverride = null);

  test('clinic sign-up is off on iOS and macOS', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    expect(AppConfig.selfSignupEnabled, isFalse);

    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    expect(AppConfig.selfSignupEnabled, isFalse);
  });

  test('every other platform keeps self-serve onboarding', () {
    for (final platform in [
      TargetPlatform.android,
      TargetPlatform.windows,
      TargetPlatform.linux,
    ]) {
      debugDefaultTargetPlatformOverride = platform;
      expect(
        AppConfig.selfSignupEnabled,
        isTrue,
        reason: 'sign-up should still be reachable on $platform',
      );
    }
  });
}
