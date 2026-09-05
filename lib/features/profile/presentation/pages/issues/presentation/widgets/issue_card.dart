import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_files_section.dart';
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
  const IssueCard({
    super.key,
    required this.issue,
    this.statusLabel,
    this.categoryLabel,
  });

  final IssueEntity issue;

  /// Labels as the server translated them. Null falls back to this build's
  /// own strings, and for a value it does not know, to the raw wire value.
  final String? statusLabel;
  final String? categoryLabel;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final style = IssueStatusStyle.of(
      context,
      issue.statusKind,
      serverLabel: statusLabel,
    );
    final isSettled =
        issue.statusKind == IssueStatus.resolved ||
        issue.statusKind == IssueStatus.closed;

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
                                // A settled report is greyed but not struck
                                // through — it was answered, not cancelled.
                                color: isSettled
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
                      SizedBox(height: 8.h),
                      _MetaRow(
                        issue: issue,
                        categoryLabel: categoryLabel,
                      ),
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
}

/// Category, last activity, and a way into the screenshots.
class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.issue, required this.categoryLabel});

  final IssueEntity issue;
  final String? categoryLabel;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    // `updated_at` is what the list is sorted by and what moves when support
    // acts, so it is the date worth showing; the filing date is only the
    // fallback for a payload without one.
    final stamp = issue.updatedAt ?? issue.createdAt;

    final label = categoryLabel ?? issue.category;

    return Row(
      children: [
        if (label.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: c.cardBgSecondary,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 9.5.sp,
                fontWeight: FontWeight.w500,
                fontFamily: family,
                color: c.textSecondary,
              ),
            ),
          ),
          SizedBox(width: 8.w),
        ],
        if (stamp != null)
          Flexible(
            child: Text(
              AppDate.mediumWithTime24(context, stamp.toLocal()),
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
          ),
        if (issue.hasAttachments) ...[
          SizedBox(width: 8.w),
          _AttachmentsChip(attachments: issue.attachments),
        ],
      ],
    );
  }
}

/// Opens the report's screenshots in the shared full-screen viewer.
///
/// The links are signed and expire an hour after the list was fetched; a
/// pull to refresh mints new ones, which is why nothing here caches them.
/// Only the `view` link is handed over — the viewer previews, it does not
/// save.
class _AttachmentsChip extends StatelessWidget {
  const _AttachmentsChip({required this.attachments});

  final List<IssueAttachmentEntity> attachments;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return GestureDetector(
      onTap: () => CaseFileViewer.open(
        context,
        attachments: [
          for (final a in attachments)
            CaseAttachment(id: a.mediaItemId, url: a.viewUrl),
        ],
        initialIndex: 0,
      ),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.attach_file_rounded, size: 12.w, color: c.textTertiary),
          SizedBox(width: 2.w),
          Text(
            '${attachments.length}',
            style: TextStyle(
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w600,
              fontFamily: FontHelper.fontFamily(context),
              color: c.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.style});

  final IssueStatusStyle style;

  @override
  Widget build(BuildContext context) {
    if (style.label.isEmpty) return const SizedBox.shrink();
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
