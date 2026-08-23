import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// Subscription state on Home, rebuilt against DENTA_STYLE.md.
///
/// What the user comes to this card for is one number - how long until the
/// plan stops working - so that number is a labelled tile rather than a
/// sentence, tinted when it is a problem. Status is carried the way the rest
/// of the app carries it: a 3px leading border plus an icon tile in the same
/// hue, no gradients and no shadows.
///
/// Two states the old card never rendered are now here: expired and grace
/// period. [SubscriptionStatusEntity] has always carried `isExpired`,
/// `isInGracePeriod` and `graceEndsAt`, but every non-trial subscription fell
/// through to the same "active plan" body, so a lapsed clinic was shown a
/// green-ish card that said nothing was wrong.
class HomeSubscriptionCard extends StatelessWidget {
  const HomeSubscriptionCard({
    super.key,
    required this.status,
    this.usage,
    this.isLoading = false,
    required this.onViewPlans,
    required this.onUpgrade,
    required this.onClose,
  });

  final SubscriptionStatusEntity? status;
  final SubscriptionUsageEntity? usage;
  final bool isLoading;
  final VoidCallback onViewPlans;
  final VoidCallback onUpgrade;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const _Skeleton();

    final s = status;
    if (s == null) return _NoPlanCard(onStartTrial: onUpgrade, onClose: onClose);

    // Order matters: a trial can lapse, so the lapsed states are checked
    // before isTrial rather than after it.
    if (s.isExpired) {
      return _ExpiredCard(
        status: s,
        onRenew: onUpgrade,
        onViewPlans: onViewPlans,
        onClose: onClose,
      );
    }
    if (s.isInGracePeriod) {
      return _GraceCard(
        status: s,
        onRenew: onUpgrade,
        onViewPlans: onViewPlans,
        onClose: onClose,
      );
    }
    if (s.isTrial) {
      return _TrialCard(status: s, onUpgrade: onUpgrade, onClose: onClose);
    }
    return _PlanCard(
      status: s,
      usage: usage,
      onViewPlans: onViewPlans,
      onClose: onClose,
    );
  }
}

// ─── Shell ─────────────────────────────────────────────────────────────────

/// Card 16px radius, 1px hairline, and the status hue as a 3px leading stripe.
///
/// The stripe is a clipped child rather than a thicker [BorderDirectional]
/// side: Flutter asserts on any bordered box that mixes side colours with a
/// borderRadius, so a 3px accent edge cannot be expressed as part of the
/// border. Being a real child, it still mirrors to the trailing edge in RTL,
/// and [IntrinsicHeight] is what lets it match the content height inside a
/// scroll view, where the row's own height is unbounded.
class _Shell extends StatelessWidget {
  const _Shell({required this.accent, required this.child});

  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.borderLight),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: 3, child: ColoredBox(color: accent)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(13.w, 13.h, 13.w, 13.h),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Icon tile, title, optional trailing pill, and the dismiss control. The ×
/// lives in the row rather than a positioned overlay so it mirrors under RTL
/// and stops the title needing a hardcoded gap to dodge it.
class _CardHead extends StatelessWidget {
  const _CardHead({
    required this.icon,
    required this.accent,
    required this.title,
    required this.onClose,
    this.subtitle,
    this.pillLabel,
    this.pillColor,
  });

  final IconData icon;
  final Color accent;
  final String title;
  final String? subtitle;
  final String? pillLabel;
  final Color? pillColor;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34.w,
          height: 34.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, size: 17.w, color: accent),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: family,
                  color: c.textPrimary,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 2.h),
                Text(
                  subtitle!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    height: 1.35,
                    fontFamily: family,
                    color: c.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (pillLabel != null) ...[
          SizedBox(width: 8.w),
          _StatusPill(label: pillLabel!, color: pillColor ?? accent),
        ],
        SizedBox(width: 2.w),
        InkResponse(
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
      ],
    );
  }
}

// ─── Variants ──────────────────────────────────────────────────────────────

class _TrialCard extends StatelessWidget {
  const _TrialCard({
    required this.status,
    required this.onUpgrade,
    required this.onClose,
  });

  final SubscriptionStatusEntity status;
  final VoidCallback onUpgrade;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final days = status.daysRemaining;
    // A week out is when it stops being background information.
    final urgent = days <= 7;
    final accent = urgent ? ColorManager.warning : ColorManager.primary;

    return _Shell(
      accent: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHead(
            icon: urgent ? Icons.timer_outlined : Icons.schedule_outlined,
            accent: accent,
            title: l10n.freeTrial,
            onClose: onClose,
          ),
          SizedBox(height: 9.h),
          Row(
            children: [
              Expanded(
                child: _NumberTile(
                  label: l10n.daysRemaining,
                  value: '$days',
                  problem: urgent,
                ),
              ),
              if (status.endsAt != null) ...[
                SizedBox(width: 8.w),
                Expanded(
                  child: _NumberTile(
                    label: l10n.endsLabel,
                    value: _shortDate(context, status.endsAt!),
                    small: true,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 9.h),
          _Bar(value: (days / 30).clamp(0.0, 1.0), color: accent),
          SizedBox(height: 11.h),
          _FilledAction(label: l10n.upgradeNow, onTap: onUpgrade),
        ],
      ),
    );
  }
}

class _GraceCard extends StatelessWidget {
  const _GraceCard({
    required this.status,
    required this.onRenew,
    required this.onViewPlans,
    required this.onClose,
  });

