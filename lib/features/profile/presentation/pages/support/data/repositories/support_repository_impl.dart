import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/data/data_sources/support_remote_data_source.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/entities/support_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/repositories/support_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SupportRepository)
class SupportRepositoryImpl implements SupportRepository {
  final SupportRemoteDataSource _dataSource;

  SupportRepositoryImpl(this._dataSource);

  @override
  Future<Either<NetworkExceptions, List<SupportConversationEntity>>>
      getConversations() async {
    try {
      final models = await _dataSource.getConversations();
      final entities = models.map((m) => m.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, SupportConversationEntity>>
      createConversation() async {
    try {
      final model = await _dataSource.createConversation();
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, SupportConversationEntity>> sendMessage(
    String conversationId,
    String text,
  ) async {
    try {
      final model = await _dataSource.sendMessage(conversationId, text);
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, SupportConversationEntity>> getAutoReply(
    String conversationId,
  ) async {
    try {
      final model = await _dataSource.getAutoReply(conversationId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(NetworkExceptions.getException(e));
    }
  }
}
