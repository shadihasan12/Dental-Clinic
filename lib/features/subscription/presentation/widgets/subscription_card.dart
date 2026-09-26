import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/directional_chevron.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Subscription state at the top of Settings, laid out as a membership card.
///
/// A band tinted in the status hue carries the plan and where it stands, with
/// the days left as a ring beside it - the one number someone opens this
/// page to check. Usage sits in a quiet strip under it, and the footer gives
/// the next date and a single way forward. The whole card opens the
/// subscription screen; a filled button only appears when something needs
/// doing (lapsed, awaiting payment, or a trial in its last week).
class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.status,
    this.usage,
    this.isLoading = false,
    required this.onViewPlans,
    required this.onUpgrade,
    this.onClose,
  });

  final SubscriptionStatusEntity? status;
  final SubscriptionUsageEntity? usage;
  final bool isLoading;
  final VoidCallback onViewPlans;
  final VoidCallback onUpgrade;

  /// Dismisses the card. Null where the card is the point of the screen it
  /// sits on - Settings has nothing to dismiss it back to.
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const _Skeleton();
    final l10n = AppLocalizations.of(context)!;
    final look = _Look.of(context, l10n, status);
    final s = status;

    return _Shell(
      accent: look.accent,
      onTap: onViewPlans,
      band: _Band(
        look: look,
        title: s == null ? l10n.noSubscription : _planName(s, l10n),
        caption: s == null
            ? l10n.subscriptionPlan
            : (s.isTrial ? l10n.freeTrial : l10n.currentPlan),
        ring: s == null ? null : _ringFor(s, look.accent),
        onClose: onClose,
      ),
      body: _body(context, l10n, look),
      footer: _Footer(
        date: s == null ? null : _dateLine(context, l10n, s),
        dateTone: look.urgent ? look.accent : null,
        action: _actionLabel(l10n, s, look),
        filled: look.needsAction,
        onTap: look.needsAction ? onUpgrade : onViewPlans,
      ),
    );
  }

  Widget? _body(BuildContext context, AppLocalizations l10n, _Look look) {
    final s = status;
    // Lapsed or problem states: the sentence explaining it matters more
    // than usage figures.
    if (look.message != null) return _Message(text: look.message!);
    if (s == null || s.isTrial) return null;
    final metrics = [
      if (usage?.users != null)
        (Icons.people_outline, l10n.seatsLabel, usage!.users!),
      if (usage?.storage != null)
        (Icons.cloud_outlined, l10n.storageUsed, usage!.storage!),
    ];
    if (metrics.isEmpty) return null;
    return Row(
      children: [
        for (var i = 0; i < metrics.length; i++) ...[
          if (i > 0) SizedBox(width: 14.w),
          Expanded(
            child: _Metric(
              icon: metrics[i].$1,
              label: metrics[i].$2,
              metric: metrics[i].$3,
            ),
          ),
        ],
      ],
    );
  }

  /// Days left as a share of the period, when the period is running.
  _Ring? _ringFor(SubscriptionStatusEntity s, Color accent) {
    if (!(s.isTrial || s.isActive) || s.endsAt == null) return null;
    final days = s.daysRemaining;
    final start = s.startsAt;
    final total = start != null
        ? s.endsAt!.difference(start).inDays
        : (s.isTrial
            ? 30
            : ((s.billingPeriod ?? '').toLowerCase().contains('year')
                ? 365
                : 30));
    return _Ring(
      days: days,
      progress: total <= 0 ? 0 : days / total,
      color: accent,
    );
  }

  String? _dateLine(
    BuildContext context,
    AppLocalizations l10n,
    SubscriptionStatusEntity s,
  ) {
    String line(String label, DateTime d) =>
        '$label · ${AppDate.medium(context, d)}';
    if (s.isGrace) {
      final ends = s.graceEndsAt ?? s.endsAt;
      return ends == null ? null : line(l10n.graceEndsLabel, ends);
    }
    if (s.endsAt == null) return null;
    if (s.isExpired) return line(l10n.endedLabel, s.endsAt!);
    if (s.isTrial) return line(l10n.trialEndsLabel, s.endsAt!);
    final next = s.nextCycle;
    if (s.isActive && next?.startsAt != null) {
      return l10n.nextCycleBooked(
        next!.planName,
        AppDate.medium(context, next.startsAt!),
      );
    }
    if (s.isActive) return line(l10n.renewsLabel, s.endsAt!);
    return null;
  }

  String _actionLabel(
    AppLocalizations l10n,
    SubscriptionStatusEntity? s,
    _Look look,
  ) {
    if (!look.needsAction) return l10n.viewSubscription;
    if (s == null) return l10n.viewSubscription;
    if (s.isTrial) return l10n.upgradeNow;
    return l10n.renewAction;
  }
}

