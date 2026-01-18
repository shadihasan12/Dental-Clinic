import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';

class PatientHeader extends StatelessWidget {
  final String name;
  final int age;
  final String gender;
  final double totalPaid;
  final double totalPending;
  final VoidCallback onBackPressed;
  final VoidCallback? onEditPressed;

  const PatientHeader({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.totalPaid,
    required this.totalPending,
    required this.onBackPressed,
    this.onEditPressed,
  });

  String get _initials => name.split(' ').map((n) => n[0]).take(2).join();

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
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
      child: Column(
        children: [
          _buildAvatar(),
          SizedBox(height: 12.h),
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
          SizedBox(height: 16.h),
          _buildStats(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 72.w,
      height: 72.h,
      decoration: BoxDecoration(
        color: ColorManager.white,
        shape: BoxShape.circle,
        border: Border.all(color: ColorManager.white, width: 3),
      ),
      child: Center(
        child: Text(
          _initials,
          style: TextStyle(
            color: ColorManager.primary,
            fontSize: 24.sp,
            fontFamily: FontFamily.geist,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        _buildStatCard('Total Paid', '\$${totalPaid.toStringAsFixed(0)}'),
        SizedBox(width: 12.w),
        _buildStatCard('Pending', '\$${totalPending.toStringAsFixed(0)}'),
      ],
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: ColorManager.white.withValues(alpha: 0.2),
          borderRadius: BorderRadiusManager.lg,
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w400,
                color: ColorManager.white.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w600,
                color: ColorManager.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}