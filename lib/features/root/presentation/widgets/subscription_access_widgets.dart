import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/session/session_manager.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Across the top of the app while the subscription is expired: the data is
/// all still readable, nothing can be changed, and here is the way back.
///
/// Telling the user up front is the design; the 402 a write would get is
/// only the safety net.
class ReadOnlyBanner extends StatelessWidget {
  const ReadOnlyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final canPay = SubscriptionGuardHelper.canManageBilling;
    const tone = ColorManager.warning;

    return Material(
      color: Color.alphaBlend(
        tone.withValues(alpha: 0.12),
        ColorManager.of(context).surfaceBg,
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 8.h, 8.w, 8.h),
          child: Row(
            children: [
              Icon(Icons.lock_clock_outlined, size: 18.w, color: tone),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  canPay ? l10n.readOnlyBanner : l10n.readOnlyBannerNonAdmin,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 11.5.sp,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.of(context).textPrimary,
                  ),
                ),
              ),
              if (canPay)
                TextButton(
                  onPressed: () => context.pushNamed(AppRoutesNames.billing),
                  style: TextButton.styleFrom(
                    foregroundColor: tone,
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(
                    l10n.renewAction,
                    style: TextStyle(
                      fontFamily: family,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The whole app for someone who cannot pay, in a clinic whose subscription
/// allows nothing but billing. They are told who can fix it, and keep the
/// two ways out: another clinic, or logging out.
class SubscriptionLockedView extends StatelessWidget {
  const SubscriptionLockedView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final message = getIt<SubscriptionGuard>().lastMessage;

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StateCard(
                  icon: Icons.lock_outline_rounded,
                  tone: ColorManager.warning,
                  title: l10n.subscriptionInactiveTitle,
                  message: message ?? l10n.subscriptionInactiveMessage,
                  detail: l10n.subscriptionAskAdmin,
                  actionLabel: l10n.myClinics,
                  onAction: () => context.pushNamed(AppRoutesNames.myClinics),
                ),
                SizedBox(height: 12.h),
                DentaOutlineButton(
                  label: l10n.logout,
                  icon: Icons.logout,
                  expand: true,
                  tone: ColorManager.error,
                  onTap: () => getIt<SessionManager>().endSession(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
