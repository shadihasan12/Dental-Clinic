import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The pieces every auth page repeats. Shared so the ten screens in this
/// folder cannot drift into ten slightly different back buttons.

/// Back control on an auth page: an icon tile, not a bare glyph, at the same
/// 11r radius and hairline the rest of the app gives its icon tiles.
class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: c.cardBgSecondary,
          borderRadius: BorderRadius.circular(11.r),
          border: Border.all(color: c.borderLight),
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: c.textPrimary,
          size: 16.w,
        ),
      ),
    );
  }
}

/// The single illustrative glyph an auth step leads with.
///
/// A rounded tile rather than a disc - the design language reserves circles
/// for avatars - and a theme-aware accent, because the on-white primary tone
/// goes muddy against a dark surface.
class AuthHeroGlyph extends StatelessWidget {
  const AuthHeroGlyph({super.key, required this.icon, this.tone});

  final IconData icon;

  /// Defaults to the app primary. Pass a semantic hue for a failure step.
  final Color? tone;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = tone ?? ColorManager.primary;
    final accent = tone ??
        (isDark ? ColorManager.primary : ColorManager.primaryDarker);

    return Center(
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: base.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(icon, size: 28.w, color: accent),
      ),
    );
  }
}

/// "Could not load / nothing here" block on an auth step: a tinted tile, a
/// 15sp title and 11.5sp body, matching the placeholder shape used across
/// the rest of the app.
class AuthStatusBlock extends StatelessWidget {
  const AuthStatusBlock({
    super.key,
    required this.icon,
    required this.tone,
    required this.title,
    required this.titleStyle,
    this.message,
    this.messageStyle,
  });

  final IconData icon;
  final Color tone;
  final String title;
  final TextStyle titleStyle;
  final String? message;
  final TextStyle? messageStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Icon(icon, size: 22.w, color: tone),
        ),
        SizedBox(height: 14.h),
        Text(title, textAlign: TextAlign.center, style: titleStyle),
        if (message != null) ...[
          SizedBox(height: 6.h),
          Text(message!, textAlign: TextAlign.center, style: messageStyle),
        ],
      ],
    );
  }
}
