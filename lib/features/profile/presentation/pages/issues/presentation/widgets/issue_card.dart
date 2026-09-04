import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/presentation/widgets/issue_status_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';

/// One filed report.
///
/// Status is carried three ways so it survives at a glance: a 3px strip on
/// the leading edge, a tinted icon tile in the same hue, and a text pill.
/// The strip uses [PositionedDirectional] because a non-uniform [Border]
/// cannot coexist with a border radius, and because it has to move to the
/// right-hand side in Arabic.
class IssueCard extends StatelessWidget {
  const IssueCard({super.key, required this.issue});

  final IssueEntity issue;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final style = IssueStatusStyle.of(context, issue.status);
    final isDone = issue.status == IssueStatus.done;

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.borderLight),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          PositionedDirectional(
            start: 0,
            top: 0,
            bottom: 0,
            width: 3,
            child: ColoredBox(color: style.color),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.w, 13.h, 13.w, 13.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: style.tint(context),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(style.icon, size: 16.w, color: style.color),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              issue.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: FontHelper.fontFamily(context),
                                // A resolved report is greyed but not struck
                                // through — it was answered, not cancelled.
                                color: isDone
                                    ? c.textTertiary
                                    : c.textPrimary,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          _StatusPill(style: style),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        issue.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          color: c.textSecondary,
                          height: 1.35,
                        ),
                      ),
                      if (issue.createdAt != null) ...[
                        SizedBox(height: 7.h),
                        Text(
                          _formatDate(context, issue.createdAt!),
                          style: TextStyle(
                            fontSize: 9.5.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.4,
                            fontFamily: FontHelper.fontFamily(context),
                            color: c.textTertiary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Short absolute date. Deliberately not "2 days ago" — a report's age
  /// matters when chasing support, and a relative label hides it.
  static String _formatDate(BuildContext context, DateTime date) =>
      AppDate.mediumWithTime24(context, date.toLocal());
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.style});

  final IssueStatusStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: style.tint(context),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        style.label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          fontFamily: FontHelper.fontFamily(context),
          color: style.color,
        ),
      ),
    );
  }
}
