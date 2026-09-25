import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/core/widgets/entrance_fade.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_list_card.dart';
import 'package:dental_clinic_app/features/home/presentation/theme/home_tokens.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/section_heading.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
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
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: t.primaryDark,
                      ),
                    ),
                  ),
                ),
        ),
        SizedBox(height: 8.h),
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
        tone: ColorManager.warning,
        title: l10n.scheduleLoadFailed,
        message: error!,
        detail: l10n.scheduleUnchangedHint,
        actionLabel: l10n.retry,
        onAction: onRetry,
      );
    }

    if (appointments.isEmpty) {
      // Desktop already offers New Appointment in the Quick Actions column
      // beside this card, so repeating it here would be the same action twice
      // on one screen. The card fills the column instead, rather than leaving
      // dead space.
      final isDesktop = Responsive.isDesktop(context);
      return _CentredState(
        icon: Icons.calendar_month_outlined,
        title: l10n.noAppointmentsToday,
        message: l10n.noAppointmentsTodayHint,
        minHeight: isDesktop ? 340 : null,
        actionLabel: isDesktop ? null : '+ ${l10n.newAppointment}',
        onAction: isDesktop ? null : onNewAppointment,
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: t.card,
        borderRadius: BorderRadius.circular(16.r),
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
    this.actionLabel,
    this.detail,
    this.tone,
    this.onAction,
    this.minHeight,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? detail;
  final Color? tone;

  /// Null drops the button entirely.
  final String? actionLabel;
  final VoidCallback? onAction;

  /// Lets the state fill a tall column (the desktop schedule) instead of
  /// sitting at its top with dead space under it.
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);
    final family = FontHelper.fontFamily(context);
    final accent = tone ?? t.primary;

    return Container(
      constraints: BoxConstraints(minHeight: minHeight ?? 0),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 14.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DashedBox(icon: icon, tone: accent),
          SizedBox(height: 10.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: family,
              fontSize: 12.5.sp,
              height: 1.25,
              fontWeight: FontWeight.w600,
              color: t.ink,
            ),
          ),
          SizedBox(height: 6.h),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 270.w),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: family,
                fontSize: 11.5.sp,
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
                fontSize: 11.sp,
                height: 1.4,
                color: t.secondary,
              ),
            ),
          ],
          if (actionLabel != null) ...[
            SizedBox(height: 14.h),
            // The app's filled action, so the one button on this card is the
            // same object as the one on every other screen: 12px radius,
            // 12.5/700 label, and no shadow under it.
            DentaButton(label: actionLabel!, onTap: onAction, expand: true),
          ],
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
        radius: 16.r,
        strokeWidth: 1.5,
      ),
      child: SizedBox(
        width: 50.w,
        height: 50.w,
        child: Center(
          child: Icon(icon, size: 20.w, color: tone),
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
