import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';

/// Header for patients list page with title, count, add button and search bar
class PatientsListHeader extends StatelessWidget {
  const PatientsListHeader({
    super.key,
    required this.patientCount,
    required this.searchController,
    required this.onAddTap,
    required this.onSearchChanged,
  });

  final int patientCount;
  final TextEditingController searchController;
  final VoidCallback onAddTap;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: GradientManager.primaryHeader,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32.r), bottomRight: Radius.circular(32.r)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative circles
          Positioned(top: -40.h, right: -20.w, child: _circle(140.w, 0.1)),
          Positioned(top: 80.h, left: -30.w, child: _circle(80.w, 0.08)),
          Positioned(bottom: 50.h, right: 60.w, child: _circle(50.w, 0.06)),
          // Content
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleRow(),
                  SizedBox(height: 20.h),
                  _buildSearchBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: ColorManager.white.withValues(alpha: opacity)),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patients', style: TextStyleManager.headlineMedium.copyWith(color: ColorManager.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 4.h),
            Text('$patientCount total patients', style: TextStyleManager.bodyMedium.copyWith(color: ColorManager.white.withValues(alpha: 0.9))),
          ],
        ),
        _buildAddButton(),
      ],
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: onAddTap,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Icon(Icons.add, color: ColorManager.primary, size: 24.w),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [BoxShadow(color: ColorManager.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search patients...',
          hintStyle: TextStyleManager.bodyMedium.copyWith(color: ColorManager.textTertiary),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 8.w),
            child: Icon(Icons.search, color: ColorManager.textTertiary, size: 22.w),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 46.w),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
