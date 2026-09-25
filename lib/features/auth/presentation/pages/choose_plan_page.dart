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
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/auth_desktop_shell.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/plan_features_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/plan_option_card.dart';
import 'package:dental_clinic_app/injection.dart';

/// Signup's plan chooser. Every plan, price and feature on it comes from
/// the API - `GET /plans` (MAIN only) and `GET /plans/{id}/features`, both
/// public - drawn with the same [PlanOptionCard] the in-app picker uses, so
/// a plan reads the same before and after registering.
class ChoosePlanPage extends StatefulWidget {
  const ChoosePlanPage({super.key});

  @override
  State<ChoosePlanPage> createState() => _ChoosePlanPageState();
}

class _ChoosePlanPageState extends State<ChoosePlanPage> {
  String? _selectedPlanId;

  /// What each plan includes, keyed by plan id, fetched when first opened.
  final Map<String, PlanFeaturesEntity> _features = {};
  final Set<String> _featuresLoading = {};

  Future<void> _loadFeatures(String planId) async {
    if (_features.containsKey(planId) || _featuresLoading.contains(planId)) {
      return;
    }
    setState(() => _featuresLoading.add(planId));
    final result = await getIt<BillingRepository>().getPlanFeatures(planId);
    if (!mounted) return;
    setState(() {
      _featuresLoading.remove(planId);
      result.fold((_) {}, (features) => _features[planId] = features);
    });
  }

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

    return AuthDesktopShell(imageIndex: 0, child: Scaffold(
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
                  SizedBox(height: 16.h),
                  for (final plan in state.plans)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: PlanOptionCard(
                        plan: plan,
                        selected: plan.id == _selectedPlanId,
                        showTrial: true,
                        features: _features[plan.id],
                        featuresLoading: _featuresLoading.contains(plan.id),
                        onTap: () => setState(() => _selectedPlanId = plan.id),
                        onShowFeatures: () => _loadFeatures(plan.id),
                      ),
                    ),
                  if (Responsive.isDesktop(context)) ...[
                    SizedBox(height: 24.h),
                    _buildInlineButton(l10n),
                    SizedBox(height: 24.h),
                  ] else
                    SizedBox(height: 100.h),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Responsive.isDesktop(context) ? null : _buildBottomButton(l10n),
    ),);
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


  Widget _buildInlineButton(AppLocalizations l10n) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return PrimaryButton(
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
        );
      },
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
