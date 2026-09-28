import 'dart:async';

import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_details_sheet.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_list_card.dart';
import 'package:dental_clinic_app/features/appointments/presentation/widgets/appointment_status_styles.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';

/// The desktop home screen's sections below the stats row.
///
/// A phone stacks a list of shortcuts over a list of appointments because it
/// has one column. A desktop window has room to answer the questions a
/// clinic actually opens this screen with - who is next, how far through the
/// day are we, what is left - so it gets its own layout here. Mobile keeps
/// QuickActions and TodaysSchedule untouched.

bool _isCancelled(AppointmentStatus s) =>
    s == AppointmentStatus.cancelledByClinic ||
    s == AppointmentStatus.cancelledByPatient ||
    s == AppointmentStatus.noShow;

bool _isOpen(AppointmentStatus s) =>
    s == AppointmentStatus.scheduled || s == AppointmentStatus.confirmed;

/// The appointment in progress, or else the next one to start; null once
/// the day has nothing left.
AppointmentEntity? upNextAppointment(
  List<AppointmentEntity> sortedDay,
  DateTime now,
) {
  for (final a in sortedDay) {
    if (!_isOpen(a.status)) continue;
    final end = a.dateTime.add(Duration(minutes: a.durationMinutes));
    if (end.isAfter(now)) return a;
  }
  return null;
}

// ═══════════════════════════════════════════════════════════════
// QUICK ACTION TILES
// ═══════════════════════════════════════════════════════════════

/// The three things started most often, as one row of wide tiles under the
/// stats: coloured icon, the action, a line on what it does.
class DesktopQuickActionTiles extends StatelessWidget {
  const DesktopQuickActionTiles({
    super.key,
    required this.onAddPatient,
    required this.onNewAppointment,
    this.onRecordPayment,
  });

  final VoidCallback onAddPatient;
  final VoidCallback onNewAppointment;

  /// Null hides the tile - the roles that cannot see the expenses tab.
  final VoidCallback? onRecordPayment;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tiles = [
      _ActionTile(
        icon: Icons.person_add_alt_1_outlined,
        tone: ColorManager.primary,
        title: l10n.addPatient,
        hint: l10n.homeActionPatientHint,
        onTap: onAddPatient,
      ),
      _ActionTile(
        icon: Icons.event_available_outlined,
        tone: ColorManager.success,
        title: l10n.newAppointment,
        hint: l10n.homeActionAppointmentHint,
        onTap: onNewAppointment,
      ),
      if (onRecordPayment != null)
        _ActionTile(
          icon: Icons.payments_outlined,
          tone: ColorManager.warning,
          title: l10n.recordPayment,
          hint: l10n.homeActionPaymentHint,
          onTap: onRecordPayment!,
        ),
    ];

    return Row(
      children: [
        for (var i = 0; i < tiles.length; i++) ...[
          if (i > 0) const SizedBox(width: 14),
          Expanded(child: tiles[i]),
        ],
      ],
    );
  }
}

class _ActionTile extends StatefulWidget {
  const _ActionTile({
    required this.icon,
    required this.tone,
    required this.title,
    required this.hint,
    required this.onTap,
  });

  final IconData icon;
  final Color tone;
  final String title;
  final String hint;
  final VoidCallback onTap;

  @override
  State<_ActionTile> createState() => _ActionTileState();
}

