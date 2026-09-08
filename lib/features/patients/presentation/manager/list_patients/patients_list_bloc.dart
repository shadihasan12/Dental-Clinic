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

  /// The active search, applied to every load so a refresh or a tab return
  /// does not silently drop back to the full roster while the field still
  /// shows a query.
  String _search = '';

  PatientsListBloc({
    required GetAllPatientsUseCase getAllPatients,
  })  : _getAllPatients = getAllPatients,
        super(const PatientsListState.initial()) {
    on<_LoadPatients>(_onLoadPatients);
    on<_LoadMore>(_onLoadMore);
    on<_Search>(_onSearch);
  }

  Future<void> _onLoadPatients(
    _LoadPatients event,
    Emitter<PatientsListState> emit,
  ) => _reload(emit);

  /// First page of whatever is currently being shown - the roster, or the
  /// matches for [_search].
  Future<void> _reload(Emitter<PatientsListState> emit) async {
    emit(const PatientsListState.loading());

    _allPatients = [];
    _currentPage = 0;
    _lastPage = 1;

    final result = await _getAllPatients(
      GetAllPatientsParams(page: 1, search: _search),
    );

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

    final result = await _getAllPatients(
      GetAllPatientsParams(page: _currentPage + 1, search: _search),
    );

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

  /// Re-queries the server for a name. Debounced by the page, so this runs
  /// once the user stops typing rather than per keystroke.
  Future<void> _onSearch(
    _Search event,
    Emitter<PatientsListState> emit,
  ) async {
    final next = event.query.trim();
    if (next == _search) return;
    _search = next;
    await _reload(emit);
  }
}
