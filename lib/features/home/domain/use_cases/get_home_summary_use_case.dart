import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';
import 'package:dental_clinic_app/features/statistics/domain/use_cases/get_revenue_summary_use_case.dart';
import 'package:injectable/injectable.dart';

import '../entities/home_summary.dart';
import '../repositories/home_summary_repository.dart';

/// The three figures on Home: patient count, revenue in USD, revenue in SYP.
///
/// One request, month to date. The window is the app's, not the server's, so
/// that "this month" means the same thing here as it does on the label under
/// the number.
///
/// A 404 falls back to the statistics catalog. That is not defensive
/// programming for its own sake: `/clinics/home-summary` is a new route, and
/// until every environment has it a build that lost its revenue card entirely
/// would be a worse regression than one extra round trip on the clinics that
/// have not been migrated yet. The fallback yields a single revenue card, so
/// the carousel degrades to what Home showed before rather than to nothing.
@injectable
class GetHomeSummaryUseCase implements UseCase<HomeSummary, NoParams> {
  GetHomeSummaryUseCase(this._repository, this._revenueFallback);

  final HomeSummaryRepository _repository;
  final GetRevenueSummaryUseCase _revenueFallback;

  @override
  Future<Either<NetworkExceptions, HomeSummary>> call(NoParams params) async {
    final now = DateTime.now();
    final result = await _repository.getHomeSummary(
      startDate: AppDate.apiDate(DateTime(now.year, now.month, 1)),
      endDate: AppDate.apiDate(now),
    );

    final failure = result.fold((l) => l, (_) => null);
    if (failure == null) return result;

    // Only a missing route falls back. A timeout or a 500 is a real failure
    // of a route that does exist, and retrying it through a slower path would
    // just make Home hang twice as long before showing the same nothing.
    final isMissingRoute = failure.maybeWhen(
      notFound: (_) => true,
      notImplemented: () => true,
      orElse: () => false,
    );
    if (!isMissingRoute) return result;

    final legacy = await _revenueFallback(NoParams());
    return legacy.fold(
      // The fallback failed too - report the original failure, which is the
      // one that describes the route Home is actually meant to be using.
      (_) => Left(failure),
      (summary) => Right(
        summary == null
            ? const HomeSummary.empty()
            : HomeSummary(
                stats: [
                  HomeStat(
                    kind: HomeStatKind.revenue,
                    value: summary.value,
                    currencyCode: summary.currencyCode,
                    changePercent: summary.changePercent,
                    recentDaily: summary.recentDaily,
                  ),
                ],
              ),
      ),
    );
  }
}