// ─── Look ──────────────────────────────────────────────────────────────────

/// Everything that follows from the status: hue, icon, chip, and whether the
/// card asks for action. Order matters - a trial can lapse, so the lapsed
/// states are checked before isTrial.
class _Look {
  const _Look({
    required this.accent,
    required this.icon,
    required this.chip,
    this.message,
    this.needsAction = false,
    this.urgent = false,
  });

  final Color accent;
  final IconData icon;
  final String chip;
  final String? message;

  /// Paying is the way forward: the footer becomes a filled button.
  final bool needsAction;

  /// The date in the footer is the problem, so it takes the hue.
  final bool urgent;

  static _Look of(
    BuildContext context,
    AppLocalizations l10n,
    SubscriptionStatusEntity? s,
  ) {
    if (s == null) {
      return _Look(
        accent: ColorManager.of(context).textTertiary,
        icon: Icons.workspace_premium_outlined,
        chip: l10n.inactive,
        message: l10n.noPlanActiveBody,
      );
    }
    if (s.isExpired || s.isPendingActivation || s.isCanceled) {
      final (chip, body) = s.isPendingActivation
          ? (l10n.subStatusPending, l10n.subBodyPending)
          : s.isCanceled
              ? (l10n.subStatusCanceled, l10n.subBodyCanceled)
              : (l10n.expired, l10n.subscriptionExpiredBody);
      return _Look(
        accent: s.isPendingActivation ? ColorManager.warning : ColorManager.error,
        icon: s.isPendingActivation
            ? Icons.hourglass_top_rounded
            : Icons.lock_clock_outlined,
        chip: chip,
        message: body,
        needsAction: true,
        urgent: true,
      );
    }
    if (s.isGrace) {
      return _Look(
        accent: ColorManager.warning,
        icon: Icons.warning_amber_rounded,
        chip: l10n.subStatusGrace,
        message: l10n.subscriptionGraceBody,
        needsAction: true,
        urgent: true,
      );
    }
    if (s.isTrial) {
      // A week out is when it stops being background information.
      final urgent = s.daysRemaining <= 7;
      return _Look(
        accent: urgent ? ColorManager.warning : ColorManager.primary,
        icon: Icons.card_giftcard_outlined,
        chip: l10n.subStatusTrialing,
        needsAction: true,
        urgent: urgent,
      );
    }
    final live = s.isActive;
    return _Look(
      accent: live ? ColorManager.success : ColorManager.warning,
      icon: live ? Icons.verified_outlined : Icons.pause_circle_outline,
      chip: live ? l10n.active : l10n.inactive,
      // Renewed ahead: the end date is not a deadline any more.
      urgent: live && s.daysRemaining <= 7 && s.nextCycle == null,
    );
  }
}

// ─── Shell ─────────────────────────────────────────────────────────────────

class _Shell extends StatelessWidget {
  const _Shell({
    required this.accent,
    required this.onTap,
    required this.band,
    required this.footer,
    this.body,
  });

  final Color accent;
  final VoidCallback onTap;
  final Widget band;
  final Widget? body;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final radius = BorderRadius.circular(18.r);
    return Material(
      color: c.cardBg,
      // The radius lives on [shape] only: Material asserts when both are set.
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: accent.withValues(alpha: 0.28)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            band,
            if (body != null)
              Padding(
                padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 2.h),
                child: body,
              ),
            footer,
          ],
        ),
      ),
    );
  }
}

class _Band extends StatelessWidget {
  const _Band({
    required this.look,
    required this.title,
    required this.caption,
    this.ring,
    this.onClose,
  });

  final _Look look;
  final String title;
  final String caption;
  final _Ring? ring;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final accent = look.accent;

