import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

/// A single treatment plan item to be sent to the API.
class TreatmentPlanItemParam extends Equatable {
  final String? description;
  final List<String> coreTreatmentIds;
  final List<String> toothIds;
  final List<Map<String, String>> notes; // [{note, date}]

  const TreatmentPlanItemParam({
    this.description,
    required this.coreTreatmentIds,
    required this.toothIds,
    this.notes = const [],
  });

  Map<String, dynamic> toJson() => {
        if (description != null && description!.isNotEmpty)
          'description': description,
        'core_treatment_ids': coreTreatmentIds,
        'tooth_ids': toothIds,
        if (notes.isNotEmpty) 'notes': notes,
      };

  @override
  List<Object?> get props => [description, coreTreatmentIds, toothIds, notes];
}

class AddTreatmentParams extends Equatable {
  final String patientId;
  final bool isInitial;
  final String? caseId;
  final DateTime visitDate;
  final double totalCost;
  final String? totalCostCurrencyId;
  final double labFees;
  final String? labFeesCurrencyId;
  final List<String> attachments;
  final List<TreatmentPlanItemParam> treatmentPlanItems;

  // Legacy fields kept for non-initial (single item) usage
  final List<String> treatmentTypes;
  final List<String> selectedTeeth;
  final String? summary;

  const AddTreatmentParams({
    required this.patientId,
    required this.isInitial,
    this.caseId,
    required this.visitDate,
    this.treatmentTypes = const [],
    this.selectedTeeth = const [],
    this.summary,
    required this.totalCost,
    this.totalCostCurrencyId,
    required this.labFees,
    this.labFeesCurrencyId,
    required this.attachments,
    this.treatmentPlanItems = const [],
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
        totalCostCurrencyId,
        labFees,
        labFeesCurrencyId,
        attachments,
        treatmentPlanItems,
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