class _ActionTileState extends State<_ActionTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final tone = widget.tone;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hovered ? tone.withValues(alpha: 0.5) : c.borderLight,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: tone.withValues(alpha: 0.12),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(widget.icon, color: tone, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.hint,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 12,
                        color: c.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _hovered ? tone : c.cardBgSecondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add_rounded,
                  size: 17,
                  color: _hovered ? ColorManager.white : c.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// TODAY'S TIMELINE
// ═══════════════════════════════════════════════════════════════

/// Today's appointments on a time rail: the time, a status-coloured dot on a
/// line, then who and what. The appointment that is next is lifted out in
/// the primary colour; finished ones step back.
class DesktopTodayTimeline extends StatelessWidget {
  const DesktopTodayTimeline({
    super.key,
    required this.appointments,
    required this.totalCount,
    required this.isLoading,
    required this.error,
    required this.upNextId,
    required this.onViewAll,
    required this.onNewAppointment,
    required this.onRetry,
  });

  /// Already sorted and capped to what fits.
  final List<AppointmentEntity> appointments;
  final int totalCount;
  final bool isLoading;
  final String? error;
  final String? upNextId;
  final VoidCallback onViewAll;
  final VoidCallback onNewAppointment;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 14),
            child: Row(
              children: [
                Text(
                  l10n.todaysSchedule,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                if (!isLoading && error == null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$totalCount',
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.primaryDarker,
                      ),
                    ),
                  ),
                const SizedBox(width: 10),
                Text(
                  AppDate.medium(context, DateTime.now()),
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 12.5,
                    color: c.textTertiary,
                  ),
                ),
                const Spacer(),
                // No "new appointment" here: the page already offers it in
                // the quick actions, and a third copy in this header only
                // competed with them.
                if (appointments.isNotEmpty)
                  TextButton(
                    onPressed: onViewAll,
                    style: TextButton.styleFrom(
                      foregroundColor: c.textSecondary,
                    ),
                    child: Text(
                      l10n.seeAll,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(height: 1, color: c.borderLight),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: _body(context, l10n),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, AppLocalizations l10n) {
    if (isLoading) {
      return Column(
        children: [
          for (var i = 0; i < 4; i++)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: AppointmentCardSkeleton(),
            ),
        ],
      );
    }

    if (error != null) {
      return _Message(
        icon: Icons.cloud_off_rounded,
        tone: ColorManager.warning,
        title: l10n.scheduleLoadFailed,
        message: error!,
        actionLabel: l10n.retry,
        onAction: onRetry,
      );
    }

    if (appointments.isEmpty) {
      return _Message(
        icon: Icons.calendar_month_outlined,
        tone: ColorManager.primary,
        title: l10n.noAppointmentsToday,
        message: l10n.noAppointmentsTodayHint,
        actionLabel: l10n.newAppointment,
        onAction: onNewAppointment,
      );
    }

    return Column(
      children: [
        for (var i = 0; i < appointments.length; i++)
          _TimelineRow(
            appointment: appointments[i],
            isFirst: i == 0,
            isLast: i == appointments.length - 1,
            isUpNext: appointments[i].id == upNextId,
          ),
      ],
    );
  }
}

class _TimelineRow extends StatefulWidget {
  const _TimelineRow({
    required this.appointment,
    required this.isFirst,
    required this.isLast,
    required this.isUpNext,
  });

  final AppointmentEntity appointment;
  final bool isFirst;
  final bool isLast;
  final bool isUpNext;

  @override
  State<_TimelineRow> createState() => _TimelineRowState();
}

