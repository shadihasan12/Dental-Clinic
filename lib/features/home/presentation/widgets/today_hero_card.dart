import 'dart:async';
import 'dart:math' as math;

import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/count_up_text.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_details_sheet.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_status_styles.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The state of the day, at the top of the home screen.
///
/// Two questions, answered together: how far through today the clinic is
/// (the ring) and who is next, in how long (the countdown). Both are read
/// straight off the appointment list the screen already loads, so the card
/// costs no request of its own - and both change on their own as the day
/// runs, which is what makes the screen feel alive rather than decorated.
///
/// The card shows nothing at all on a day with no live appointments; the
/// schedule below already has a designed empty state, and two of them
/// stacked would only say the same thing twice.
class TodayHeroCard extends StatefulWidget {
  const TodayHeroCard({
    super.key,
    required this.appointments,
    this.isLoading = false,
  });

  /// Today's appointments in time order - the full day, not the truncated
  /// list the schedule below renders, so the counts are the real ones.
  final List<AppointmentEntity> appointments;

  final bool isLoading;

  /// How long before the start the approach bar begins to fill.
  static const Duration _approachWindow = Duration(minutes: 60);

  /// Inside this, the countdown pill pulses.
  static const Duration _urgentWindow = Duration(minutes: 10);

  /// Whether the card will draw anything for [appointments].
  ///
  /// The page needs this to decide whether to reserve the gap above the
  /// card, and the card's own build reads it too - so the rule that a day of
  /// nothing but cancellations shows no card lives in exactly one place.
  static bool hasContent(List<AppointmentEntity> appointments) =>
      appointments.any(
        (a) =>
            a.status != AppointmentStatus.cancelledByClinic &&
            a.status != AppointmentStatus.cancelledByPatient,
      );

  @override
  State<TodayHeroCard> createState() => _TodayHeroCardState();
}

class _TodayHeroCardState extends State<TodayHeroCard>
    with SingleTickerProviderStateMixin {
  /// Re-reads the clock rather than the server: everything on this card is
  /// derived from data already in memory, so a tick is a `setState` and a
  /// repaint, nothing more. Thirty seconds keeps "in 25 min" honest to
  /// within half a minute.
  static const Duration _tickInterval = Duration(seconds: 30);

  Timer? _ticker;
  late final AnimationController _pulse;

  AppointmentEntity? _next;
  Duration _untilNext = Duration.zero;
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _recompute();
    _ticker = Timer.periodic(_tickInterval, (_) {
      if (!mounted) return;
      setState(_recompute);
    });
  }

  @override
  void didUpdateWidget(TodayHeroCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // A rebuild is already on its way, so this only refreshes the derived
    // values - no setState.
    if (!identical(oldWidget.appointments, widget.appointments)) _recompute();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _pulse.dispose();
    super.dispose();
  }

  /// Appointments that can still happen or already did. Cancellations are
  /// out of both the numerator and the denominator: counting them would
  /// leave the ring permanently short of full on any day someone cancelled,
  /// which reads as unfinished work that nobody can finish.
  Iterable<AppointmentEntity> get _live => widget.appointments.where(
    (a) =>
        a.status != AppointmentStatus.cancelledByClinic &&
        a.status != AppointmentStatus.cancelledByPatient,
  );

  /// Settled one way or the other. A no-show is done with - the slot is
  /// behind the clinic even though nobody was treated in it.
  int get _doneCount => _live
      .where(
        (a) =>
            a.status == AppointmentStatus.completed ||
            a.status == AppointmentStatus.noShow,
      )
      .length;

  /// The first appointment still ahead of the clinic, which is the one it
  /// needs to be ready for. An appointment that has started but not ended
  /// counts as that one - it is what the room is doing now.
  void _recompute() {
    final now = DateTime.now();

    AppointmentEntity? found;
    for (final a in widget.appointments) {
      if (a.status != AppointmentStatus.scheduled &&
          a.status != AppointmentStatus.confirmed) {
        continue;
      }
      if (a.dateTime.add(Duration(minutes: a.durationMinutes)).isAfter(now)) {
        found = a;
        break;
      }
    }

    _next = found;
    if (found == null) {
      _untilNext = Duration.zero;
      _inProgress = false;
    } else {
      _inProgress = !found.dateTime.isAfter(now);
      _untilNext = found.dateTime.difference(now);
    }

    // The pulse is only ever running in the last few minutes before a start,
    // so the card is still the rest of the time.
    final urgent =
        found != null &&
        !_inProgress &&
        _untilNext < TodayHeroCard._urgentWindow;
    if (urgent) {
      if (!_pulse.isAnimating) _pulse.repeat(reverse: true);
    } else if (_pulse.isAnimating) {
      _pulse.stop();
      _pulse.value = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) return const _HeroSkeleton();

    if (!TodayHeroCard.hasContent(widget.appointments)) {
      return const SizedBox.shrink();
    }
    final total = _live.length;

    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final done = _doneCount;
    final next = _next;

    final card = Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
      decoration: _heroDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _DayProgressRing(done: done, total: total),
              SizedBox(width: 14.w),
              Expanded(
                child: next == null
                    ? _DayCompletePanel(total: total)
                    : _NextUpPanel(
                        appointment: next,
                        untilNext: _untilNext,
                        inProgress: _inProgress,
                        pulse: _pulse,
                      ),
              ),
            ],
          ),
          if (next != null && _showsApproachBar) ...[
            SizedBox(height: 12.h),
            _ApproachBar(
              progress: _approachProgress(next),
              color: _inProgress
                  ? AppointmentStatusStyles.color(next.status)
                  : ColorManager.primaryDark,
            ),
          ],
          SizedBox(height: 10.h),
          Text(
            l10n.doneOfTotal(done, total),
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: c.textTertiary,
            ),
          ),
        ],
      ),
    );

    if (next == null) return card;

    // The whole card is the tap target for the appointment it is about -
    // the same details sheet a row in the schedule below opens.
    return Material(
      color: ColorManager.transparent,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: () => AppointmentDetailsSheet.show(context, next),
        borderRadius: BorderRadius.circular(16.r),
        child: card,
      ),
    );
  }

  /// Only drawn once the appointment is close enough for the fill to move
  /// visibly - an empty rail an hour out is noise, not information.
  bool get _showsApproachBar =>
      _inProgress || _untilNext <= TodayHeroCard._approachWindow;

  double _approachProgress(AppointmentEntity next) {
    if (_inProgress) {
      final total = next.durationMinutes;
      if (total <= 0) return 1;
      final elapsed = DateTime.now().difference(next.dateTime).inSeconds;
      return (elapsed / (total * 60)).clamp(0.0, 1.0);
    }
    final window = TodayHeroCard._approachWindow.inSeconds;
    return (1 - _untilNext.inSeconds / window).clamp(0.0, 1.0);
  }
}

