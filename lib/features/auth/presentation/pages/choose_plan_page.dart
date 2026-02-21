import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';

class ChoosePlanPage extends StatefulWidget {
  const ChoosePlanPage({super.key});

  @override
  State<ChoosePlanPage> createState() => _ChoosePlanPageState();
}

class _ChoosePlanPageState extends State<ChoosePlanPage> {
  String? _selectedPlanId;
  bool _isYearly = false;

  @override
  void initState() {
    super.initState();
    // Fetch plans from API only if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AuthBloc>().state;
      if (state.plans.isEmpty && !state.isLoadingPlans) {
        context.read<AuthBloc>().add(const AuthEvent.plansRequested());
      }
    });
  }

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
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state.isLoadingPlans) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.plans.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No plans available',
                          style: TextStyle(
                            color: ColorManager.textSecondary,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  const AuthEvent.plansRequested(),
                                );
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: PaddingManager.horizontalPadding,
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),

                      // Billing Toggle
                      _buildBillingToggle(),

                      SizedBox(height: 24.h),

                      // Plans List from API
                      ...state.plans.map((plan) => _buildPlanCard(plan)),

                      SizedBox(height: 100.h), // Space for bottom button
                    ],
                  ),
                );
              },
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
                    style: TextStyle(
                      color: !_isYearly
                          ? ColorManager.textPrimary
                          : ColorManager.textSecondary,
                      fontWeight: !_isYearly
                          ? FontWeight.w600
                          : FontWeight.normal,
                      fontFamily: FontFamily.geist,
                      fontSize: 14.sp,
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
                        style: TextStyle(
                          color: _isYearly
                              ? ColorManager.textPrimary
                              : ColorManager.textSecondary,
                          fontWeight: _isYearly
                              ? FontWeight.w600
                              : FontWeight.normal,
                          fontFamily: FontFamily.geist,
                          fontSize: 14.sp,
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
                          style: TextStyle(
                            color: ColorManager.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                            fontFamily: FontFamily.geist,
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

  // Helper method to get features for a plan
  List<String> _getPlanFeatures(PlanEntity plan) {
    // Map features based on plan name or type
    // This could also come from the backend in the future
    switch (plan.name.toLowerCase()) {
      case 'starter':
        return [
          'Unlimited patients',
          '1 doctor and 1 assistant',
          '2 GB storage',
          'All features included',
          '24/7 support',
        ];
      case 'growing':
        return [
          'Unlimited patients',
          'Up to 4 doctors',
          '4 GB storage',
          'All features included',
          'Priority support',
        ];
      case 'professional':
        return [
          'Unlimited patients',
          'Unlimited doctors & assistants',
          '10 GB storage per account',
          'Advanced analytics',
          'Priority support',
          'Admin role included',
        ];
      default:
        return [
          'All features included',
          'Full patient management',
          'Appointment scheduling',
          'Treatment tracking',
        ];
    }
  }

  Widget _buildPlanCard(PlanEntity plan) {
    final isSelected = _selectedPlanId == plan.id;
    // Mark "Growing" plan as popular
    final isPopular = plan.name.toLowerCase() == 'growing';

    // Get the price based on billing cycle (default to USD)
    final priceEntity = _isYearly
        ? plan.getYearlyPrice('USD')
        : plan.getMonthlyPrice('USD');
    final price = priceEntity.display;
    final period = _isYearly ? '/year' : '/month';
    final trialDays = plan.trialPeriodDays;
    final features = _getPlanFeatures(plan);

    return GestureDetector(
      onTap: () => setState(() => _selectedPlanId = plan.id),
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
                    colors: [ColorManager.primary, ColorManager.primaryDark],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    topRight: Radius.circular(14.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    '⭐ MOST POPULAR',
                    style: TextStyle(
                      color: ColorManager.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      fontFamily: FontFamily.geist,
                      fontSize: 12.sp,
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
                              plan.name,
                              style: TextStyle(
                                color: ColorManager.textPrimary,
                                fontWeight: FontWeight.w700,
                                fontFamily: FontFamily.geist,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              plan.description,
                              style: TextStyle(
                                color: ColorManager.textSecondary,
                                fontFamily: FontFamily.geist,
                                fontSize: 13.sp,
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
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontWeight: FontWeight.w800,
                          fontFamily: FontFamily.geist,
                          fontSize: 22.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Text(
                          period,
                          style: TextStyle(
                            color: ColorManager.textSecondary,
                            fontFamily: FontFamily.geist,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Trial badge
                  if (plan.supportsTrial) ...[
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
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.geist,
                          fontSize: 10.sp,
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
                              color: ColorManager.success.withValues(
                                alpha: 0.1,
                              ),
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
                              style: TextStyle(
                                color: ColorManager.textPrimary,
                                fontFamily: FontFamily.geist,
                                fontSize: 12.sp,
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
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
                      // Find the selected plan entity
                      final selectedPlan = state.plans.firstWhere(
                        (plan) => plan.id == _selectedPlanId,
                      );

                      // Store selected plan in BLoC state
                      final authBloc = context.read<AuthBloc>();
                      authBloc.add(
                        AuthEvent.signupPlanEntitySelected(selectedPlan),
                      );

                      // Navigate to Choose Clinic Name page
                      // Pass the AuthBloc instance to the next route
                      context.pushNamed(
                        AppRoutesNames.chooseClinicName,
                        extra: authBloc,
                      );
                    }
                  : null,
            ),
          ),
        );
      },
    );
  }
}
