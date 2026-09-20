import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/features/home/presentation/manager/unread_count_cubit.dart';
import 'package:dental_clinic_app/features/home/presentation/theme/home_tokens.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Who is using the app, and the two things they reach for from anywhere.
///
/// Handoff section 1: avatar, a time-of-day greeting over the name, and two
/// square-ish icon buttons. The bell carries a dot rather than a count -
/// whether there is unread mail is the whole question at this size.
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.userName,
    this.profileImageUrl,
    this.isLoading = false,
    this.onNotificationTap,
    this.onMoreTap,
  });

  final String userName;
  final String? profileImageUrl;
  final bool isLoading;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMoreTap;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);
    final family = FontHelper.fontFamily(context);
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        _Avatar(
          imageUrl: profileImageUrl,
          name: userName,
          isLoading: isLoading,
          onTap: onMoreTap,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: isLoading
              ? const _GreetingSkeleton()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _greeting(l10n, DateTime.now()),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 11.sp,
                        height: 1.3,
                        fontWeight: FontWeight.w400,
                        color: t.secondary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 15.sp,
                        height: 1.2,
                        color: t.ink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
        SizedBox(width: 12.w),
        _HeaderButton(
          icon: Icons.notifications_none_rounded,
          onTap: onNotificationTap,
          badge: BlocBuilder<UnreadCountCubit, int>(
            bloc: getIt<UnreadCountCubit>(),
            builder: (context, unread) =>
                unread == 0 ? const SizedBox.shrink() : const _UnreadDot(),
          ),
        ),
        SizedBox(width: 8.w),
        _HeaderButton(icon: Icons.settings_outlined, onTap: onMoreTap),
      ],
    );
  }

  /// Local clock, local phrasing. Arabic has no everyday split between
  /// afternoon and evening, so its middle bucket is a plain "good day"
  /// rather than a literal translation nobody says.
  String _greeting(AppLocalizations l10n, DateTime now) {
    if (now.hour < 12) return l10n.goodMorning;
    if (now.hour < 17) return l10n.goodAfternoon;
    return l10n.goodEvening;
  }
}

/// The user's own face, or their initials over the brand tint - never an
/// anonymous silhouette while a name is known.
class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.imageUrl,
    required this.name,
    required this.isLoading,
    this.onTap,
  });

  final String? imageUrl;
  final String name;
  final bool isLoading;
  final VoidCallback? onTap;

  static const double _size = 40;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ShimmerBox(
        width: _size.w,
        height: _size.w,
        radius: BorderRadius.circular(_size.r),
      );
    }

    final t = HomeTokens.of(context);
    final url = imageUrl;
    final hasImage = url != null && url.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _size.w,
        height: _size.w,
        // Circular, which is what the style reserves for a face.
        decoration: BoxDecoration(
          color: t.tint,
          shape: BoxShape.circle,
          image: hasImage
              ? DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)
              : null,
        ),
        alignment: Alignment.center,
        child: hasImage ? null : _fallback(context, t),
      ),
    );
  }

  Widget _fallback(BuildContext context, HomeTokens t) {
    final initials = _initials(name);
    if (initials.isEmpty) {
      return Icon(
        Icons.person_outline_rounded,
        size: 19.w,
        color: t.primaryDark,
      );
    }
    return Text(
      initials,
      style: TextStyle(
        fontFamily: FontHelper.fontFamily(context),
        fontSize: 15.sp,
        height: 1,
        fontWeight: FontWeight.w600,
        color: t.primaryDark,
      ),
    );
  }

  /// First letters of the first two words. Reads words rather than assuming
  /// Latin letters, so an Arabic name gets its own initials.
  static String _initials(String name) {
    final words = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    return words.take(2).map((w) => w.characters.first).join().toUpperCase();
  }
}

class _HeaderButton extends StatefulWidget {
  const _HeaderButton({required this.icon, this.onTap, this.badge});

  final IconData icon;
  final VoidCallback? onTap;
  final Widget? badge;

  @override
  State<_HeaderButton> createState() => _HeaderButtonState();
}

class _HeaderButtonState extends State<_HeaderButton> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _down = true),
      onTapCancel: () => setState(() => _down = false),
      onTapUp: (_) => setState(() => _down = false),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: 36.w,
            height: 36.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _down ? t.pressed : t.card,
              borderRadius: BorderRadius.circular(11.r),
              border: Border.all(color: t.hairline),
            ),
            child: Icon(widget.icon, size: 17.w, color: t.ink),
          ),
          if (widget.badge != null)
            PositionedDirectional(end: 8.w, top: 7.h, child: widget.badge!),
        ],
      ),
    );
  }
}

/// Presence, not a count: the dot says there is unread mail and the
/// notifications screen says how much.
class _UnreadDot extends StatelessWidget {
  const _UnreadDot();

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);
    return Container(
      width: 7.w,
      height: 7.w,
      decoration: BoxDecoration(
        color: ColorManager.warning,
        shape: BoxShape.circle,
        border: Border.all(color: t.card, width: 2),
      ),
    );
  }
}

class _GreetingSkeleton extends StatelessWidget {
  const _GreetingSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBox(width: 88.w, height: 11.h),
        SizedBox(height: 5.h),
        ShimmerBox(width: 150.w, height: 15.h),
      ],
    );
  }
}
