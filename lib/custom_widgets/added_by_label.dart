import 'package:dental_clinic_app/core/models/audit_entry.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';

/// Small `Added by <name> · May 17` caption that detail pages render
/// once, near the top of the content.
///
/// Hides itself entirely when there's no CREATE entry — that keeps
/// older records (saved before the backend started emitting `audits`)
/// from showing an empty line.
class AddedByLabel extends StatelessWidget {
  const AddedByLabel({
    super.key,
    required this.audits,
    this.createdAt,
    this.padding,
  });

  final List<AuditEntry> audits;

  /// Used for the trailing date chip. The API ships this on the root
  /// of the record (not on the audit row), so the caller passes it
  /// alongside the audits list.
  final DateTime? createdAt;

  /// Optional outer padding. Defaults to none so callers can place the
  /// label inside their own layout grid without surprises.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final create =
        audits.where((a) => a.isCreate).firstOrNull ?? audits.firstOrNull;
    if (create == null || create.userFullname.isEmpty) {
      return const SizedBox.shrink();
    }

    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final byPrefix = isArabic ? 'أضافه ' : 'Added by ';
    final date = createdAt;
    final dateLabel =
        date == null ? null : AppDate.dayMonth(context, date);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          Icon(
            Icons.person_outline_rounded,
            size: 14.w,
            color: c.textTertiary,
          ),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              dateLabel == null
                  ? '$byPrefix${create.userFullname}'
                  : '$byPrefix${create.userFullname} · $dateLabel',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 12.sp,
                color: c.textTertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
