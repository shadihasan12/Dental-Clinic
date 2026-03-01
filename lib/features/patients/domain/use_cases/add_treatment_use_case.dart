import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class AddTreatmentParams extends Equatable {
  final String patientId;
  final bool isInitial;
  final String? caseId;
  final DateTime visitDate;
  final List<String> treatmentTypes;
  final List<String> selectedTeeth;
  final String summary;
  final double totalCost;
  final double labFees;
  final List<String> attachments;

  const AddTreatmentParams({
    required this.patientId,
    required this.isInitial,
    this.caseId,
    required this.visitDate,
    required this.treatmentTypes,
    required this.selectedTeeth,
    required this.summary,
    required this.totalCost,
    required this.labFees,
    required this.attachments,
  });

  @override
  List<Object?> get props => [
        patientId,
        isInitial,
        caseId,
        visitDate,
        treatmentTypes,
        selectedTeeth,
        summary,
        totalCost,
        labFees,
        attachments,
      ];
}

@injectable
class AddTreatmentUseCase implements UseCase<TreatmentItem, AddTreatmentParams> {
  final PatientRepository _repository;

  AddTreatmentUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, TreatmentItem>> call(
    AddTreatmentParams params,
  ) {
    return _repository.addTreatment(params);
  }
}
