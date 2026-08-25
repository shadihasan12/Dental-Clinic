import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// "Saved - add a treatment now?", as a bottom sheet.
///
/// A sheet rather than a centre dialog: this is a choice, not a destructive
/// confirmation, and the record the question is about stays visible behind it.
/// Returns `true` for add-treatment, `false` or `null` for not now.
class PatientSavedSheet {
  PatientSavedSheet._();

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      useSafeArea: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => const _PatientSavedSheetBody(),
    );
  }
}

class _PatientSavedSheetBody extends StatelessWidget {
  const _PatientSavedSheetBody();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: systemBottomInset(context),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10.h),
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: c.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.w, 14.h, 8.w, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 34.w,
                    height: 34.w,
                    decoration: BoxDecoration(
                      color: ColorManager.success.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(11.r),
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      size: 19.w,
                      color: ColorManager.success,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      l10n.patientSavedSuccessfully,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: family,
                        color: c.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context, false),
                    icon: Icon(
                      Icons.close_rounded,
                      size: 20.w,
                      color: c.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 6.h, 20.w, 0),
              child: Text(
                l10n.addTreatmentQuestion,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  height: 1.45,
                  fontFamily: family,
                  color: c.textSecondary,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 14.h),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: c.textPrimary,
                        side: BorderSide(color: c.border),
                        minimumSize: Size(0, 46.h),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        l10n.notNow,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                          fontFamily: family,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                        foregroundColor: ColorManager.white,
                        elevation: 0,
                        minimumSize: Size(0, 46.h),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        l10n.addTreatment,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                          fontFamily: family,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
