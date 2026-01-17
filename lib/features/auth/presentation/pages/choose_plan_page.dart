import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

// TODO: Import your actual Plan model
// import 'package:dental_clinic_app/features/plans/data/models/plan_model.dart';

class ChoosePlanPage extends StatefulWidget {
  const ChoosePlanPage({super.key});

  @override
  State<ChoosePlanPage> createState() => _ChoosePlanPageState();
}

class _ChoosePlanPageState extends State<ChoosePlanPage> {
  int? _selectedPlanId;
  bool _isYearly = false;

  // TODO: Replace with actual data from API/BLoC
  final List<Map<String, dynamic>> _plans = [
    {
      "id": 1,
      "name": "Starter",
      "description":
          "Designed for new and growing clinics, the Starter Plan provides all the essential tools to digitize your practice.",
      "price_monthly": "7.50",
      "price_yearly": "75.00",
      "max_users": 1,
      "max_patients": 500,
      "max_storage_mb": 512,
      "supports_trial": 1,
      "trial_period_days": 7,
      "is_active": true,
      "features": [
        "Up to 500 patients",
        "12 team members",
        "512 MB storage",
        "Appointment system",
        "Digital records",
      ],
    },
    {
      "id": 2,
      "name": "Professional",
      "description":
          "Built for established clinics and growing teams ready to scale with unlimited capacity.",
      "price_monthly": "15.90",
      "price_yearly": "159.00",
      "max_users": 4,
      "max_patients": 10000,
      "max_storage_mb": 10240,
      "supports_trial": 1,
      "trial_period_days": 14,
      "is_active": true,
      "is_popular": true,
      "features": [
        "Unlimited patients",
        "Unlimited users",
        "10 GB storage",
        "Advanced analytics",
        "API access",
        "Priority support",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        children: [
          // Gradient Header
          GradientHeader(
            title: 'Choose Your Plan',
            subtitle: 'Select the perfect plan for your clinic',
            height: 200.h,
            showBackButton: true,
            onBackPressed: () => context.pop(),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: PaddingManager.horizontalPadding,
              child: Column(
                children: [
                  SizedBox(height: 24.h),

                  // Billing Toggle
                  _buildBillingToggle(),

                  SizedBox(height: 24.h),

                  // Plans List
                  ..._plans.map((plan) => _buildPlanCard(plan)),

                  SizedBox(height: 100.h), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildBillingToggle() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ColorManager.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isYearly = false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: !_isYearly ? ColorManager.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: !_isYearly
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    'Monthly',
                    style: TextStyleManager.bodyMedium.copyWith(
                      color: !_isYearly
                          ? ColorManager.textPrimary
                          : ColorManager.textSecondary,
                      fontWeight:
                          !_isYearly ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isYearly = true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: _isYearly ? ColorManager.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: _isYearly
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Yearly',
                        style: TextStyleManager.bodyMedium.copyWith(
                          color: _isYearly
                              ? ColorManager.textPrimary
                              : ColorManager.textSecondary,
                          fontWeight:
                              _isYearly ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.success,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Save 17%',
                          style: TextStyleManager.labelSmall.copyWith(
                            color: ColorManager.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    final isSelected = _selectedPlanId == plan['id'];
    final isPopular = plan['is_popular'] == true;
    final price = _isYearly ? plan['price_yearly'] : plan['price_monthly'];
    final period = _isYearly ? '/year' : '/month';
    final trialDays = plan['trial_period_days'];
    final features = plan['features'] as List<String>;

    return GestureDetector(
      onTap: () => setState(() => _selectedPlanId = plan['id']),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? ColorManager.primary : ColorManager.gray300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? ColorManager.primary.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: isSelected ? 12 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with popular badge
            if (isPopular)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorManager.primary,
                      ColorManager.primaryDark,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    topRight: Radius.circular(14.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    '⭐ MOST POPULAR',
                    style: TextStyleManager.labelSmall.copyWith(
                      color: ColorManager.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),

            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plan name and radio
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan['name'],
                              style: TextStyleManager.headlineSmall.copyWith(
                                color: ColorManager.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              plan['description'],
                              style: TextStyleManager.bodySmall.copyWith(
                                color: ColorManager.textSecondary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? ColorManager.primary
                                : ColorManager.gray300,
                            width: 2,
                          ),
                          color: isSelected
                              ? ColorManager.primary
                              : Colors.transparent,
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                size: 14.w,
                                color: ColorManager.white,
                              )
                            : null,
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$$price',
                        style: TextStyleManager.headlineLarge.copyWith(
                          color: ColorManager.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Text(
                          period,
                          style: TextStyleManager.bodyMedium.copyWith(
                            color: ColorManager.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Trial badge
                  if (plan['supports_trial'] == 1) ...[
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.primary10,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '$trialDays-day free trial',
                        style: TextStyleManager.labelSmall.copyWith(
                          color: ColorManager.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],

                  SizedBox(height: 16.h),

                  // Divider
                  Divider(color: ColorManager.gray300, height: 1),

                  SizedBox(height: 16.h),

                  // Features
                  ...features.map(
                    (feature) => Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              color: ColorManager.success.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              size: 12.w,
                              color: ColorManager.success,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyleManager.bodySmall.copyWith(
                                color: ColorManager.textPrimary,
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildBottomButton() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: PrimaryButton(
          text: 'Next',
          isEnabled: _selectedPlanId != null,
          onPressed: _selectedPlanId != null
              ? () {
                  // Navigate to Choose Clinic Name page
                  // Pass the selected plan
                  context.pushNamed(
                    AppRoutesNames.chooseClinicName,
                    extra: {
                      'planId': _selectedPlanId,
                      'isYearly': _isYearly,
                    },
                  );
                }
              : null,
        ),
      ),
    );
  }
}