class _TimelineRowState extends State<_TimelineRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final a = widget.appointment;
    final tone = AppointmentStatusStyles.color(a.status);
    final cancelled = _isCancelled(a.status);
    final done = a.status == AppointmentStatus.completed;
    final muted = cancelled || done;
    final highlight = widget.isUpNext;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Time
          SizedBox(
            width: 62,
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppDate.time24(context, a.dateTime),
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: highlight
                          ? ColorManager.primaryDarker
                          : muted
                          ? c.textTertiary
                          : c.textPrimary,
                    ),
                  ),
                  Text(
                    AppointmentListCard.formatDuration(a.durationMinutes),
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 11,
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Rail
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 2,
                  height: 18,
                  color: widget.isFirst ? Colors.transparent : c.borderLight,
                ),
                Container(
                  width: highlight ? 14 : 10,
                  height: highlight ? 14 : 10,
                  decoration: BoxDecoration(
                    color: highlight ? ColorManager.primary : tone,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: c.cardBg,
                      width: highlight ? 3 : 2,
                    ),
                    boxShadow: highlight
                        ? [
                            BoxShadow(
                              color: ColorManager.primary.withValues(
                                alpha: 0.35,
                              ),
                              blurRadius: 6,
                            ),
                          ]
                        : null,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: widget.isLast ? Colors.transparent : c.borderLight,
                  ),
                ),
              ],
            ),
          ),
          // Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _hovered = true),
                onExit: (_) => setState(() => _hovered = false),
                child: GestureDetector(
                  onTap: () => AppointmentDetailsSheet.show(context, a),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    padding: const EdgeInsets.fromLTRB(14, 10, 12, 10),
                    decoration: BoxDecoration(
                      color: highlight
                          ? ColorManager.primary.withValues(alpha: 0.07)
                          : _hovered
                          ? c.cardBgSecondary
                          : c.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: highlight
                            ? ColorManager.primary.withValues(alpha: 0.45)
                            : c.borderLight,
                      ),
                    ),
                    child: Opacity(
                      opacity: muted ? 0.6 : 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  a.patientName.isNotEmpty
                                      ? a.patientName
                                      : '-',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: family,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: c.textPrimary,
                                    decoration: cancelled
                                        ? TextDecoration.lineThrough
                                        : null,
                                    decorationColor: c.textTertiary,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                _MetaLine(appointment: a),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          AppointmentStatusPill(status: a.status),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "Filling · Dr. Sami" - whichever of the two the appointment has.
class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.appointment});

  final AppointmentEntity appointment;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final style = TextStyle(
      fontFamily: family,
      fontSize: 12,
      color: c.textTertiary,
    );
    final treatment = appointment.treatmentType.trim();
    final doctor = appointment.doctorName.trim();

    return Row(
      children: [
        if (treatment.isNotEmpty) ...[
          Icon(Icons.medical_services_outlined, size: 13, color: c.textSubtle),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              treatment,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
          ),
        ],
        if (treatment.isNotEmpty && doctor.isNotEmpty)
          const SizedBox(width: 12),
        if (doctor.isNotEmpty) ...[
          Icon(Icons.person_outline, size: 13, color: c.textSubtle),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              doctor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
          ),
        ],
      ],
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    required this.icon,
    required this.tone,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final Color tone;
  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 44),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 26, color: tone),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: family,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: family,
                fontSize: 12.5,
                height: 1.5,
                color: c.textTertiary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onAction,
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(
              actionLabel,
              style: TextStyle(fontFamily: family, fontWeight: FontWeight.w600),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// UP NEXT
// ═══════════════════════════════════════════════════════════════

/// Who the clinic is waiting for, and how long until they are due. Ticks
/// once a minute so "starts in 12m" does not go stale on an open screen.
class DesktopUpNextCard extends StatefulWidget {
  const DesktopUpNextCard({super.key, required this.appointments});

  /// Today's appointments, sorted.
  final List<AppointmentEntity> appointments;

  @override
  State<DesktopUpNextCard> createState() => _DesktopUpNextCardState();
}

class _DesktopUpNextCardState extends State<DesktopUpNextCard> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(
      const Duration(minutes: 1),
      (_) => mounted ? setState(() {}) : null,
    );
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final now = DateTime.now();
    final next = upNextAppointment(widget.appointments, now);

    if (next == null) {
      return _SideCard(
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: ColorManager.success.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.check_circle_outline,
                color: ColorManager.success,
                size: 21,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.homeNoMoreToday,
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: c.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.homeNoMoreTodayHint,
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 12,
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final started = !next.dateTime.isAfter(now);
    final minutes = next.dateTime.difference(now).inMinutes + 1;
    final when = started
        ? l10n.homeInProgress
        : l10n.homeStartsIn(AppointmentListCard.formatDuration(minutes));

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => AppointmentDetailsSheet.show(context, next),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ColorManager.primary, ColorManager.primaryDark],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    l10n.homeUpNext,
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.white.withValues(alpha: 0.85),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      when,
                      style: TextStyle(
                        fontFamily: family,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                AppDate.time24(context, next.dateTime),
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                  letterSpacing: -0.5,
                  color: ColorManager.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                next.patientName.isNotEmpty ? next.patientName : '-',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.white,
                ),
              ),
              const SizedBox(height: 10),
              if (next.treatmentType.trim().isNotEmpty)
                _WhiteMeta(
                  icon: Icons.medical_services_outlined,
                  text: next.treatmentType.trim(),
                ),
              if (next.doctorName.trim().isNotEmpty) ...[
                const SizedBox(height: 4),
                _WhiteMeta(
                  icon: Icons.person_outline,
                  text: next.doctorName.trim(),
                ),
              ],
              const SizedBox(height: 4),
              _WhiteMeta(
                icon: Icons.schedule_rounded,
                text: AppointmentListCard.formatDuration(next.durationMinutes),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhiteMeta extends StatelessWidget {
  const _WhiteMeta({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: ColorManager.white.withValues(alpha: 0.8)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 12.5,
              color: ColorManager.white.withValues(alpha: 0.9),
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// DAY PROGRESS
// ═══════════════════════════════════════════════════════════════

/// How far through the day the clinic is: a bar, then done / remaining /
/// cancelled. Cancelled appointments are left out of the bar - they are not
/// work that is still to do, nor work that got done.
class DesktopDayProgressCard extends StatelessWidget {
  const DesktopDayProgressCard({super.key, required this.appointments});

  final List<AppointmentEntity> appointments;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    final done = appointments
        .where((a) => a.status == AppointmentStatus.completed)
        .length;
    final cancelled = appointments.where((a) => _isCancelled(a.status)).length;
    final remaining = appointments.where((a) => _isOpen(a.status)).length;
    final workload = done + remaining;
    final progress = workload == 0 ? 0.0 : done / workload;

    return _SideCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.homeDayProgress,
            style: TextStyle(
              fontFamily: family,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            l10n.homeDoneOfTotal(done, workload),
            style: TextStyle(
              fontFamily: family,
              fontSize: 12,
              color: c.textTertiary,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: c.cardBgSecondary,
              color: ColorManager.success,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _Figure(
                value: done,
                label: l10n.completed,
                tone: ColorManager.success,
              ),
              _Figure(
                value: remaining,
                label: l10n.remaining,
                tone: ColorManager.primary,
              ),
              _Figure(
                value: cancelled,
                label: l10n.cancelled,
                tone: ColorManager.error,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure({required this.value, required this.label, required this.tone});

  final int value;
  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(
                '$value',
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: c.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: family,
              fontSize: 11.5,
              color: c.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SideCard extends StatelessWidget {
  const _SideCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderLight),
      ),
      child: child,
    );
  }
}
