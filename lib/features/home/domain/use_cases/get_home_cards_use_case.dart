import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

import '../entities/home_card.dart';
import '../repositories/home_cards_repository.dart';

/// The Home carousel's cards. One request, no parameters.
///
/// There is nothing for this use case to decide: the period is the current
/// month by contract, the scope comes from the caller's role in the selected
/// clinic, and the cards arrive already worded and ordered. It exists so the
/// page depends on the domain rather than reaching for a repository.
@injectable
class GetHomeCardsUseCase implements UseCase<List<HomeCard>, NoParams> {
  GetHomeCardsUseCase(this._repository);

  final HomeCardsRepository _repository;

  @override
  Future<Either<NetworkExceptions, List<HomeCard>>> call(NoParams params) =>
      _repository.getHomeCards();
}
