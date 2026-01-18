import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';

class InvitationCard extends StatelessWidget {
  final InvitationEntity invitation;
  final bool isUpdating;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const InvitationCard({
    super.key,
    required this.invitation,
    required this.isUpdating,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.business,
                  color: ColorManager.primary,
                  size: 24.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invitation.clinicName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontFamily.geist,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.info.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            'Dentist',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: FontFamily.geist,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.infoLight,
                            ),
                          ),
                        ),
                        if (invitation.invitedByName != null) ...[
                          SizedBox(width: 8.w),
                          Text(
                            'by ${invitation.invitedByName}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: FontFamily.geist,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (invitation.message != null && invitation.message!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: ColorManager.gray50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                invitation.message!,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontFamily.geist,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],

          SizedBox(height: 16.h),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ActionButton(
                  text: 'Decline',
                  onPressed: isUpdating ? null : onReject,
                  fillColor: ColorManager.white,
                  filled: false,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ActionButton(
                  text: 'Accept',
                  onPressed: isUpdating ? null : onAccept,
                  fillColor: ColorManager.primary,
                  textColor: ColorManager.white,
                  filled: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