    return Container(
      color: accent.withValues(alpha: 0.08),
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: c.cardBg,
              shape: BoxShape.circle,
              border: Border.all(color: accent.withValues(alpha: 0.35)),
            ),
            child: Icon(look.icon, size: 20.w, color: accent),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 10.5.sp,
                    color: c.textTertiary,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 15.5.sp,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
                SizedBox(height: 6.h),
                _Chip(label: look.chip, color: accent),
              ],
            ),
          ),
          if (ring != null) ...[SizedBox(width: 10.w), ring!],
          if (onClose != null)
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: InkResponse(
                onTap: onClose,
                radius: 18.w,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(
                    Icons.close_rounded,
                    size: 15.w,
                    color: c.textSubtle,
                    semanticLabel: AppLocalizations.of(context)!.close,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.action,
    required this.filled,
    required this.onTap,
    this.date,
    this.dateTone,
  });

  final String? date;
  final Color? dateTone;
  final String action;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final dateText = date == null
        ? null
        : Row(
            children: [
              Icon(
                Icons.event_outlined,
                size: 14.w,
                color: dateTone ?? c.textTertiary,
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  date!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 11.5.sp,
                    fontWeight:
                        dateTone == null ? FontWeight.w500 : FontWeight.w600,
                    color: dateTone ?? c.textSecondary,
                  ),
                ),
              ),
            ],
          );

    if (filled) {
      return Padding(
        padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (dateText != null) ...[dateText, SizedBox(height: 10.h)],
            FilledButton(
              onPressed: onTap,
              style: FilledButton.styleFrom(
                backgroundColor: ColorManager.primary,
                foregroundColor: ColorManager.white,
                minimumSize: Size(0, 40.h),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                action,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        SizedBox(height: 10.h),
        Divider(height: 1, color: c.borderLight),
        Padding(
          padding: EdgeInsets.fromLTRB(14.w, 11.h, 10.w, 11.h),
          child: Row(
            children: [
              Expanded(child: dateText ?? const SizedBox.shrink()),
              SizedBox(width: 8.w),
              Text(
                action,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primaryDarker,
                ),
              ),
              DirectionalChevron(size: 18.w, color: ColorManager.primaryDarker),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Pieces ────────────────────────────────────────────────────────────────

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 5.w),
          Text(
            label,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Days left, inside a ring that empties as the period runs out.
class _Ring extends StatelessWidget {
  const _Ring({
    required this.days,
    required this.progress,
    required this.color,
  });

  final int days;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final size = 58.w;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              strokeWidth: 5.w,
              strokeCap: StrokeCap.round,
              backgroundColor: color.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$days',
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 16.sp,
                  height: 1.05,
                  fontWeight: FontWeight.w800,
                  color: c.textPrimary,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.daysUnit(days),
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 8.5.sp,
                  height: 1.1,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.icon,
    required this.label,
    required this.metric,
  });

  final IconData icon;
  final String label;
  final UsageMetric metric;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final tight = !metric.isUnlimited && metric.progress > 0.85;
    final suffix = metric.unit.isEmpty ? '' : ' ${metric.unit}';
    final value = metric.isUnlimited
        ? l10n.unlimited
        : '${metric.used} / ${metric.limit}$suffix';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 13.w, color: c.textTertiary),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: family,
                  fontSize: 10.5.sp,
                  color: c.textTertiary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontFamily: family,
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w700,
            color: tight ? ColorManager.warning : c.textPrimary,
          ),
        ),
        SizedBox(height: 6.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(999.r),
          child: LinearProgressIndicator(
            value: metric.isUnlimited ? 0 : metric.progress.clamp(0.0, 1.0),
            minHeight: 4.h,
            backgroundColor: c.cardBgSecondary,
            valueColor: AlwaysStoppedAnimation(
              tight ? ColorManager.warning : ColorManager.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Text(
      text,
      style: TextStyle(
        fontFamily: FontHelper.fontFamily(context),
        fontSize: 12.sp,
        height: 1.45,
        color: c.textSecondary,
      ),
    );
  }
}

// ─── Skeleton ──────────────────────────────────────────────────────────────

/// Holds the loaded card's slots - band with avatar, lines and ring, usage
/// strip, footer - so nothing jumps when data lands.
class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShimmerBox(
                width: 40.w,
                height: 40.w,
                radius: BorderRadius.circular(999.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 70.w, height: 9.h),
                    SizedBox(height: 6.h),
                    ShimmerBox(width: 120.w, height: 13.h),
                    SizedBox(height: 7.h),
                    ShimmerBox(
                      width: 56.w,
                      height: 16.h,
                      radius: BorderRadius.circular(999.r),
                    ),
                  ],
                ),
              ),
              ShimmerBox(
                width: 58.w,
                height: 58.w,
                radius: BorderRadius.circular(999.r),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: ShimmerBox(height: 30.h)),
              SizedBox(width: 14.w),
              Expanded(child: ShimmerBox(height: 30.h)),
            ],
          ),
          SizedBox(height: 14.h),
          ShimmerBox(width: double.infinity, height: 14.h),
        ],
      ),
    );
  }
}

// ─── Helpers ───────────────────────────────────────────────────────────────

String _planName(SubscriptionStatusEntity s, AppLocalizations l10n) {
  final name = s.planName.trim();
  return name.isEmpty ? l10n.subscriptionPlan : name;
}
