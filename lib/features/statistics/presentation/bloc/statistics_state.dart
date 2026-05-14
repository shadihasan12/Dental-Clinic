part of 'statistics_bloc.dart';

enum StatisticsStatus { initial, loading, success, failure }

class StatisticsState extends Equatable {
  const StatisticsState({
    this.status = StatisticsStatus.initial,
    this.period = StatisticsPeriod.month,
    this.clinicId,
    this.snapshot,
    this.error,
  });

  final StatisticsStatus status;
  final StatisticsPeriod period;
  final String? clinicId;
  final StatisticsSnapshot? snapshot;
  final String? error;

  bool get isLoading => status == StatisticsStatus.loading;
  bool get hasData => snapshot != null;

  StatisticsState copyWith({
    StatisticsStatus? status,
    StatisticsPeriod? period,
    String? clinicId,
    StatisticsSnapshot? snapshot,
    String? error,
    bool clearError = false,
  }) {
    return StatisticsState(
      status: status ?? this.status,
      period: period ?? this.period,
      clinicId: clinicId ?? this.clinicId,
      snapshot: snapshot ?? this.snapshot,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [status, period, clinicId, snapshot, error];
}