  final SubscriptionStatusEntity status;
  final VoidCallback onRenew;
  final VoidCallback onViewPlans;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ends = status.graceEndsAt ?? status.endsAt;

    return _Shell(
      accent: ColorManager.warning,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHead(
            icon: Icons.error_outline_rounded,
            accent: ColorManager.warning,
            title: _planTitle(status, l10n),
            subtitle: l10n.subscriptionGraceBody,
            onClose: onClose,
          ),
          if (ends != null) ...[
            SizedBox(height: 9.h),
            _NumberTile(
              label: l10n.graceEndsLabel,
              value: _shortDate(context, ends),
              problem: true,
              small: true,
            ),
          ],
          SizedBox(height: 11.h),
          _ActionPair(
            primaryLabel: l10n.renewAction,
            onPrimary: onRenew,
            secondaryLabel: l10n.viewAllPlans,
            onSecondary: onViewPlans,
          ),
        ],
      ),
    );
  }
}

class _ExpiredCard extends StatelessWidget {
  const _ExpiredCard({
    required this.status,
    required this.onRenew,
    required this.onViewPlans,
    required this.onClose,
  });

  final SubscriptionStatusEntity status;
  final VoidCallback onRenew;
  final VoidCallback onViewPlans;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return _Shell(
      accent: ColorManager.error,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHead(
            icon: Icons.block_outlined,
            accent: ColorManager.error,
            title: _planTitle(status, l10n),
            subtitle: l10n.subscriptionExpiredBody,
            pillLabel: l10n.expired,
            pillColor: ColorManager.error,
            onClose: onClose,
          ),
          if (status.endsAt != null) ...[
            SizedBox(height: 9.h),
            _NumberTile(
              label: l10n.endedLabel,
              value: _shortDate(context, status.endsAt!),
              problem: true,
              small: true,
            ),
          ],
          SizedBox(height: 11.h),
          _ActionPair(
            primaryLabel: l10n.renewAction,
            onPrimary: onRenew,
            secondaryLabel: l10n.viewAllPlans,
            onSecondary: onViewPlans,
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.status,
    required this.usage,
    required this.onViewPlans,
    required this.onClose,
  });

  final SubscriptionStatusEntity status;
  final SubscriptionUsageEntity? usage;
  final VoidCallback onViewPlans;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final live = status.isActive;
    final accent = live ? ColorManager.success : ColorManager.warning;
    final storage = usage?.metric('storage');

    return _Shell(
      accent: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHead(
            icon: live ? Icons.check_circle_outline : Icons.pause_circle_outline,
            accent: accent,
            title: _planTitle(status, l10n),
            pillLabel: live ? l10n.active : l10n.inactive,
            pillColor: accent,
            onClose: onClose,
          ),
          if (status.endsAt != null) ...[
            SizedBox(height: 9.h),
            _NumberTile(
              label: l10n.renewsLabel,
              value: _shortDate(context, status.endsAt!),
              small: true,
            ),
          ],
          if (storage != null) ...[
            SizedBox(height: 9.h),
            _UsageBlock(metric: storage, label: l10n.storageUsed),
          ],
          SizedBox(height: 11.h),
          _OutlinedAction(label: l10n.viewAllPlans, onTap: onViewPlans),
        ],
      ),
    );
  }
}

/// Empty state per the style guide: dashed border, one factual sentence, and
/// the single action that fills it.
class _NoPlanCard extends StatelessWidget {
  const _NoPlanCard({required this.onStartTrial, required this.onClose});

  final VoidCallback onStartTrial;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    return CustomPaint(
      painter: _DashedBorderPainter(color: c.border, radius: 16.r),
      child: Padding(
        padding: EdgeInsets.fromLTRB(13.w, 13.h, 13.w, 13.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.noSubscription,
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: family,
                          color: c.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        l10n.noPlanActiveBody,
                        style: TextStyle(
                          fontSize: 11.sp,
                          height: 1.35,
                          fontFamily: family,
                          color: c.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                InkResponse(
                  onTap: onClose,
                  radius: 18.w,
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Icon(
                      Icons.close_rounded,
                      size: 15.w,
                      color: c.textSubtle,
                      semanticLabel: l10n.close,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 11.h),
            _FilledAction(label: l10n.startFreeTrial, onTap: onStartTrial),
          ],
        ),
      ),
    );
  }
}

// ─── Pieces ────────────────────────────────────────────────────────────────

/// Uppercase micro-label over a bold value, in a tinted inner card when the
/// value is the problem. Same tile the patient header uses.
class _NumberTile extends StatelessWidget {
  const _NumberTile({
    required this.label,
    required this.value,
    this.problem = false,
    this.small = false,
  });

