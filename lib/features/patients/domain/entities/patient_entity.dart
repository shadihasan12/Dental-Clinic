import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_entity.freezed.dart';

@freezed
class PatientEntity with _$PatientEntity {
  const factory PatientEntity({
    required String id,
    required String name,
    required int age,
    required String gender,
    required String phone,
    required String email,
    required String address,
    required DateTime dateOfBirth,
    String? medicalHistory,
    String? allergies,
    String? insuranceProvider,
    String? insuranceNumber,
    String? emergencyContact,
    @Default('active') String status,
    String? avatarUrl,
    String? nextVisit,
    @Default(0) double balance,
  }) = _PatientEntity;
}

@freezed
class CaseEntity with _$CaseEntity {
  const factory CaseEntity({
    required String id,
    required String title,
    required DateTime startDate,
    DateTime? endDate,
    required String status,
    required double totalCost,
    required double paidAmount,
    required double pendingAmount,
    @Default([]) List<VisitEntity> visits,
  }) = _CaseEntity;
}

@freezed
class VisitEntity with _$VisitEntity {
  const factory VisitEntity({
    required String id,
    required DateTime date,
    required List<String> treatmentTypes,
    @Default([]) List<int> teethTreated,
    required String summary,
    @Default([]) List<String> attachments,
  }) = _VisitEntity;
}

@freezed
class PaymentEntity with _$PaymentEntity {
  const factory PaymentEntity({
    required String id,
    required DateTime date,
    required double amount,
    required String method,
    required String status,
    String? caseId,
    required String description,
  }) = _PaymentEntity;
}
