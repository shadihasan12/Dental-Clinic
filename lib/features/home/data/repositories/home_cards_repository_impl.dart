import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/home_card.dart';
import '../../domain/repositories/home_cards_repository.dart';
import '../data_sources/home_cards_remote_data_source.dart';

@Injectable(as: HomeCardsRepository)
class HomeCardsRepositoryImpl implements HomeCardsRepository {
  HomeCardsRepositoryImpl(this._remoteDataSource);

  final HomeCardsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<NetworkExceptions, List<HomeCard>>> getHomeCards() async {
    try {
      return Right(await _remoteDataSource.getHomeCards());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
