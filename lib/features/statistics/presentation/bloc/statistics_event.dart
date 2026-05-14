part of 'statistics_bloc.dart';

abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();

  @override
  List<Object?> get props => [];
}

/// Fired when the page mounts.
class StatisticsRequested extends StatisticsEvent {
  const StatisticsRequested({required this.clinicId});
  final String clinicId;

  @override
  List<Object?> get props => [clinicId];
}

/// Fired when the user taps one of the period chips. The current
/// [clinicId] is kept on state, so we only need the new period.
class StatisticsPeriodChanged extends StatisticsEvent {
  const StatisticsPeriodChanged(this.period);
  final StatisticsPeriod period;

  @override
  List<Object?> get props => [period];
}

/// Fired by pull-to-refresh.
class StatisticsRefreshed extends StatisticsEvent {
  const StatisticsRefreshed();
}
