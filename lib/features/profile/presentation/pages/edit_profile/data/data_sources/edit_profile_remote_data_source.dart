import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/data/models/user_profile_model.dart';
import 'package:injectable/injectable.dart';

abstract class EditProfileRemoteDataSource {
  Future<UserProfileModel> getUserProfile();
  Future<UserProfileModel> updateUserProfile(UserProfileModel profile);
}

@Injectable(as: EditProfileRemoteDataSource)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  // ignore: unused_field
  final ApiConsumer _apiConsumer;

  EditProfileRemoteDataSourceImpl(this._apiConsumer);

  UserProfileModel? _cachedProfile;

  UserProfileModel _getMockProfile() {
    if (_cachedProfile != null) return _cachedProfile!;

    _cachedProfile = const UserProfileModel(
      id: 'user_1',
      firstName: 'Ahmed',
      lastName: 'Hassan',
      email: 'dr.ahmed@clinic.com',
      phone: '+963 988 026 431',
      location: 'Damascus, Syria',
      specialization: 'Endodontics',
    );
    return _cachedProfile!;
  }

  @override
  Future<UserProfileModel> getUserProfile() async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.get(EditProfileEndpoints.profile);
    // return UserProfileModel.fromJson(response as Map<String, dynamic>);

    await Future.delayed(const Duration(milliseconds: 800));
    return _getMockProfile();
  }

  @override
  Future<UserProfileModel> updateUserProfile(UserProfileModel profile) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.put(
    //   EditProfileEndpoints.updateProfile,
    //   body: profile.toJson(),
    // );
    // return UserProfileModel.fromJson(response as Map<String, dynamic>);

    await Future.delayed(const Duration(milliseconds: 600));
    _cachedProfile = profile;
    return profile;
  }
}
