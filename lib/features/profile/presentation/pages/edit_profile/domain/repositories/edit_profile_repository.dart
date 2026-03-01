import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/domain/entities/user_profile_entity.dart';

abstract class EditProfileRepository {
  Future<Either<NetworkExceptions, UserProfileEntity>> getUserProfile();
  Future<Either<NetworkExceptions, UserProfileEntity>> updateUserProfile(
    UserProfileEntity profile,
  );
}
