import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final String? confirmText;
  final String? cancelText;

  const ConfirmDeleteDialog({
    super.key,
    this.title,
    this.message,
    this.confirmText,
    this.cancelText,
  });

  /// Shows the dialog and returns true if confirmed, false otherwise.
  static Future<bool> show(
    BuildContext context, {
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmDeleteDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final resolvedTitle = title ?? l10n.deleteTreatment;
    final resolvedMessage = message ?? l10n.confirmDeleteTreatment;
    final resolvedConfirm = confirmText ?? l10n.delete;
    final resolvedCancel = cancelText ?? l10n.cancel;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: ColorManager.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline,
                size: 24.w,
                color: ColorManager.error,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              resolvedTitle,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              resolvedMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.of(context).textSecondary,
                height: 1.4,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, false),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: ColorManager.of(context).cardBgSecondary,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: ColorManager.of(context).borderLight),
                      ),
                      child: Text(
                        resolvedCancel,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          fontWeight: FontWeight.w600,
                          color: ColorManager.of(context).textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, true),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: ColorManager.error,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        resolvedConfirm,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          fontWeight: FontWeight.w600,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
