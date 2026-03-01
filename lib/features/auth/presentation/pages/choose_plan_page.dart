import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AuthBloc>().state;
      if (state.plans.isEmpty && !state.isLoadingPlans) {
        context.read<AuthBloc>().add(const AuthEvent.plansRequested());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.isLoadingPlans) {
              return Column(
                children: [
                  _buildTopBar(l10n, fontFamily),
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            }

            if (state.plans.isEmpty) {
              return Column(
                children: [
                  _buildTopBar(l10n, fontFamily),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64.w,
                              color: ColorManager.error,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              l10n.noPlansAvailable,
                              style: TextStyle(
                                color: ColorManager.textPrimary,
                                fontSize: FontSizesManager.s18,
                                fontWeight: FontWeightManager.semiBold,
                                fontFamily: fontFamily,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 32.h),
                            PrimaryButton(
                              text: l10n.retry,
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                      const AuthEvent.plansRequested(),
                                    );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(l10n, fontFamily),
                  SizedBox(height: 8.h),
                  _buildBillingToggle(l10n, fontFamily),
                  SizedBox(height: 24.h),
                  ...state.plans.map((plan) => _buildPlanCard(plan, l10n, fontFamily)),
                  SizedBox(height: 100.h),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBottomButton(l10n),
    );
  }

  Widget _buildTopBar(AppLocalizations l10n, String fontFamily) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: ColorManager.gray100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ColorManager.textPrimary,
                size: 18.w,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            l10n.chooseYourPlan,
            style: TextStyle(
              fontSize: FontSizesManager.s28,
              fontWeight: FontWeightManager.bold,
              fontFamily: fontFamily,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.selectPlanSubtitle,
            style: TextStyle(
              fontSize: FontSizesManager.s14,
              fontFamily: fontFamily,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingToggle(AppLocalizations l10n, String fontFamily) {
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
                    l10n.monthly,
                    style: TextStyle(
                      color: !_isYearly
                          ? ColorManager.textPrimary
                          : ColorManager.textSecondary,
                      fontWeight: !_isYearly
                          ? FontWeightManager.semiBold
                          : FontWeightManager.regular,
                      fontFamily: fontFamily,
                      fontSize: FontSizesManager.s14,
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
                        l10n.yearly,
                        style: TextStyle(
                          color: _isYearly
                              ? ColorManager.textPrimary
                              : ColorManager.textSecondary,
                          fontWeight: _isYearly
                              ? FontWeightManager.semiBold
                              : FontWeightManager.regular,
                          fontFamily: fontFamily,
                          fontSize: FontSizesManager.s14,
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
                          l10n.savePercent,
                          style: TextStyle(
                            color: ColorManager.white,
                            fontWeight: FontWeightManager.semiBold,
                            fontSize: FontSizesManager.s10,
                            fontFamily: fontFamily,
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

  List<String> _getPlanFeatures(PlanEntity plan, AppLocalizations l10n) {
    switch (plan.name.toLowerCase()) {
      case 'starter':
        return [
          l10n.unlimitedPatients,
          l10n.oneDoctorOneAssistant,
          l10n.storageAmount('2'),
          l10n.allFeaturesIncluded,
          l10n.support247,
        ];
      case 'growing':
        return [
          l10n.unlimitedPatients,
          l10n.upToDoctors(4),
          l10n.storageAmount('4'),
          l10n.allFeaturesIncluded,
          l10n.prioritySupport,
        ];
      case 'professional':
        return [
          l10n.unlimitedPatients,
          l10n.unlimitedDoctorsAssistants,
          l10n.storagePerAccount('10'),
          l10n.advancedAnalytics,
          l10n.prioritySupport,
          l10n.adminRoleIncluded,
        ];
      default:
        return [
          l10n.allFeaturesIncluded,
          l10n.fullPatientManagement,
          l10n.appointmentScheduling,
          l10n.treatmentTracking,
        ];
    }
  }

  Widget _buildPlanCard(PlanEntity plan, AppLocalizations l10n, String fontFamily) {
    final isSelected = _selectedPlanId == plan.id;
    final isPopular = plan.name.toLowerCase() == 'growing';

    final priceEntity = _isYearly
        ? plan.getYearlyPrice('USD')
        : plan.getMonthlyPrice('USD');
    final price = priceEntity.display;
    final period = _isYearly ? l10n.perYear : l10n.perMonth;
    final trialDays = plan.trialPeriodDays;
    final features = _getPlanFeatures(plan, l10n);

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
                    l10n.mostPopular,
                    style: TextStyle(
                      color: ColorManager.white,
                      fontWeight: FontWeightManager.bold,
                      letterSpacing: 1,
                      fontFamily: fontFamily,
                      fontSize: FontSizesManager.s12,
                    ),
                  ),
                ),
              ),

            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                fontWeight: FontWeightManager.bold,
                                fontFamily: fontFamily,
                                fontSize: FontSizesManager.s18,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              plan.description,
                              style: TextStyle(
                                color: ColorManager.textSecondary,
                                fontFamily: fontFamily,
                                fontSize: FontSizesManager.s13,
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

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$$price',
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontWeight: FontWeightManager.extraBold,
                          fontFamily: fontFamily,
                          fontSize: FontSizesManager.s22,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Text(
                          period,
                          style: TextStyle(
                            color: ColorManager.textSecondary,
                            fontFamily: fontFamily,
                            fontSize: FontSizesManager.s14,
                          ),
                        ),
                      ),
                    ],
                  ),

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
                        l10n.dayFreeTrial(trialDays),
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontWeight: FontWeightManager.regular,
                          fontFamily: fontFamily,
                          fontSize: FontSizesManager.s10,
                        ),
                      ),
                    ),
                  ],

                  SizedBox(height: 16.h),
                  Divider(color: ColorManager.gray300, height: 1),
                  SizedBox(height: 16.h),

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
                              style: TextStyle(
                                color: ColorManager.textPrimary,
                                fontFamily: fontFamily,
                                fontSize: FontSizesManager.s12,
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

  Widget _buildBottomButton(AppLocalizations l10n) {
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
              text: l10n.next,
              isEnabled: _selectedPlanId != null,
              onPressed: _selectedPlanId != null
                  ? () {
                      final selectedPlan = state.plans.firstWhere(
                        (plan) => plan.id == _selectedPlanId,
                      );

                      final authBloc = context.read<AuthBloc>();
                      authBloc.add(
                        AuthEvent.signupPlanEntitySelected(selectedPlan),
                      );

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