  final String label;
  final String value;
  final bool problem;

  /// Dates need to fit; they get the 15px size rather than the 20px one
  /// reserved for a real figure.
  final bool small;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: problem ? c.warningBg : c.cardBgSecondary,
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(
          color: problem
              ? ColorManager.warning.withValues(alpha: 0.35)
              : c.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
              fontFamily: family,
              color: c.textTertiary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: small ? 15.sp : 20.sp,
              height: 1.15,
              fontWeight: FontWeight.w700,
              letterSpacing: small ? 0 : -0.3,
              fontFamily: family,
              color: problem ? ColorManager.warning : c.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          fontFamily: FontHelper.fontFamily(context),
          color: color,
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.value, required this.color});
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(999.r),
      child: LinearProgressIndicator(
        value: value.clamp(0.0, 1.0),
        minHeight: 6.h,
        backgroundColor: c.cardBgSecondary,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}

class _UsageBlock extends StatelessWidget {
  const _UsageBlock({required this.metric, required this.label});
  final UsageMetric metric;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final tight = metric.progress > 0.85;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontFamily: family,
                color: c.textSecondary,
              ),
            ),
            const Spacer(),
            Text(
              metric.isUnlimited ? l10n.unlimited : _usage(metric),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                fontFamily: family,
                color: tight ? ColorManager.warning : c.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        _Bar(
          value: metric.progress,
          color: tight ? ColorManager.warning : ColorManager.primary,
        ),
      ],
    );
  }

  String _usage(UsageMetric m) {
    final suffix = m.unit.isEmpty ? '' : ' ${m.unit}';
    return '${m.used}$suffix / ${m.limit}$suffix';
  }
}

// ─── Actions ───────────────────────────────────────────────────────────────

class _FilledAction extends StatelessWidget {
  const _FilledAction({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          minimumSize: Size(0, 38.h),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w600,
            fontFamily: FontHelper.fontFamily(context),
          ),
        ),
      ),
    );
  }
}

class _OutlinedAction extends StatelessWidget {
  const _OutlinedAction({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorManager.primaryDarker,
          // 1.5px in its own hue, per the style guide's rule for a
          // primary-bordered element.
          side: const BorderSide(color: ColorManager.primary, width: 1.5),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          minimumSize: Size(0, 38.h),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w600,
            fontFamily: FontHelper.fontFamily(context),
          ),
        ),
      ),
    );
  }
}

/// Never more than two, primary leading.
class _ActionPair extends StatelessWidget {
  const _ActionPair({
    required this.primaryLabel,
    required this.onPrimary,
    required this.secondaryLabel,
    required this.onSecondary,
  });

  final String primaryLabel;
  final VoidCallback onPrimary;
  final String secondaryLabel;
  final VoidCallback onSecondary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _FilledAction(label: primaryLabel, onTap: onPrimary)),
        SizedBox(width: 8.w),
        Expanded(
          child: _OutlinedAction(label: secondaryLabel, onTap: onSecondary),
        ),
      ],
    );
  }
}

// ─── Skeleton ──────────────────────────────────────────────────────────────

/// Holds the same slots the loaded card will: icon tile, two text lines, a
/// number tile row, a bar and a button, so nothing jumps when data lands.
class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(13.w, 13.h, 13.w, 13.h),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShimmerBox(
                width: 34.w,
                height: 34.w,
                radius: BorderRadius.circular(10.r),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 110.w, height: 12.h),
                    SizedBox(height: 6.h),
                    ShimmerBox(width: 150.w, height: 10.h),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 9.h),
          Row(
            children: [
              Expanded(
                child: ShimmerBox(
                  height: 46.h,
                  radius: BorderRadius.circular(13.r),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ShimmerBox(
                  height: 46.h,
                  radius: BorderRadius.circular(13.r),
                ),
              ),
            ],
          ),
          SizedBox(height: 9.h),
          ShimmerBox(height: 6.h, radius: BorderRadius.circular(999.r)),
          SizedBox(height: 11.h),
          ShimmerBox(
            width: double.infinity,
            height: 38.h,
            radius: BorderRadius.circular(12.r),
          ),
        ],
      ),
    );
  }
}

// ─── Helpers ───────────────────────────────────────────────────────────────

String _planTitle(SubscriptionStatusEntity s, AppLocalizations l10n) {
  final name = s.planName.trim();
  return name.isEmpty ? l10n.subscriptionPlan : '$name ${l10n.plan}'.trim();
}

/// Locale-aware. The old card hardcoded `MMM d, yyyy`, which rendered an
/// English month name inside the Arabic build.
String _shortDate(BuildContext context, DateTime d) =>
    DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(d);

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );

    const dash = 5.0;
    const gap = 4.0;
    for (final metric in path.computeMetrics()) {
      var start = 0.0;
      while (start < metric.length) {
        final end = (start + dash).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(start, end), paint);
        start = end + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color || old.radius != radius;
}
