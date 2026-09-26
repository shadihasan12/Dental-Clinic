import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/addon_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/billing_line_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/plan_features_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// What the plan picker is buying.
enum BillingPlanMode {
  /// A new subscription: trial, awaiting a first payment, cancelled, or
  /// expired straight after a trial.
  subscribe,

  /// The next whole cycle - ACTIVE, GRACE, or expired after a paid cycle.
  /// Any plan, smaller ones included, with the add-on units to carry on.
  renew,

  /// A bigger plan now, for the rest of the cycle. Only while ACTIVE.
  upgrade,
}

/// What the picker opens with. A renewal opens "as it stands": the current
/// plan, period and quantity selected.
class BillingPlanArgs {
  const BillingPlanArgs({
    this.mode = BillingPlanMode.subscribe,
    this.currentPlanId,
    this.period,
    this.duration,
  });

  final BillingPlanMode mode;

  /// The plan being served: preselected on a renewal, and the floor an
  /// upgrade has to be above.
  final String? currentPlanId;
  final BillingPeriod? period;
  final int? duration;
}

class PlanPickerState {
  const PlanPickerState({
    this.mode = BillingPlanMode.subscribe,
    this.isLoading = true,
    this.error,
    this.plans = const [],
    this.selectedPlanId,
    this.period = BillingPeriod.monthly,
    this.duration = 1,
    this.features = const {},
    this.featuresLoading = const {},
    this.addons = const [],
    this.addonUnits = const {},
    this.addonsTouched = false,
  });

  final BillingPlanMode mode;
  final bool isLoading;
  final NetworkExceptions? error;

  /// The plans on offer in this mode - for an upgrade, only those above the
  /// current one.
  final List<PlanEntity> plans;
  final String? selectedPlanId;
  final BillingPeriod period;

  /// How many [period]s at once, 1-36.
  final int duration;

  /// What each plan includes, keyed by plan id, fetched when first opened.
  final Map<String, PlanFeaturesEntity> features;
  final Set<String> featuresLoading;

  /// Renewal only: the add-ons on sale, and the units to renew with, by
  /// version id - starting at what the clinic holds.
  final List<AddonEntity> addons;
  final Map<String, int> addonUnits;

  /// Until the owner touches a stepper the renewal carries on as it stands,
  /// so `addons` is left out of the quote.
  final bool addonsTouched;

  bool get isUpgrade => mode == BillingPlanMode.upgrade;

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
      // Once touched, every add-on is sent with its stepper value, 0
      // included: the list is the whole of the new cycle's units.
      addons: addonsTouched
          ? [
              for (final a in addons)
                AddonSelection(
                  planVersionId: a.versionId,
                  quantity: addonUnits[a.versionId] ?? 0,
                ),
            ]
          : null,
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
    List<AddonEntity>? addons,
    Map<String, int>? addonUnits,
    bool? addonsTouched,
  }) {
    return PlanPickerState(
      mode: mode,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      plans: plans ?? this.plans,
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
      period: period ?? this.period,
      duration: duration ?? this.duration,
      features: features ?? this.features,
      featuresLoading: featuresLoading ?? this.featuresLoading,
      addons: addons ?? this.addons,
      addonUnits: addonUnits ?? this.addonUnits,
      addonsTouched: addonsTouched ?? this.addonsTouched,
    );
  }
}

/// The catalogue (MAIN plans only), the period and duration being priced,
/// each plan's feature list as it is opened, and - on a renewal - the add-on
/// units to renew with.
@injectable
class PlanPickerCubit extends Cubit<PlanPickerState> {
  PlanPickerCubit(this._repository) : super(const PlanPickerState());

  final BillingRepository _repository;
  BillingPlanArgs _args = const BillingPlanArgs();

  /// Opens the picker in [args]' mode, preselected as [args] says.
  void start(BillingPlanArgs args) {
    _args = args;
    emit(PlanPickerState(
      mode: args.mode,
      period: args.period ?? BillingPeriod.monthly,
      duration: (args.duration ?? 1).clamp(1, QuoteParams.maxDuration),
    ));
    load();
  }

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));
    final plansF = _repository.getPlans();
    final addonsF = state.mode == BillingPlanMode.renew
        ? _repository.getAddons()
        : null;
    final result = await plansF;
    // Add-ons are optional here: the renewal carries on as it stands without
    // them, so a failed read just hides the steppers.
    final addons = addonsF == null
        ? const <AddonEntity>[]
        : (await addonsF).getOrElse(() => const []);
    if (isClosed) return;

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error)),
      (all) {
        final plans = _plansFor(all);
        emit(state.copyWith(
          isLoading: false,
          plans: plans,
          selectedPlanId: state.selectedPlanId ?? _preselect(plans),
          addons: addons,
          addonUnits: state.addonsTouched
              ? state.addonUnits
              : {for (final a in addons) a.versionId: a.ownedUnits},
        ));
      },
    );
  }

  /// In catalogue order; an upgrade offers only the plans above the current
  /// one - a smaller plan is bought as a renewal.
  List<PlanEntity> _plansFor(List<PlanEntity> all) {
    final sorted = [...all]..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    if (state.mode != BillingPlanMode.upgrade) return sorted;
    final current =
        sorted.where((p) => p.id == _args.currentPlanId).firstOrNull;
    if (current == null) return const [];
    return sorted.where((p) => p.sortOrder > current.sortOrder).toList();
  }

  /// The current plan on a renewal; otherwise the first, so the price is one
  /// tap away.
  String? _preselect(List<PlanEntity> plans) {
    if (plans.isEmpty) return null;
    final current = _args.currentPlanId;
    if (state.mode == BillingPlanMode.renew &&
        plans.any((p) => p.id == current)) {
      return current;
    }
    return plans.first.id;
  }

  void selectPlan(String planId) => emit(state.copyWith(selectedPlanId: planId));

  void setPeriod(BillingPeriod period) => emit(state.copyWith(period: period));

  void setDuration(int duration) => emit(state.copyWith(
        duration: duration.clamp(1, QuoteParams.maxDuration),
      ));

  void setAddonUnits(String versionId, int units) => emit(state.copyWith(
        addonUnits: {...state.addonUnits, versionId: units.clamp(0, 1000)},
        addonsTouched: true,
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
