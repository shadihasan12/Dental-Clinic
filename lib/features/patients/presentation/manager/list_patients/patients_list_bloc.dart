import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_patients_use_case.dart';
import 'package:injectable/injectable.dart';

part 'patients_list_bloc.freezed.dart';
part 'patients_list_event.dart';
part 'patients_list_state.dart';

@injectable
class PatientsListBloc extends Bloc<PatientsListEvent, PatientsListState> {
  final GetAllPatientsUseCase _getAllPatients;

  List<PatientEntity> _allPatients = [];
  int _currentPage = 0;
  int _lastPage = 1;

  PatientsListBloc({
    required GetAllPatientsUseCase getAllPatients,
  })  : _getAllPatients = getAllPatients,
        super(const PatientsListState.initial()) {
    on<_LoadPatients>(_onLoadPatients);
    on<_LoadMore>(_onLoadMore);
  }

  Future<void> _onLoadPatients(
    _LoadPatients event,
    Emitter<PatientsListState> emit,
  ) async {
    emit(const PatientsListState.loading());

    _allPatients = [];
    _currentPage = 0;
    _lastPage = 1;

    final result = await _getAllPatients(1);

    result.fold(
      (error) => emit(
        PatientsListState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (response) {
        _allPatients = response.data;
        _currentPage = response.currentPage;
        _lastPage = response.lastPage;
        emit(PatientsListState.loaded(
          patients: _allPatients,
          hasMore: response.hasMore,
        ));
      },
    );
  }

  Future<void> _onLoadMore(
    _LoadMore event,
    Emitter<PatientsListState> emit,
  ) async {
    if (_currentPage >= _lastPage) return;

    emit(PatientsListState.loadingMore(patients: _allPatients));

    final result = await _getAllPatients(_currentPage + 1);

    result.fold(
      (error) => emit(PatientsListState.loaded(
        patients: _allPatients,
        hasMore: _currentPage < _lastPage,
      )),
      (response) {
        _allPatients = [..._allPatients, ...response.data];
        _currentPage = response.currentPage;
        _lastPage = response.lastPage;
        emit(PatientsListState.loaded(
          patients: _allPatients,
          hasMore: response.hasMore,
        ));
      },
    );
  }
}
