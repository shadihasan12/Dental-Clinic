import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/home_card.dart';
import '../endpoints/home_cards_endpoints.dart';
import '../models/home_card_model.dart';

abstract class HomeCardsRemoteDataSource {
  Future<List<HomeCard>> getHomeCards();
}

@Injectable(as: HomeCardsRemoteDataSource)
class HomeCardsRemoteDataSourceImpl implements HomeCardsRemoteDataSource {
  HomeCardsRemoteDataSourceImpl(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<List<HomeCard>> getHomeCards() async {
    final response = await _apiConsumer.get(HomeCardsEndpoints.homeCards);
    final data = response['data'];
    if (data is! Map<String, dynamic>) return const [];
    return HomeCardModel.listFrom(data['cards']);
  }
}
