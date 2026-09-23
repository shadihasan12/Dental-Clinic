import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/plan_features_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

class PlanPickerState {
  const PlanPickerState({
    this.isLoading = true,
    this.error,
    this.plans = const [],
    this.selectedPlanId,
    this.period = BillingPeriod.monthly,
    this.duration = 1,
    this.features = const {},
    this.featuresLoading = const {},
  });

  final bool isLoading;
  final NetworkExceptions? error;
  final List<PlanEntity> plans;
  final String? selectedPlanId;
  final BillingPeriod period;

  /// How many [period]s at once, 1-36.
  final int duration;

  /// What each plan includes, keyed by plan id, fetched when first opened.
  final Map<String, PlanFeaturesEntity> features;
  final Set<String> featuresLoading;

  PlanEntity? get selectedPlan {
    for (final p in plans) {
      if (p.id == selectedPlanId) return p;
    }
    return null;
  }

  QuoteParams? get quoteParams {
    final plan = selectedPlan;
    if (plan == null) return null;
    return QuoteParams(
      planVersionId: plan.versionId,
      billingPeriod: period,
      durationQuantity: duration,
    );
  }

  PlanPickerState copyWith({
    bool? isLoading,
    NetworkExceptions? error,
    List<PlanEntity>? plans,
    String? selectedPlanId,
    BillingPeriod? period,
    int? duration,
    Map<String, PlanFeaturesEntity>? features,
    Set<String>? featuresLoading,
  }) {
    return PlanPickerState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      plans: plans ?? this.plans,
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
      period: period ?? this.period,
      duration: duration ?? this.duration,
      features: features ?? this.features,
      featuresLoading: featuresLoading ?? this.featuresLoading,
    );
  }
}

/// The catalogue (MAIN plans only), the period and duration being priced,
/// and each plan's feature list as it is opened.
@injectable
class PlanPickerCubit extends Cubit<PlanPickerState> {
  PlanPickerCubit(this._repository) : super(const PlanPickerState());

  final BillingRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));
    final result = await _repository.getPlans();
    if (isClosed) return;
    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error)),
      (plans) => emit(state.copyWith(
        isLoading: false,
        plans: plans,
        // The first plan is preselected so the price is one tap away.
        selectedPlanId: state.selectedPlanId ??
            (plans.isEmpty ? null : plans.first.id),
      )),
    );
  }

  void selectPlan(String planId) => emit(state.copyWith(selectedPlanId: planId));

  void setPeriod(BillingPeriod period) => emit(state.copyWith(period: period));

  void setDuration(int duration) => emit(state.copyWith(
        duration: duration.clamp(1, QuoteParams.maxDuration),
      ));

  Future<void> loadFeatures(String planId) async {
    if (state.features.containsKey(planId) ||
        state.featuresLoading.contains(planId)) {
      return;
    }
    emit(state.copyWith(featuresLoading: {...state.featuresLoading, planId}));
    final result = await _repository.getPlanFeatures(planId);
    if (isClosed) return;
    final loading = {...state.featuresLoading}..remove(planId);
    result.fold(
      (_) => emit(state.copyWith(featuresLoading: loading)),
      (features) => emit(state.copyWith(
        featuresLoading: loading,
        features: {...state.features, planId: features},
      )),
    );
  }
}
