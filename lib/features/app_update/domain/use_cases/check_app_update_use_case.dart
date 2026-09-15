import 'dart:io' show Platform;

import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../entities/app_update_info.dart';
import '../repositories/app_update_repository.dart';

/// Asks the backend whether this build may keep running.
///
/// Sends what is running - platform, version, build number - and does no
/// comparison of its own. See [AppUpdateInfo] for why the decision belongs
/// on the server.
@injectable
class CheckAppUpdateUseCase implements UseCase<AppUpdateInfo, NoParams> {
  CheckAppUpdateUseCase(this._repository);

  final AppUpdateRepository _repository;

  @override
  Future<Either<NetworkExceptions, AppUpdateInfo>> call(NoParams params) async {
    final platform = _platform();
    // Nowhere to send the user on a platform with no store listing, so there
    // is no point asking. Windows updates through a different channel.
    if (platform == null) return const Right(AppUpdateInfo.none());

    // Reading the running build goes over a platform channel, and a missing
    // one throws. Nothing about a version check may ever stop the app
    // opening, so this fails the same quiet way a dead network does.
    final PackageInfo info;
    try {
      info = await PackageInfo.fromPlatform();
    } catch (e) {
      if (kDebugMode) debugPrint('[app-update] no package info: $e');
      return const Right(AppUpdateInfo.none());
    }

    final result = await _repository.checkForUpdate(
      platform: platform,
      version: info.version,
      build: info.buildNumber,
    );

    return result.fold(
      // A failure is not a reason to nag, and it is emphatically not a reason
      // to block: the check runs at launch, the first launch after an install
      // is often on a bad connection, and an app that refused to open because
      // it could not reach a version endpoint would be worse than one running
      // a build a week out of date.
      (failure) {
        if (kDebugMode) {
          debugPrint('[app-update] check failed: $failure');
        }
        return const Right(AppUpdateInfo.none());
      },
      // A decision the app cannot act on is no decision - a forced prompt
      // with no store URL would leave the user with nothing to press.
      (update) =>
          Right(update.isActionable ? update : const AppUpdateInfo.none()),
    );
  }

  /// Null on every platform the app is not published to a store on.
  static String? _platform() {
    if (kIsWeb) return null;
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    return null;
  }
}
