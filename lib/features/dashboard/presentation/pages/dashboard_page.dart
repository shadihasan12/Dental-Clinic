import 'package:dental_clinic_app/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:dental_clinic_app/features/dashboard/presentation/widgets/quick_actions.dart';
import 'package:dental_clinic_app/features/dashboard/presentation/widgets/stats_grid.dart';
import 'package:dental_clinic_app/features/dashboard/presentation/widgets/todays_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';

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
                    context.pushNamed(AppRoutesNames.newAppointment),
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
}
