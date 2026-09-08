import 'package:dartz/dartz.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/models/paginated_response.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/repositories/patient_repository.dart';
import 'package:injectable/injectable.dart';

/// One page of the roster, or the matches for a name.
///
/// [search] is the whole reason this is a params object rather than a bare
/// page number: filtering used to happen in the page over the rows already
/// scrolled into memory, which quietly hid every patient past the first page.
class GetAllPatientsParams {
  const GetAllPatientsParams({this.page = 1, this.search});

  final int page;

  /// A name fragment. Null or blank fetches the roster page instead.
  final String? search;
}

@injectable
class GetAllPatientsUseCase
    implements UseCase<PaginatedResponse<PatientEntity>, GetAllPatientsParams> {
  final PatientRepository _repository;

  GetAllPatientsUseCase(this._repository);

  @override
  Future<Either<NetworkExceptions, PaginatedResponse<PatientEntity>>> call(
    GetAllPatientsParams params,
  ) {
    return _repository.getAllPatients(
      page: params.page,
      search: params.search,
    );
  }
}
