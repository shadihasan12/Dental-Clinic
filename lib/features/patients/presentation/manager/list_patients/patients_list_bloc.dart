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
  int? _total;

  /// Where the list stands, for the desktop table's page footer. Mobile
  /// scrolls and appends instead, and never reads these.
  int get currentPage => _currentPage;
  int get lastPage => _lastPage;

  /// Patients across every page, as the server counts them; null until a
  /// response has said.
  int? get total => _total;

  /// Rows per request. Null is the server's default, which mobile's
  /// infinite scroll uses; the desktop table sets a fixed size so a page
  /// fits the window with only a little scrolling.
  int? pageSize;

  /// The active search, applied to every load so a refresh or a tab return
  /// does not silently drop back to the full roster while the field still
  /// shows a query.
  String _search = '';

  /// The page fires loadMore on every scroll tick near the bottom, and bloc
  /// handlers run concurrently, so without this two requests would both ask
  /// for the same next page and append it twice.
  bool _loadingMore = false;

  /// Bumped by every reload. A next-page response that comes back after a
  /// reload belongs to the old list and is dropped rather than appended.
  int _generation = 0;

  PatientsListBloc({
    required GetAllPatientsUseCase getAllPatients,
  })  : _getAllPatients = getAllPatients,
        super(const PatientsListState.initial()) {
    on<_LoadPatients>(_onLoadPatients);
    on<_LoadMore>(_onLoadMore);
    on<_Search>(_onSearch);
    on<_GoToPage>(_onGoToPage);
  }

  Future<void> _onLoadPatients(
    _LoadPatients event,
    Emitter<PatientsListState> emit,
  ) => _reload(emit);

  /// First page of whatever is currently being shown - the roster, or the
  /// matches for [_search].
  Future<void> _reload(Emitter<PatientsListState> emit) async {
    emit(const PatientsListState.loading());

    final generation = ++_generation;
    _allPatients = [];
    _currentPage = 0;
    _lastPage = 1;

    final result = await _getAllPatients(
      GetAllPatientsParams(page: 1, search: _search, size: pageSize),
    );

    // A newer reload (a search typed while this one was in flight) owns the
    // list now.
    if (generation != _generation) return;

    result.fold(
      (error) => emit(
        PatientsListState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (response) {
        _allPatients = response.data;
        _currentPage = response.currentPage;
        _lastPage = response.lastPage;
        _total = response.total;
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
    // _currentPage is 0 while a reload is still fetching page 1.
    if (_loadingMore || _currentPage == 0 || _currentPage >= _lastPage) {
      return;
    }
    _loadingMore = true;
    final generation = _generation;

    emit(PatientsListState.loadingMore(patients: _allPatients));

    final result = await _getAllPatients(
      GetAllPatientsParams(
        page: _currentPage + 1,
        search: _search,
        size: pageSize,
      ),
    );

    _loadingMore = false;
    if (generation != _generation) return;

    result.fold(
      (error) => emit(PatientsListState.loaded(
        patients: _allPatients,
        hasMore: _currentPage < _lastPage,
      )),
      (response) {
        // Offset paging still shifts when a patient is added or removed
        // between pages, which can hand back a row already shown. Skip it
        // rather than list the same patient twice.
        final seen = {for (final p in _allPatients) p.id};
        _allPatients = [
          ..._allPatients,
          ...response.data.where((p) => seen.add(p.id)),
        ];
        _currentPage = response.currentPage;
        _lastPage = response.lastPage;
        emit(PatientsListState.loaded(
          patients: _allPatients,
          hasMore: response.hasMore,
        ));
      },
    );
  }

  /// Replaces the list with one page - the desktop table's page buttons.
  /// Also how the desktop refreshes, by asking for the page it is already
  /// on, so an edit on page 3 does not bounce the user back to page 1.
  Future<void> _onGoToPage(
    _GoToPage event,
    Emitter<PatientsListState> emit,
  ) async {
    final generation = ++_generation;
    // Rows stay on screen while the page loads, rather than blanking the
    // table between every click.
    emit(PatientsListState.loadingMore(patients: _allPatients));

    var page = event.page < 1 ? 1 : event.page;
    var result = await _getAllPatients(
      GetAllPatientsParams(page: page, search: _search, size: pageSize),
    );
    if (generation != _generation) return;

    // Deleting the only patient on the last page leaves that page empty;
    // step back to what is now the last one instead of showing nothing.
    final shrunk = result.fold(
      (_) => null,
      (r) => r.data.isEmpty && page > 1 && r.lastPage < page ? r.lastPage : null,
    );
    if (shrunk != null) {
      page = shrunk < 1 ? 1 : shrunk;
      result = await _getAllPatients(
        GetAllPatientsParams(page: page, search: _search, size: pageSize),
      );
      if (generation != _generation) return;
    }

    result.fold(
      (error) => emit(
        PatientsListState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (response) {
        _allPatients = response.data;
        _currentPage = response.currentPage;
        _lastPage = response.lastPage;
        _total = response.total;
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
