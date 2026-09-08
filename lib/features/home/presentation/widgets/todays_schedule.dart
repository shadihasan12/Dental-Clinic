import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/entrance_fade.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_list_card.dart';
import 'package:dental_clinic_app/features/home/presentation/theme/home_tokens.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/section_heading.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// What the clinic is doing today.
///
/// Handoff section 5: a heading with "See all", then one card shell holding
/// whichever of the three states applies. The shell is the same in all of
/// them - skeleton, empty and error keep the card's shape - so nothing
/// jumps as the load resolves.
class TodaysSchedule extends StatelessWidget {
  const TodaysSchedule({
    super.key,
    required this.appointments,
    this.totalCount,
    this.isLoading = false,
    this.error,
    this.onViewAllTap,
    this.onNewAppointment,
    this.onRetry,
  });

  final List<AppointmentEntity> appointments;

  /// Full count for the day; [appointments] may be truncated for the home
  /// screen, so the header still reports the real number.
  final int? totalCount;
  final bool isLoading;
  final String? error;
  final VoidCallback? onViewAllTap;
  final VoidCallback? onNewAppointment;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: l10n.todaysSchedule,
          trailing: appointments.isEmpty
              ? null
              : GestureDetector(
                  onTap: onViewAllTap,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text(
                      l10n.seeAll,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                        color: t.primaryDark,
                      ),
                    ),
                  ),
                ),
        ),
        SizedBox(height: 12.h),
        _Shell(child: _body(context, t, l10n)),
      ],
    );
  }

  Widget _body(BuildContext context, HomeTokens t, AppLocalizations l10n) {
    if (isLoading) {
      return Column(
        children: [
          for (var i = 0; i < 3; i++) ...[
            if (i > 0) SizedBox(height: 8.h),
            const AppointmentCardSkeleton(),
          ],
        ],
      );
    }

    if (error != null) {
      return _CentredState(
        icon: Icons.cloud_off_rounded,
        tone: const Color(0xFFEA5A0C),
        title: l10n.scheduleLoadFailed,
        message: error!,
        detail: l10n.scheduleUnchangedHint,
        actionLabel: l10n.retry,
        onAction: onRetry,
      );
    }

    if (appointments.isEmpty) {
      return _CentredState(
        icon: Icons.calendar_month_outlined,
        title: l10n.noAppointmentsToday,
        message: l10n.noAppointmentsTodayHint,
        actionLabel: '+ ${l10n.newAppointment}',
        onAction: onNewAppointment,
      );
    }

    // Rows arrive one after another the first time they are built, so the
    // list assembles instead of appearing whole. A later refetch reuses
    // these elements, so swapping the data underneath does not replay it.
    return Column(
      children: [
        for (var i = 0; i < appointments.length; i++) ...[
          if (i > 0) SizedBox(height: 8.h),
          EntranceFade(
            index: i,
            child: AppointmentListCard(appointment: appointments[i]),
          ),
        ],
      ],
    );
  }
}

/// The card every state is drawn inside. Padding tightens when it holds a
/// list, because the rows carry their own.
class _Shell extends StatelessWidget {
  const _Shell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: t.card,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: t.hairline),
      ),
      child: child,
    );
  }
}

/// The empty and error states: a dashed icon box, a title, a sentence, and
/// the action that resolves it.
class _CentredState extends StatelessWidget {
  const _CentredState({
    required this.icon,
    required this.title,
    required this.message,
    required this.actionLabel,
    this.detail,
    this.tone,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? detail;
  final Color? tone;
  final String actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);
    final family = FontHelper.fontFamily(context);
    final accent = tone ?? t.primary;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 14.h),
      child: Column(
        children: [
          _DashedBox(icon: icon, tone: accent),
          SizedBox(height: 12.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: family,
              fontSize: 16.5.sp,
              height: 1.25,
              fontWeight: FontWeight.w700,
              color: t.ink,
            ),
          ),
          SizedBox(height: 8.h),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 270.w),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: family,
                fontSize: 13.sp,
                height: 1.5,
                fontWeight: FontWeight.w400,
                color: t.muted,
              ),
            ),
          ),
          if (detail != null) ...[
            SizedBox(height: 4.h),
            Text(
              detail!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.sp,
                height: 1.4,
                color: t.secondary,
              ),
            ),
          ],
          SizedBox(height: 16.h),
          _PrimaryButton(label: actionLabel, onTap: onAction),
        ],
      ),
    );
  }
}

class _DashedBox extends StatelessWidget {
  const _DashedBox({required this.icon, required this.tone});

  final IconData icon;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);

    return CustomPaint(
      painter: _DashedBorderPainter(
        color: t.tintBorder,
        radius: 20.r,
        strokeWidth: 1.5,
      ),
      child: SizedBox(
        width: 56.w,
        height: 56.w,
        child: Center(
          child: Icon(icon, size: 22.w, color: tone),
        ),
      ),
    );
  }
}

/// Flutter has no dashed border, and pulling in a package for one box would
/// be a poor trade - this walks the rounded rect and paints every other
/// span.
class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({
    required this.color,
    required this.radius,
    required this.strokeWidth,
  });

  final Color color;
  final double radius;
  final double strokeWidth;

  static const double _dash = 5;
  static const double _gap = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            strokeWidth / 2,
            strokeWidth / 2,
            size.width - strokeWidth,
            size.height - strokeWidth,
          ),
          Radius.circular(radius),
        ),
      );

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = (distance + _dash).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance = end + _gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color ||
      old.radius != radius ||
      old.strokeWidth != strokeWidth;
}

class _PrimaryButton extends StatefulWidget {
  const _PrimaryButton({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _down = false;

  void _set(bool down) => setState(() => _down = down);

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _set(true),
      onTapCancel: () => _set(false),
      onTapUp: (_) => _set(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: double.infinity,
        height: 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _down ? t.primaryDark : t.primary,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: t.buttonShadow,
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          widget.label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 15.5.sp,
            height: 1.2,
            fontWeight: FontWeight.w700,
            color: t.onPrimary,
          ),
        ),
      ),
    );
  }
}