/// Elevation in this app is a border, never a shadow, and a card surface is
/// never a gradient - both are house rules, and a home screen is the last
/// place to start diverging from them.
BoxDecoration _heroDecoration(BuildContext context) {
  final c = ColorManager.of(context);

  return BoxDecoration(
    color: c.cardBg,
    borderRadius: BorderRadius.circular(16.r),
    border: Border.all(color: c.borderLight),
  );
}

// ─── Ring ───────────────────────────────────────────────────────────────────

/// How much of the day is behind the clinic, as an arc that grows when an
/// appointment is marked done rather than redrawing at a new length.
class _DayProgressRing extends StatelessWidget {
  const _DayProgressRing({required this.done, required this.total});

  final int done;
  final int total;

  static const double _size = 62;
  static const double _stroke = 5.5;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final progress = total == 0 ? 0.0 : done / total;
    final complete = done == total;
    final fill = complete ? ColorManager.success : ColorManager.primaryDark;

    return SizedBox(
      width: _size.w,
      height: _size.w,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: progress),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) => CustomPaint(
          painter: _RingPainter(
            progress: value,
            track: c.divider,
            fill: fill,
            stroke: _stroke.w,
          ),
          child: child,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            // Pinned LTR: "3/8" is a fraction, not a sentence, and Arabic
            // reads it the same way round as English.
            textDirection: TextDirection.ltr,
            children: [
              CountUpText(
                value: done,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 17.sp,
                  height: 1,
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
              Text(
                '/$total',
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 10.5.sp,
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.progress,
    required this.track,
    required this.fill,
    required this.stroke,
  });

  final double progress;
  final Color track;
  final Color fill;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: (size.shortestSide - stroke) / 2,
    );

    final trackPaint = Paint()
      ..color = track
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    canvas.drawCircle(rect.center, rect.width / 2, trackPaint);

    if (progress <= 0) return;

    // Clockwise from twelve o'clock, the way every dial the user already
    // knows runs - deliberately not mirrored in RTL.
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      Paint()
        ..color = fill
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress ||
      old.track != track ||
      old.fill != fill ||
      old.stroke != stroke;
}

// ─── Panels ─────────────────────────────────────────────────────────────────

class _NextUpPanel extends StatelessWidget {
  const _NextUpPanel({
    required this.appointment,
    required this.untilNext,
    required this.inProgress,
    required this.pulse,
  });

