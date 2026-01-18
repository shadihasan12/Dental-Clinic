import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/user_subscription_entity.dart';
import 'package:dental_clinic_app/features/subscription/presentation/widgets/subscription_status_card.dart';
import '../widgets/widgets.dart';

/// Main dashboard page showing overview of clinic metrics and schedule
/// Adapts based on user's context:
/// - If user owns a clinic → Shows clinic management
/// - If user doesn't own a clinic → Shows "Create Practice" prompt
/// - Shows pending invitations regardless of ownership
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final String _userName = 'Dr. Smith';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(
              userName: _userName,
              clinicName: '[Clinic name here]',
            ),
            // Stats grid overlapping header
            Transform.translate(
              offset: Offset(0, -24.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const StatsGrid(),
              ),
            ),

            // Quick actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: QuickActions(
                onAddPatient: () =>
                    context.pushNamed(AppRoutesNames.addPatient),
                onScheduleVisit: () =>
                    context.pushNamed(AppRoutesNames.bookAppointment),
                onNewCase: () {},
                onRecordPayment: () {},
              ),
            ),
            SizedBox(height: 16.h),

            // Today's schedule
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TodaysSchedule(onViewAllTap: () {}),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  // Widget _buildClinicManagementSection() {
  //   return ClinicManagementSection(
  //     clinicName: _ownedClinicName,
  //     staffCount: _staffCount,
  //     pendingApprovalsCount: _pendingApprovalsCount,
  //     onManageStaff: () {
  //       context.pushNamed(
  //         AppRoutesNames.staffManagement,
  //         pathParameters: {'clinicId': _ownedClinicId},
  //       );
  //     },
  //     onPendingApprovals: () {
  //       context.pushNamed(
  //         AppRoutesNames.pendingApprovals,
  //         pathParameters: {'clinicId': _ownedClinicId},
  //       );
  //     },
  //     onInviteStaff: () {
  //       context.pushNamed(
  //         AppRoutesNames.inviteStaff,
  //         extra: {'clinicId': _ownedClinicId, 'clinicName': _ownedClinicName},
  //       );
  //     },
  //   );
  // }
}
