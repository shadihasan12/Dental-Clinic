import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';

class PatientHeader extends StatelessWidget {
  final String name;
  final int age;
  final String gender;
  final String phone;
  final VoidCallback onBackPressed;
  final VoidCallback? onEditPressed;
  final TabController tabController;

  const PatientHeader({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.onBackPressed,
    required this.tabController,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: GradientManager.primaryHeader,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(),
            _buildPatientInfo(),
            _buildTabBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: ColorManager.white),
            onPressed: onBackPressed,
          ),
          const Spacer(),
          if (onEditPressed != null)
            IconButton(
              icon: const Icon(Icons.edit, color: ColorManager.white),
              onPressed: onEditPressed,
            ),
        ],
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 16.h),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 22.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w600,
              color: ColorManager.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '$age years • $gender',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontFamily.geist,
              fontWeight: FontWeight.w400,
              color: ColorManager.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: tabController,
      labelColor: ColorManager.white,
      unselectedLabelColor: ColorManager.white.withValues(alpha: 0.6),
      indicatorColor: ColorManager.white,
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontFamily: FontFamily.geist,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontFamily: FontFamily.geist,
        fontWeight: FontWeight.w400,
      ),
      tabs: const [
        Tab(text: 'Info'),
        Tab(text: 'Case'),
        Tab(text: 'History'),
      ],
    );
  }
}