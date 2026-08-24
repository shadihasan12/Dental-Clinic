import 'package:dental_clinic_app/core/utils/system_insets.dart';
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
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.isLoadingPlans) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    _buildTopBar(l10n, fontFamily),
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state.plans.isEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: _buildTopBar(l10n, fontFamily),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                color: ColorManager.error
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Icon(
                                Icons.error_outline,
                                size: 22.w,
                                color: ColorManager.error,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              l10n.noPlansAvailable,
                              style: TextStyle(
                                color: ColorManager.of(context).textPrimary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
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
                  SizedBox(height: 16.h),
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
          // GestureDetector(
          //   onTap: () => context.goNamed(AppRoutesNames.login),
          //   child: Container(
          //     width: 40.w,
          //     height: 40.w,
          //     decoration: BoxDecoration(
          //       color: ColorManager.of(context).cardBgSecondary,
          //       borderRadius: BorderRadius.circular(12.r),
          //     ),
          //     child: Icon(
          //       Icons.arrow_back_ios_new,
          //       color: ColorManager.of(context).textPrimary,
          //       size: 18.w,
          //     ),
          //   ),
          // ),
          // SizedBox(height: 24.h),
          Text(
            l10n.chooseYourPlan,
            style: TextStyle(
              fontSize: FontSizesManager.s28,
              fontWeight: FontWeightManager.bold,
              fontFamily: fontFamily,
              color: ColorManager.of(context).textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.selectPlanSubtitle,
            style: TextStyle(
              fontSize: FontSizesManager.s14,
              fontFamily: fontFamily,
              color: ColorManager.of(context).textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  /// Two segments in one track, the same segmented control the gender picker
  /// and the treatments filter use: a shared track says the choice is
  /// exclusive, and the active half is a primary fill rather than a shadow.
  Widget _buildBillingToggle(AppLocalizations l10n, String fontFamily) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        children: [
          Expanded(
            child: _billingSegment(
              label: l10n.monthly,
              active: !_isYearly,
              fontFamily: fontFamily,
              onTap: () => setState(() => _isYearly = false),
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: _billingSegment(
              label: l10n.yearly,
              active: _isYearly,
              fontFamily: fontFamily,
              onTap: () => setState(() => _isYearly = true),
              badge: l10n.savePercent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _billingSegment({
    required String label,
    required bool active,
    required String fontFamily,
    required VoidCallback onTap,
    String? badge,
  }) {
    final c = ColorManager.of(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: EdgeInsets.symmetric(vertical: 9.h),
        decoration: BoxDecoration(
          color: active ? ColorManager.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: active ? ColorManager.white : c.textSecondary,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                  fontFamily: fontFamily,
                  fontSize: 12.sp,
                ),
              ),
            ),
            if (badge != null) ...[
              SizedBox(width: 5.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                decoration: BoxDecoration(
                  // Green on a primary fill would fight it, so the badge
                  // borrows the segment's own foreground once selected.
                  color: active
                      ? ColorManager.white.withValues(alpha: 0.22)
                      : ColorManager.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: active ? ColorManager.white : ColorManager.success,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    height: 1.4,
                    fontFamily: fontFamily,
                  ),
                ),
              ),
            ],
          ],
        ),
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

  Widget _buildPlanCard(
    PlanEntity plan,
    AppLocalizations l10n,
    String fontFamily,
  ) {
    final c = ColorManager.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? ColorManager.primary : ColorManager.primaryDarker;
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
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        clipBehavior: Clip.antiAlias,
        // Selection is a 1.5px border in the primary hue - elevation in this
        // design language is a border, never a shadow.
        decoration: BoxDecoration(
          color: c.cardBg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? ColorManager.primary : c.borderLight,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isPopular)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 6.h),
                color: ColorManager.primary,
                child: Center(
                  child: Text(
                    l10n.mostPopular.toUpperCase(),
                    style: TextStyle(
                      color: ColorManager.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                      fontFamily: fontFamily,
                      fontSize: 9.5.sp,
                    ),
                  ),
                ),
              ),

            Padding(
              padding: EdgeInsets.all(14.w),
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
                                color: c.textPrimary,
                                fontWeight: FontWeight.w600,
                                fontFamily: fontFamily,
                                fontSize: 12.5.sp,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              plan.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: c.textSecondary,
                                fontFamily: fontFamily,
                                fontSize: 11.5.sp,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? ColorManager.primary
                                : c.border,
                            width: 1.5,
                          ),
                          color: isSelected
                              ? ColorManager.primary
                              : Colors.transparent,
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check_rounded,
                                size: 13.w,
                                color: ColorManager.white,
                              )
                            : null,
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$$price',
                        style: TextStyle(
                          color: accent,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                          height: 1.1,
                          fontFamily: fontFamily,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        period,
                        style: TextStyle(
                          color: c.textSecondary,
                          fontFamily: fontFamily,
                          fontSize: 11.5.sp,
                        ),
                      ),
                    ],
                  ),

                  if (plan.supportsTrial) ...[
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        l10n.dayFreeTrial(trialDays),
                        style: TextStyle(
                          color: accent,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily,
                          fontSize: 10.sp,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],

                  SizedBox(height: 12.h),
                  Divider(color: c.borderLight, height: 1),
                  SizedBox(height: 12.h),

                  for (final feature in features)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_rounded,
                            size: 14.w,
                            color: ColorManager.success,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(
                                color: c.textSecondary,
                                fontFamily: fontFamily,
                                fontSize: 11.5.sp,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
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
          // Elevation in this design language is a border, not a shadow.
          decoration: BoxDecoration(
            color: ColorManager.of(context).surfaceBg,
            border: Border(
              top: BorderSide(color: ColorManager.of(context).borderLight),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: scaffoldBottomInset(context),
            ),
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
                        AppRoutesNames.register,
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
