import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomeSubscriptionCard extends StatelessWidget {
  const HomeSubscriptionCard({
    super.key,
    required this.status,
    this.usage,
    required this.onViewPlans,
    required this.onUpgrade,
    required this.onClose,
  });

  final SubscriptionStatusEntity? status;
  final SubscriptionUsageEntity? usage;
  final VoidCallback onViewPlans;
  final VoidCallback onUpgrade;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    if (status == null) {
      return _CardShell(
        onClose: onClose,
        child: _NoSubscriptionContent(onStartTrial: onUpgrade),
      );
    }

    if (status!.isTrial) {
      return _CardShell(
        accent: status!.daysRemaining <= 7
            ? const Color(0xFFF59E0B)
            : ColorManager.primary,
        onClose: onClose,
        child: _TrialContent(status: status!, onUpgrade: onUpgrade),
      );
    }

    return _CardShell(
      onClose: onClose,
      child: _ActivePlanContent(
        status: status!,
        usage: usage,
        onViewPlans: onViewPlans,
      ),
    );
  }
}

// ─── Shell ─────────────────────────────────────────────────────────────────

class _CardShell extends StatelessWidget {
  const _CardShell({
    required this.child,
    required this.onClose,
    this.accent,
  });

  final Widget child;
  final VoidCallback onClose;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final color = accent ?? ColorManager.primary;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          decoration: BoxDecoration(
            gradient: accent != null
                ? LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.08),
                      color.withValues(alpha: 0.02),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: accent == null
                ? ColorManager.of(context).cardBgSecondary
                : null,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: accent != null
                  ? color.withValues(alpha: 0.2)
                  : ColorManager.of(context).borderLight,
            ),
          ),
          child: child,
        ),
        Positioned(
          top: 4.h,
          right: 4.w,
          child: IconButton(
            onPressed: onClose,
            icon: Icon(
              Icons.close,
              size: 16.w,
              color: ColorManager.of(context).textSubtle,
            ),
            padding: EdgeInsets.all(6.w),
            constraints: const BoxConstraints(),
            tooltip: AppLocalizations.of(context)!.close,
            splashRadius: 16.w,
          ),
        ),
      ],
    );
  }
}

// ─── No subscription ──────────────────────────────────────────────────────

class _NoSubscriptionContent extends StatelessWidget {
  const _NoSubscriptionContent({required this.onStartTrial});

  final VoidCallback onStartTrial;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        _IconBadge(icon: Icons.rocket_launch_outlined),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Title(l10n.noSubscription),
              SizedBox(height: 2.h),
              _Subtitle(l10n.tryAllFeatures),
            ],
          ),
        ),
        SizedBox(width: 28.w), // breathing room for close button
        _PrimaryButton(label: l10n.startFreeTrial, onTap: onStartTrial),
      ],
    );
  }
}

// ─── Trial ─────────────────────────────────────────────────────────────────

class _TrialContent extends StatelessWidget {
  const _TrialContent({required this.status, required this.onUpgrade});

  final SubscriptionStatusEntity status;
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final daysLeft = status.daysRemaining;
    final isUrgent = daysLeft <= 7;
    final accent = isUrgent ? const Color(0xFFF59E0B) : ColorManager.primary;
    final progress = (daysLeft / 30).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _IconBadge(
              icon: isUrgent ? Icons.timer_outlined : Icons.star_outline,
              color: accent,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Title(l10n.freeTrial),
                  SizedBox(height: 1.h),
                  _Subtitle(l10n.trialEndsIn(daysLeft)),
                ],
              ),
            ),
            SizedBox(width: 28.w),
            _Pill(label: l10n.daysLeft(daysLeft), color: accent),
          ],
        ),
        SizedBox(height: 14.h),
        _ProgressBar(value: progress, color: accent),
        SizedBox(height: 14.h),
        _PrimaryButton(label: l10n.upgradeNow, onTap: onUpgrade, fullWidth: true),
      ],
    );
  }
}

// ─── Active plan ──────────────────────────────────────────────────────────

class _ActivePlanContent extends StatelessWidget {
  const _ActivePlanContent({
    required this.status,
    required this.usage,
    required this.onViewPlans,
  });

  final SubscriptionStatusEntity status;
  final SubscriptionUsageEntity? usage;
  final VoidCallback onViewPlans;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isActive = status.isActive;
    final statusColor =
        isActive ? const Color(0xFF10B981) : const Color(0xFFF59E0B);
    final statusLabel = isActive ? l10n.active : l10n.inactive;
    final renewDate = status.endsAt != null
        ? DateFormat('MMM d, yyyy').format(status.endsAt!)
        : '—';

    final storage = usage?.metric('storage');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _IconBadge(icon: Icons.verified_outlined),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Title('${status.planName} ${l10n.plan}'.trim()),
                  SizedBox(height: 1.h),
                  _Subtitle(l10n.renewsOn(renewDate)),
                ],
              ),
            ),
            SizedBox(width: 28.w),
            _Pill(label: statusLabel, color: statusColor),
          ],
        ),
        if (storage != null) ...[
          SizedBox(height: 14.h),
          _UsageRow(metric: storage, label: l10n.storageUsed),
        ],
        SizedBox(height: 14.h),
        _OutlinedButton(label: l10n.viewAllPlans, onTap: onViewPlans),
      ],
    );
  }
}

// ─── Bits ─────────────────────────────────────────────────────────────────

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon, this.color});
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? ColorManager.primary;
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, size: 18.w, color: c),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: FontHelper.fontFamily(context),
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: ColorManager.of(context).textPrimary,
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: FontHelper.fontFamily(context),
        fontSize: 11.sp,
        color: ColorManager.of(context).textSubtle,
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: FontHelper.fontFamily(context),
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value, required this.color});
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.r),
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: color.withValues(alpha: 0.1),
        valueColor: AlwaysStoppedAnimation<Color>(color),
        minHeight: 6.h,
      ),
    );
  }
}

class _UsageRow extends StatelessWidget {
  const _UsageRow({required this.metric, required this.label});
  final UsageMetric metric;
  final String label;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = metric.progress > 0.85
        ? const Color(0xFFF59E0B)
        : ColorManager.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 12.sp,
                color: ColorManager.of(context).textSubtle,
              ),
            ),
            const Spacer(),
            Text(
              metric.isUnlimited
                  ? l10n.unlimited
                  : _formatUsage(metric),
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        _ProgressBar(value: metric.progress, color: color),
      ],
    );
  }

  String _formatUsage(UsageMetric metric) {
    final suffix = metric.unit.isEmpty ? '' : ' ${metric.unit}';
    return '${metric.used}$suffix / ${metric.limit}$suffix';
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.onTap,
    this.fullWidth = false,
  });
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final button = GestureDetector(
      onTap: onTap,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: EdgeInsets.symmetric(
          horizontal: fullWidth ? 0 : 14.w,
          vertical: fullWidth ? 10.h : 8.h,
        ),
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(fullWidth ? 10.r : 8.r),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: fullWidth ? 13.sp : 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
    return button;
  }
}

class _OutlinedButton extends StatelessWidget {
  const _OutlinedButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorManager.of(context).cardBg,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: ColorManager.primary),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: ColorManager.primary,
            ),
          ),
        ),
      ),
    );
  }
}
