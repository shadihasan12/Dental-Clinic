import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/domain/entities/support_entity.dart';

abstract class SupportRepository {
  Future<Either<NetworkExceptions, List<SupportConversationEntity>>>
      getConversations();

  Future<Either<NetworkExceptions, SupportConversationEntity>>
      createConversation();

  Future<Either<NetworkExceptions, SupportConversationEntity>> sendMessage(
    String conversationId,
    String text,
  );

  Future<Either<NetworkExceptions, SupportConversationEntity>> getAutoReply(
    String conversationId,
  );
}
