import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/statistics_entities.dart';
import '../../domain/entities/statistics_period.dart';
import '../../domain/use_cases/get_statistics_use_case.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc({required GetStatisticsUseCase getStatistics})
      : _getStatistics = getStatistics,
        super(const StatisticsState()) {
    on<StatisticsRequested>(_onRequested);
    on<StatisticsPeriodChanged>(_onPeriodChanged);
    on<StatisticsRefreshed>(_onRefreshed);
  }

  final GetStatisticsUseCase _getStatistics;

  Future<void> _onRequested(
    StatisticsRequested event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(state.copyWith(
      clinicId: event.clinicId,
      status: StatisticsStatus.loading,
      clearError: true,
    ));
    await _fetch(emit, clinicId: event.clinicId, period: state.period);
  }

  Future<void> _onPeriodChanged(
    StatisticsPeriodChanged event,
    Emitter<StatisticsState> emit,
  ) async {
    if (event.period == state.period && state.hasData) return;
    final clinicId = state.clinicId;
    if (clinicId == null) {
      emit(state.copyWith(period: event.period));
      return;
    }
    emit(state.copyWith(
      period: event.period,
      status: StatisticsStatus.loading,
      clearError: true,
    ));
    await _fetch(emit, clinicId: clinicId, period: event.period);
  }

  Future<void> _onRefreshed(
    StatisticsRefreshed event,
    Emitter<StatisticsState> emit,
  ) async {
    final clinicId = state.clinicId;
    if (clinicId == null) return;
    emit(state.copyWith(status: StatisticsStatus.loading, clearError: true));
    await _fetch(emit, clinicId: clinicId, period: state.period);
  }

  Future<void> _fetch(
    Emitter<StatisticsState> emit, {
    required String clinicId,
    required StatisticsPeriod period,
  }) async {
    final result = await _getStatistics(
      GetStatisticsParams(clinicId: clinicId, period: period),
    );
    result.fold(
      (err) => emit(state.copyWith(
        status: StatisticsStatus.failure,
        error: NetworkExceptions.getErrorMessage(err),
      )),
      (snapshot) => emit(state.copyWith(
        status: StatisticsStatus.success,
        snapshot: snapshot,
      )),
    );
  }
}