  final AppointmentEntity appointment;
  final Duration untilNext;
  final bool inProgress;
  final Animation<double> pulse;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    final subtitle = [
      AppDate.time24(context, appointment.dateTime),
      if (appointment.treatmentType.isNotEmpty) appointment.treatmentType,
    ].join(' · ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.nextUp.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 9.5.sp,
                  height: 1.2,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w500,
                  color: c.textTertiary,
                ),
              ),
            ),
            SizedBox(width: 6.w),
            _CountdownPill(
              label: _countdownLabel(l10n),
              inProgress: inProgress,
              tone: inProgress
                  ? AppointmentStatusStyles.color(appointment.status)
                  : ColorManager.primaryDarker,
              pulse: pulse,
            ),
          ],
        ),
        SizedBox(height: 5.h),
        Text(
          appointment.patientName.isNotEmpty ? appointment.patientName : '-',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: family,
            fontSize: 15.sp,
            height: 1.2,
            letterSpacing: -0.2,
            fontWeight: FontWeight.w700,
            color: c.textPrimary,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: family,
            fontSize: 11.5.sp,
            height: 1.2,
            fontWeight: FontWeight.w500,
            color: c.textSecondary,
          ),
        ),
      ],
    );
  }

  String _countdownLabel(AppLocalizations l10n) {
    if (inProgress) return l10n.nowLabel;

    final minutes = untilNext.inMinutes;
    if (minutes < 1) return l10n.startingNow;
    if (minutes < 60) return l10n.inTime(l10n.durationMinutes(minutes));

    final hours = minutes ~/ 60;
    final rest = minutes % 60;
    return l10n.inTime(
      rest == 0
          ? l10n.durationHours(hours)
          : l10n.durationHoursMinutes(hours, rest),
    );
  }
}

/// The countdown itself. Inside the urgent window [pulse] is running and the
/// tint breathes; outside it the controller is stopped at zero, so this is a
/// flat chip that costs nothing.
class _CountdownPill extends StatelessWidget {
  const _CountdownPill({
    required this.label,
    required this.inProgress,
    required this.tone,
    required this.pulse,
  });

  final String label;
  final bool inProgress;
  final Color tone;
  final Animation<double> pulse;

  @override
  Widget build(BuildContext context) {
    final family = FontHelper.fontFamily(context);

    return AnimatedBuilder(
      animation: pulse,
      builder: (context, _) {
        final lift = Curves.easeInOut.transform(pulse.value);
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.12 + 0.14 * lift),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (inProgress) ...[
                Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    color: tone,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 5.w),
              ],
              Text(
                label,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 11.sp,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: tone,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Everything on today's list is settled - shown instead of a next patient,
/// with the ring already full behind it.
class _DayCompletePanel extends StatelessWidget {
  const _DayCompletePanel({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 16.w,
              color: ColorManager.success,
            ),
            SizedBox(width: 6.w),
            Flexible(
              child: Text(
                l10n.dayComplete,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 15.sp,
                  height: 1.2,
                  letterSpacing: -0.2,
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          l10n.dayCompleteHint,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: family,
            fontSize: 11.5.sp,
            height: 1.3,
            fontWeight: FontWeight.w500,
            color: c.textSecondary,
          ),
        ),
      ],
    );
  }
}

// ─── Approach bar ───────────────────────────────────────────────────────────

/// A rail that fills as the appointment comes up, and - once it has started -
/// as it runs. Its only job is to move: it is the part of the card that
/// changes on every tick even when the minute count has not.
class _ApproachBar extends StatelessWidget {
  const _ApproachBar({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(3.r),
      child: SizedBox(
        height: 4.h,
        child: Stack(
          children: [
            Positioned.fill(child: ColoredBox(color: c.divider)),
            // Fraction of the rail, so it grows from the leading edge and
            // mirrors correctly in Arabic without any work here.
            Positioned.fill(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                builder: (context, value, _) => FractionallySizedBox(
                  alignment: AlignmentDirectional.centerStart,
                  widthFactor: value.clamp(0.0, 1.0),
                  child: ColoredBox(color: color),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Skeleton ───────────────────────────────────────────────────────────────

/// Holds the card's real height while the first load runs, so the schedule
/// below does not jump when the data lands.
class _HeroSkeleton extends StatelessWidget {
  const _HeroSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
      decoration: _heroDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShimmerBox(
                width: _DayProgressRing._size.w,
                height: _DayProgressRing._size.w,
                radius: BorderRadius.circular(_DayProgressRing._size.w),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 54.w, height: 10.h),
                    SizedBox(height: 8.h),
                    ShimmerBox(width: 140.w, height: 15.h),
                    SizedBox(height: 6.h),
                    ShimmerBox(width: 100.w, height: 11.h),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ShimmerBox(width: double.infinity, height: 4.h),
          SizedBox(height: 10.h),
          ShimmerBox(width: 88.w, height: 11.h),
        ],
      ),
    );
  }
}
