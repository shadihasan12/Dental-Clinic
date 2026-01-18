import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:dental_clinic_app/features/clinic/presentation/bloc/invitation_bloc.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/invitation_card.dart';

class PendingInvitationsSection extends StatelessWidget {
  final List<InvitationEntity> invitations;
  final bool isUpdating;

  const PendingInvitationsSection({
    super.key,
    required this.invitations,
    required this.isUpdating,
  });

  @override
  Widget build(BuildContext context) {
    if (invitations.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverMainAxisGroup(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.mail_outline,
                      size: 20.w,
                      color: ColorManager.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Pending Invitations',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        fontFamily: FontFamily.geist,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        '${invitations.length}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: FontFamily.geist,
                          color: ColorManager.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Invitations List
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final invitation = invitations[index];
                return InvitationCard(
                  invitation: invitation,
                  isUpdating: isUpdating,
                  onAccept: () {
                    context.read<InvitationBloc>().add(
                          InvitationEvent.acceptInvitation(invitation.id),
                        );
                  },
                  onReject: () {
                    context.read<InvitationBloc>().add(
                          InvitationEvent.rejectInvitation(invitation.id),
                        );
                  },
                );
              },
              childCount: invitations.length,
            ),
          ),
        ),

        // Spacing
        SliverToBoxAdapter(child: SizedBox(height: 16.h)),
      ],
    );
  }
}
