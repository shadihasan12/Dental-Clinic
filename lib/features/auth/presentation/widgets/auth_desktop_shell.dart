import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/assets.gen.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:dental_clinic_app/core/resources/responsive.dart';

/// Wraps auth / onboarding pages in a split layout on wide screens.
///
/// Left half:  onboarding image + gradient overlay + branding.
/// Right half: the page's form content, vertically & horizontally centred.
///
/// On narrow screens (< 900 px) the [child] is rendered directly.
class AuthDesktopShell extends StatelessWidget {
  const AuthDesktopShell({super.key, required this.child, this.imageIndex = 0});

  /// The form content that will appear on the right side on desktop,
  /// or as the full page on mobile.
  final Widget child;

  /// Which onboarding image to show (0, 1, or 2).
  final int imageIndex;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= Responsive.desktopBreakpoint;

  @override
  Widget build(BuildContext context) {
    if (!isDesktop(context)) return child;

    // No ScreenUtil.configure here: main.dart sets the design size to the
    // window on desktop, so .sp/.w/.h already resolve 1:1. Re-configuring the
    // singleton from inside the tree is what used to make a hot reload paint
    // at the phone ratio.
    return Scaffold(
      body: Row(
        children: [
          // ── Left panel: image + branding ─────────────────────
          Expanded(child: _BrandingPanel(imageIndex: imageIndex)),

          // ── Right panel: form content ───────────────────────
          Expanded(
            child: Container(
              color: ColorManager.of(context).scaffoldBg,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.formMaxWidth,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The left half of the desktop split — shows an onboarding image with a
/// gradient overlay and the app logo + tagline.
class _BrandingPanel extends StatelessWidget {
  const _BrandingPanel({required this.imageIndex});

  final int imageIndex;

  String _imagePath() {
    switch (imageIndex) {
      case 1:
        return Assets.imagesOnboarding2.path;
      case 2:
        return Assets.imagesOnboarding3.path;
      default:
        return Assets.imagesOnboarding1.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(
          _imagePath(),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            decoration: BoxDecoration(gradient: GradientManager.primaryHeader),
          ),
        ),

        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.6),
                Colors.black.withValues(alpha: 0.85),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),

        // Branding content
        Positioned(
          left: 40,
          right: 40,
          bottom: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                // Same mark the mobile login header uses, inset so the
                // artwork does not run into the rounded corners.
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Assets.imagesLogoDentaMark.image(fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 20),

              // App name
              Text(
                l10n.appName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeightManager.bold,
                  fontSize: 26,
                  fontFamily: fontFamily,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),

              // Tagline
              Text(
                l10n.professionalClinicManagement,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 15,
                  fontFamily: fontFamily,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
