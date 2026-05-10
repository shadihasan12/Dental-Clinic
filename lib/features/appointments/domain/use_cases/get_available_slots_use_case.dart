import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:injectable/injectable.dart';

class GetAvailableSlotsParams {
  final DateTime date;
  final int durationMinutes;
  final String? doctorId;
  final bool isVip;

  const GetAvailableSlotsParams({
    required this.date,
    required this.durationMinutes,
    this.doctorId,
    this.isVip = false,
  });
}

@injectable
class GetAvailableSlotsUseCase
    implements UseCase<List<String>, GetAvailableSlotsParams> {
  final AppointmentRepository _repository;

  GetAvailableSlotsUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, List<String>>> call(
    GetAvailableSlotsParams params,
  ) {
    return _repository.getAvailableSlots(
      params.date,
      params.durationMinutes,
      doctorId: params.doctorId,
      isVip: params.isVip,
    );
  }
}
