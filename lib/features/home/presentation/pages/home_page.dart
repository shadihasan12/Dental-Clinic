import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_header.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/quick_actions.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/stats_grid.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/todays_schedule.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _userName = 'Dr. Smith';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // — Header: greeting + actions
              HomeHeader(
                userName: _userName,
                clinicName: '[Clinic name here]',
                onNotificationTap: () {},
              ),

              SizedBox(height: 24.h),

              // — Quick actions row
              Text(
                AppLocalizations.of(context)!.quickActions,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontHelper.fontFamily(context),
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 12.h),
              QuickActions(
                onAddPatient: () =>
                    context.pushNamed(AppRoutesNames.addPatient),
                onScheduleVisit: () =>
                    context.pushNamed(AppRoutesNames.newAppointment),
                onNewCase: () {},
                onRecordPayment: () {},
              ),

              SizedBox(height: 40.h),

              // — Today's schedule
              TodaysSchedule(onViewAllTap: () {}),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
