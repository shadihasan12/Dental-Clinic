import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/clinic/data/endpoints/clinic_endpoints.dart';
import 'package:dental_clinic_app/features/clinic/data/models/clinic_membership_model.dart';
import 'package:dental_clinic_app/features/clinic/data/models/clinic_user_model.dart';
import 'package:dental_clinic_app/features/clinic/data/models/invitation_model.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/invitation_entity.dart';
import 'package:injectable/injectable.dart';

abstract class ClinicRemoteDataSource {
  Future<List<ClinicMembershipModel>> getMyClinics();
  Future<List<InvitationModel>> getReceivedInvitations({
    InvitationStatus? status,
  });
  Future<List<InvitationModel>> getSentInvitations({
    InvitationStatus? status,
  });
  Future<InvitationModel> sendInvitation({
    required String email,
    required List<String> roles,
  });
  Future<InvitationModel> acceptInvitation(String id);
  Future<InvitationModel> declineInvitation(String id);
  Future<List<ClinicUserModel>> getClinicUsers(String clinicId);
  Future<ClinicUserModel> addClinicUser({
    required String clinicId,
    required String firstName,
    required String lastName,
    required String email,
    required String mobileNumber,
    required String password,
    required String passwordConfirmation,
    required List<String> roles,
    String? specialtyId,
  });
  Future<void> updateUserRoles({
    required String clinicId,
    required String userId,
    required List<String> roles,
  });
  Future<void> removeClinicUser({
    required String clinicId,
    required String userId,
  });
}

@LazySingleton(as: ClinicRemoteDataSource)
class ClinicRemoteDataSourceImpl implements ClinicRemoteDataSource {
  final ApiConsumer _apiConsumer;

  ClinicRemoteDataSourceImpl(this._apiConsumer);

  Map<String, dynamic> _clinicHeaders(String clinicId) =>
      {'X-Selected-Clinic-id': clinicId};

  @override
  Future<List<ClinicMembershipModel>> getMyClinics() async {
    final response = await _apiConsumer.get(ClinicEndpoints.myClinics);
    final dataList = response['data'] as List;
    return dataList
        .map((e) => ClinicMembershipModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<InvitationModel>> getReceivedInvitations({
    InvitationStatus? status,
  }) async {
    final response = await _apiConsumer.get(
      ClinicEndpoints.receivedInvitations,
      queryParameters: status != null
          ? {'filters[status][eq]': InvitationModel.apiValue(status)}
          : null,
    );
    final dataList = response['data'] as List;
    return dataList
        .map((e) => InvitationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<InvitationModel>> getSentInvitations({
    InvitationStatus? status,
  }) async {
    final response = await _apiConsumer.get(
      ClinicEndpoints.sentInvitations,
      queryParameters: status != null
          ? {'filters[status][eq]': InvitationModel.apiValue(status)}
          : null,
    );
    final dataList = response['data'] as List;
    return dataList
        .map((e) => InvitationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<InvitationModel> sendInvitation({
    required String email,
    required List<String> roles,
  }) async {
    final response = await _apiConsumer.post(
      ClinicEndpoints.sendInvitation,
      body: {'email': email, 'roles': roles},
    );
    final data = response['data'] as Map<String, dynamic>;
    return InvitationModel.fromJson(data);
  }

  @override
  Future<InvitationModel> acceptInvitation(String id) async {
    final response = await _apiConsumer.put(
      ClinicEndpoints.acceptInvitation(id),
    );
    final data = response['data'] as Map<String, dynamic>;
    return InvitationModel.fromJson(data);
  }

  @override
  Future<InvitationModel> declineInvitation(String id) async {
    final response = await _apiConsumer.put(
      ClinicEndpoints.declineInvitation(id),
    );
    final data = response['data'] as Map<String, dynamic>;
    return InvitationModel.fromJson(data);
  }

  @override
  Future<List<ClinicUserModel>> getClinicUsers(String clinicId) async {
    final response = await _apiConsumer.get(
      ClinicEndpoints.clinicUsers,
      headers: _clinicHeaders(clinicId),
    );
    final dataList = response['data'] as List;
    return dataList
        .map((e) => ClinicUserModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ClinicUserModel> addClinicUser({
    required String clinicId,
    required String firstName,
    required String lastName,
    required String email,
    required String mobileNumber,
    required String password,
    required String passwordConfirmation,
    required List<String> roles,
    String? specialtyId,
  }) async {
    final response = await _apiConsumer.post(
      ClinicEndpoints.clinicUsers,
      headers: _clinicHeaders(clinicId),
      body: {
        'user': {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'mobile_number': mobileNumber,
          'password': password,
          'password_confirmation': passwordConfirmation,
          if (specialtyId != null) 'specialty_id': specialtyId,
        },
        'roles': roles,
      },
    );
    final data = response['data'] as Map<String, dynamic>;
    return ClinicUserModel.fromJson(data);
  }

  @override
  Future<void> updateUserRoles({
    required String clinicId,
    required String userId,
    required List<String> roles,
  }) async {
    await _apiConsumer.post(
      ClinicEndpoints.clinicUserRoles(userId),
      headers: _clinicHeaders(clinicId),
      body: {'roles': roles},
    );
  }

  @override
  Future<void> removeClinicUser({
    required String clinicId,
    required String userId,
  }) async {
    await _apiConsumer.delete(
      ClinicEndpoints.clinicUser(userId),
      headers: _clinicHeaders(clinicId),
    );
  }
}
