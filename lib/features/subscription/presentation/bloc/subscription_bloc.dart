import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/user_subscription_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/use_cases/get_plans_use_case.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:injectable/injectable.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';
part 'subscription_bloc.freezed.dart';

@injectable
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final GetPlansUseCase _getPlans;
  final SubscriptionGuard _guard;

  SubscriptionBloc({
    required GetPlansUseCase getPlans,
    required SubscriptionGuard guard,
  })  : _getPlans = getPlans,
        _guard = guard,
        super(const SubscriptionState()) {
    on<_LoadSubscription>(_onLoadSubscription);
    on<_LoadPlans>(_onLoadPlans);
    on<_SelectPlan>(_onSelectPlan);
    on<_ChangeBillingCycle>(_onChangeBillingCycle);
    on<_StartTrial>(_onStartTrial);
    on<_Subscribe>(_onSubscribe);
    on<_CancelSubscription>(_onCancelSubscription);
    on<_ReactivateSubscription>(_onReactivateSubscription);
    on<_UpgradePlan>(_onUpgradePlan);
    on<_DowngradePlan>(_onDowngradePlan);
  }

  Future<void> _onLoadSubscription(
    _LoadSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock subscription - in trial
      final subscription = TrialConfig.createTrial(userId: event.userId);

      _guard.update(subscription);
      emit(state.copyWith(
        isLoading: false,
        currentSubscription: subscription,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadPlans(
    _LoadPlans event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(state.copyWith(isLoadingPlans: true, error: null));

    final result = await _getPlans(NoParams());

    result.fold(
      (error) => emit(state.copyWith(
        isLoadingPlans: false,
        error: NetworkExceptions.getErrorMessage(error),
      )),
      (plans) => emit(state.copyWith(
        isLoadingPlans: false,
        availablePlans: plans,
      )),
    );
  }

  void _onSelectPlan(
    _SelectPlan event,
    Emitter<SubscriptionState> emit,
  ) {
    emit(state.copyWith(selectedPlan: event.plan));
  }

  void _onChangeBillingCycle(
    _ChangeBillingCycle event,
    Emitter<SubscriptionState> emit,
  ) {
    emit(state.copyWith(selectedBillingCycle: event.cycle));
  }

  Future<void> _onStartTrial(
    _StartTrial event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(state.copyWith(isProcessing: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 800));

      final trial = TrialConfig.createTrial(userId: event.userId);

      _guard.update(trial);
      emit(state.copyWith(
        isProcessing: false,
        currentSubscription: trial,
        trialStarted: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isProcessing: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onSubscribe(
    _Subscribe event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (state.selectedPlan == null) {
      emit(state.copyWith(error: 'Please select a plan'));
      return;
    }

    emit(state.copyWith(isProcessing: true, error: null));

    try {
      // TODO: Replace with actual payment processing
      await Future.delayed(const Duration(milliseconds: 1000));

      final now = DateTime.now();
      final periodEnd = state.selectedBillingCycle == BillingCycle.yearly
          ? now.add(const Duration(days: 365))
          : now.add(const Duration(days: 30));

      final subscription = UserSubscriptionEntity(
        id: 'sub_${now.millisecondsSinceEpoch}',
        userId: event.userId,
        planTier: state.selectedPlan!.tier,
        status: SubscriptionStatus.active,
        billingCycle: state.selectedBillingCycle,
        startDate: now,
        currentPeriodEnd: periodEnd,
        autoRenew: true,
        lastPaymentDate: now,
        lastPaymentAmount: state.selectedPlan!.getPrice(state.selectedBillingCycle),
      );

      _guard.update(subscription);
      emit(state.copyWith(
        isProcessing: false,
        currentSubscription: subscription,
        subscribeSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isProcessing: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onCancelSubscription(
    _CancelSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (state.currentSubscription == null) return;

    emit(state.copyWith(isProcessing: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      final cancelled = state.currentSubscription!.copyWith(
        status: SubscriptionStatus.cancelled,
        cancelledAt: DateTime.now(),
        autoRenew: false,
      );

      _guard.update(cancelled);
      emit(state.copyWith(
        isProcessing: false,
        currentSubscription: cancelled,
        cancelSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isProcessing: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onReactivateSubscription(
    _ReactivateSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (state.currentSubscription == null) return;

    emit(state.copyWith(isProcessing: true, error: null));

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      final reactivated = state.currentSubscription!.copyWith(
        status: SubscriptionStatus.active,
        cancelledAt: null,
        autoRenew: true,
      );

      _guard.update(reactivated);
      emit(state.copyWith(
        isProcessing: false,
        currentSubscription: reactivated,
        reactivateSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isProcessing: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onUpgradePlan(
    _UpgradePlan event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(state.copyWith(isProcessing: true, error: null));

    try {
      // TODO: Replace with actual API call + proration calculation
      await Future.delayed(const Duration(milliseconds: 800));

      final upgraded = state.currentSubscription!.copyWith(
        planTier: event.newPlan.tier,
      );

      _guard.update(upgraded);
      emit(state.copyWith(
        isProcessing: false,
        currentSubscription: upgraded,
        upgradeSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isProcessing: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onDowngradePlan(
    _DowngradePlan event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(state.copyWith(isProcessing: true, error: null));

    try {
      // TODO: Replace with actual API call
      // Downgrade takes effect at end of current period
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.copyWith(
        isProcessing: false,
        pendingDowngrade: event.newPlan,
        downgradeSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isProcessing: false,
        error: e.toString(),
      ));
    }
  }
}
