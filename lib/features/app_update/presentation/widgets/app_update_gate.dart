import 'dart:async';

import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/routes_manager.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/app_update/data/app_update_storage.dart';
import 'package:dental_clinic_app/features/app_update/domain/entities/app_update_info.dart';
import 'package:dental_clinic_app/features/app_update/domain/use_cases/check_app_update_use_case.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';

import 'app_update_actions.dart';
import 'force_update_view.dart';
import 'optional_update_sheet.dart';

/// Runs the version check once per launch and acts on the answer.
///
/// Sits above the router rather than on a screen, for two reasons. A forced
/// update has to reach a user wherever the app resumed - the login page, a
/// deep link from a push, mid-flow on the appointment form - and a check that
/// lived on Home would miss all three. And returning [ForceUpdateView] in
/// place of [child] removes the router from the tree entirely, so there is
/// nothing behind the block to get back to.
///
/// The check never blocks first frame: the app builds normally and the answer
/// swaps in when it lands, a moment later.
class AppUpdateGate extends StatefulWidget {
  const AppUpdateGate({super.key, required this.child});

  final Widget child;

  @override
  State<AppUpdateGate> createState() => _AppUpdateGateState();
}

class _AppUpdateGateState extends State<AppUpdateGate> {
  AppUpdateInfo _info = const AppUpdateInfo.none();

  @override
  void initState() {
    super.initState();
    unawaited(_check());
  }

  Future<void> _check() async {
    final result = await getIt<CheckAppUpdateUseCase>()(NoParams());
    if (!mounted) return;

    // The use case already turns every failure into "no update", so a Left
    // here is not expected; it is still the same do-nothing answer.
    final info = result.getOrElse(() => const AppUpdateInfo.none());

    if (info.isForced) {
      setState(() => _info = info);
      return;
    }
    if (!info.isOptional) return;

    if (getIt<AppUpdateStorage>().hasSkipped(info.latestVersion)) return;
    _promptOptional(info);
  }

  /// The sheet needs a Navigator, and this widget sits *above* the one the
  /// router owns - so it is shown against the root navigator's context, the
  /// same way a forced sign-out reaches the login page from an interceptor.
  void _promptOptional(AppUpdateInfo info) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final context = rootNavigatorKey.currentContext;
      if (context == null) return;

      final wantsUpdate = await OptionalUpdateSheet.show(context, info);

      if (!wantsUpdate) {
        // Declined however they declined it: barrier, drag or button. Asking
        // again next launch for a version they have already turned down is
        // how a prompt stops being read.
        final version = info.latestVersion;
        if (version != null) {
          await getIt<AppUpdateStorage>().skipVersion(version);
        }
        return;
      }

      if (!context.mounted) return;
      await openStore(context, info.storeUrl!);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_info.isForced) return widget.child;

    // Localizations resolve asynchronously, so a locale change leaves one
    // frame where there are none - and the update screen is built entirely
    // out of translated copy. Hold the block with an empty screen for that
    // frame rather than flashing the app the user is locked out of.
    final hasCopy = AppLocalizations.of(context) != null;
    return hasCopy
        ? ForceUpdateView(info: _info)
        : ColoredBox(
            color: ColorManager.of(context).scaffoldBg,
            child: const SizedBox.expand(),
          );
  }
}
