import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/use_cases/create_issue_use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/use_cases/get_issues_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'issues_bloc.freezed.dart';
part 'issues_event.dart';
part 'issues_state.dart';

@injectable
class IssuesBloc extends Bloc<IssuesEvent, IssuesState> {
  final GetIssuesUseCase _getIssues;
  final CreateIssueUseCase _createIssue;

  IssuesBloc({
    required GetIssuesUseCase getIssues,
    required CreateIssueUseCase createIssue,
  })  : _getIssues = getIssues,
        _createIssue = createIssue,
        super(const IssuesState()) {
    on<_Load>(_onLoad);
    on<_Submit>(_onSubmit);
  }

  Future<void> _onLoad(_Load event, Emitter<IssuesState> emit) async {
    emit(state.copyWith(
      status: IssuesStatus.loading,
      errorMessage: null,
    ));

    final result = await _getIssues(NoParams());

    result.fold(
      (error) => emit(state.copyWith(
        status: IssuesStatus.failure,
        errorMessage: NetworkExceptions.getErrorMessage(error),
      )),
      (issues) => emit(state.copyWith(
        status: IssuesStatus.success,
        issues: issues,
        errorMessage: null,
      )),
    );
  }

  Future<void> _onSubmit(_Submit event, Emitter<IssuesState> emit) async {
    final title = event.title.trim();
    final description = event.description.trim();
    // The form guards this too; the bloc refuses as well so a caller can
    // never file an empty report by dispatching directly.
    if (title.isEmpty || description.isEmpty) return;
    if (state.isSubmitting) return;

    emit(state.copyWith(
      isSubmitting: true,
      submitError: null,
      justCreated: false,
    ));

    final result = await _createIssue(
      CreateIssueParams(title: title, description: description),
    );

    result.fold(
      (error) => emit(state.copyWith(
        isSubmitting: false,
        submitError: NetworkExceptions.getErrorMessage(error),
      )),
      (issue) => emit(state.copyWith(
        isSubmitting: false,
        submitError: null,
        // Prepended rather than refetched: the create response already is
        // the record, and a reload would blank the list the user is looking
        // at. If the server orders differently, the next load corrects it.
        issues: [issue, ...state.issues],
        // The list is authoritative from here even if the first load failed.
        status: IssuesStatus.success,
        justCreated: true,
      )),
    );
  }
}
