import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/auth/data/models/specialty_model.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/specialty_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/data/models/user_profile_model.dart';
import 'package:injectable/injectable.dart';

abstract class EditProfileRemoteDataSource {
  Future<UserProfileModel> getUserProfile();
  Future<UserProfileModel> updateUserProfile(UserProfileModel profile);
  Future<List<SpecialtyEntity>> getSpecialties();
}

@Injectable(as: EditProfileRemoteDataSource)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final ApiConsumer _apiConsumer;

  EditProfileRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<UserProfileModel> getUserProfile() async {
    final response = await _apiConsumer.get('/auth/profile');
    final data = response['data'] as Map<String, dynamic>;
    return UserProfileModel.fromJson(data);
  }

  @override
  Future<UserProfileModel> updateUserProfile(UserProfileModel profile) async {
    final body = profile.toUpdateJson();
    await _apiConsumer.post(
      '/auth/update-profile',
      body: body,
    );
    return profile;
  }

  @override
  Future<List<SpecialtyEntity>> getSpecialties() async {
    final response = await _apiConsumer.get('/specialties');
    final data = response['data'] as List;
    return data
        .map((json) => SpecialtyModel.fromJson(json as Map<String, dynamic>).toEntity())
        .toList();
  }
}
