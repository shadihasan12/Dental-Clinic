import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';

import '../entities/home_card.dart';

abstract class HomeCardsRepository {
  /// The Home carousel's cards for the selected clinic, current month.
  ///
  /// An empty list is a success, not a failure: that is what a secretary
  /// gets, and it means "hide the carousel".
  Future<Either<NetworkExceptions, List<HomeCard>>> getHomeCards();
}
