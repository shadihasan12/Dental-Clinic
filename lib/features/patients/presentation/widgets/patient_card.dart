import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// Data model for patient display
class Patient {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String phone;
  final String? nextVisit;
  final double balance;

  const Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    this.nextVisit,
    required this.balance,
  });

  String get initials {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    return parts.take(2).map((p) => p.characters.first).join().toUpperCase();
  }
}

/// One patient row.
///
/// Elevation is a hairline, not a shadow. An outstanding balance is the only
/// thing on this screen that is a problem, so it is what the 3px leading
/// border reports - amber when money is owed, neutral otherwise - and it
/// repeats as an amber pill on the trailing side of the row.
///
/// Edit and delete live behind a swipe rather than on the card face: two
/// tinted circles competing with the patient's name cost roughly a third
/// of the row's width, and the name is the thing being scanned for. The
/// pane opens from the trailing edge, so it comes from the right in LTR
/// and from the left in Arabic — `Slidable` reads [Directionality] for
/// that, no branching needed here.
///
/// The list wraps its items in a `SlidableAutoCloseBehavior` so opening
/// one card closes any other; [groupTag] is what ties them together.
class PatientCard extends StatelessWidget {
  const PatientCard({
    super.key,
    required this.patient,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  /// Shared by every patient row so only one pane can be open at a time.
  static const String groupTag = 'patients-list';

  final Patient patient;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final hasActions = onEdit != null || onDelete != null;
    final radius = BorderRadius.circular(16.r);
    final owes = patient.balance > 0;

    final card = Material(
      color: c.cardBg,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            // Uniform border only: a BoxDecoration that mixes side widths
            // with a borderRadius throws while painting and leaves the card
            // blank though still tappable. The accent is a stripe instead.
            border: Border.all(color: c.borderLight),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              if (owes)
                PositionedDirectional(
                  start: 0,
                  top: 0,
                  bottom: 0,
                  width: 3.w,
                  child: const ColoredBox(color: ColorManager.warning),
                ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  owes ? 14.w : 12.w,
                  12.h,
                  12.w,
                  12.h,
                ),
                child: Column(
                  children: [
                    _buildMainRow(context),
                    if (patient.nextVisit != null) ...[
                      SizedBox(height: 9.h),
                      _buildNextVisit(context),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // The gap used to be the card's own bottom margin. It sits outside the
    // Slidable now, otherwise the action pane would stretch past the card
    // and the buttons would not line up with it.
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: hasActions
          ? Slidable(
              key: ValueKey(patient.id),
              groupTag: groupTag,
              endActionPane: _buildActionPane(context, radius),
              child: card,
            )
          : card,
    );
  }

  ActionPane _buildActionPane(BuildContext context, BorderRadius radius) {
    final l10n = AppLocalizations.of(context)!;
    final actions = <_SlideActionSpec>[
      if (onEdit != null)
        _SlideActionSpec(
          icon: Icons.edit_outlined,
          label: l10n.edit,
          background: ColorManager.primary,
          onPressed: onEdit!,
        ),
      if (onDelete != null)
        _SlideActionSpec(
          icon: Icons.delete_outline,
          label: l10n.delete,
          background: ColorManager.error,
          onPressed: onDelete!,
        ),
    ];

    return ActionPane(
      motion: const DrawerMotion(),
      // Each button wants ~82.w; extentRatio is measured against the width
      // the pane is laid out in, which is the full list row.
      extentRatio: actions.length == 2 ? 0.44 : 0.24,
      children: [
        for (final spec in actions) _SlideAction(spec: spec, radius: radius),
      ],
    );
  }

  Widget _buildMainRow(BuildContext context) {
    return Row(
      children: [
        _buildAvatar(context),
        SizedBox(width: 11.w),
        Expanded(child: _buildPatientInfo(context)),
        if (patient.balance > 0) ...[
          SizedBox(width: 8.w),
          _buildBalancePill(context),
        ],
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        patient.initials,
        style: TextStyle(
          color: ColorManager.primaryDarker,
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
          fontFamily: FontHelper.fontFamily(context),
        ),
      ),
    );
  }

  Widget _buildPatientInfo(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    final genderLabel =
        patient.gender.toLowerCase() == 'female' ? l10n.female : l10n.male;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          patient.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontFamily: family,
            color: c.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 3.h),
        Row(
          children: [
            Flexible(
              child: Text(
                '${patient.age} ${l10n.years} - $genderLabel',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: family,
                  color: c.textTertiary,
                ),
              ),
            ),
            if (patient.phone.isNotEmpty) ...[
              SizedBox(width: 8.w),
              Icon(Icons.phone_outlined, size: 12.w, color: c.textSubtle),
              SizedBox(width: 3.w),
              Flexible(
                child: Text(
                  patient.phone,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: family,
                    color: c.textTertiary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  /// What is owed, in the hue the leading border already set.
  Widget _buildBalancePill(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: ColorManager.warning.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        '\$${patient.balance.toInt()}',
        style: TextStyle(
          fontSize: 11.5.sp,
          height: 1.2,
          fontFamily: FontHelper.fontFamily(context),
          color: ColorManager.warning,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildNextVisit(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 12.w,
            color: ColorManager.primaryDarker,
          ),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              '${l10n.nextVisit}: ${patient.nextVisit}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.primaryDarker,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// What one slide-out button does, separated from how it is drawn so the
/// pane can work out which button sits on the outer edge.
class _SlideActionSpec {
  const _SlideActionSpec({
    required this.icon,
    required this.label,
    required this.background,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final Color background;
  final VoidCallback onPressed;
}

/// A full-height button in the swipe pane.
///
/// Hand-rolled rather than `SlidableAction` so the icon, label and radius
/// follow the app's own type and colour scale instead of the package's
/// Material defaults.
class _SlideAction extends StatelessWidget {
  const _SlideAction({required this.spec, required this.radius});

  final _SlideActionSpec spec;

  /// Applied to all four corners — each action reads as its own button
  /// rather than as a slab welded to the edge of the row.
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        // Fully rounded buttons need a real gap between them; a hairline
        // would leave the facing corners looking pinched.
        padding: EdgeInsetsDirectional.only(start: 6.w),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // Collapse the pane before running the action; otherwise the row
            // is still open underneath the edit page or the delete dialog,
            // and stays open when the user comes back.
            Slidable.of(context)?.close();
            spec.onPressed();
          },
          child: Container(
            decoration: BoxDecoration(
              color: spec.background,
              borderRadius: radius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(spec.icon, size: 18.w, color: ColorManager.white),
                SizedBox(height: 4.h),
                Text(
                  spec.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
