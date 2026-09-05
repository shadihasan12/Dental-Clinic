import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/use_cases/create_issue_use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/use_cases/get_issue_categories_use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/use_cases/get_issue_statuses_use_case.dart';
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
  final GetIssueCategoriesUseCase _getCategories;
  final GetIssueStatusesUseCase _getStatuses;

  IssuesBloc({
    required GetIssuesUseCase getIssues,
    required CreateIssueUseCase createIssue,
    required GetIssueCategoriesUseCase getCategories,
    required GetIssueStatusesUseCase getStatuses,
  }) : _getIssues = getIssues,
       _createIssue = createIssue,
       _getCategories = getCategories,
       _getStatuses = getStatuses,
       super(const IssuesState()) {
    on<_Load>(_onLoad);
    on<_LoadMore>(_onLoadMore);
    on<_ReloadCategories>(_onReloadCategories);
    on<_Submit>(_onSubmit);
  }

  static const int _pageSize = 15;

  Future<void> _onLoad(_Load event, Emitter<IssuesState> emit) async {
    emit(
      state.copyWith(
        status: IssuesStatus.loading,
        errorMessage: null,
        isLoadingCategories: true,
        categoriesError: null,
      ),
    );

    // The three calls are independent, so they all go out before anything is
    // awaited rather than making the user wait for them in sequence.
    final issuesFuture = _getIssues(
      const GetIssuesParams(page: 1, size: _pageSize),
    );
    final categoriesFuture = _getCategories(NoParams());
    final statusesFuture = _getStatuses(NoParams());

    final issuesResult = await issuesFuture;
    final categoriesResult = await categoriesFuture;
    final statusesResult = await statusesFuture;

    var next = state;

    issuesResult.fold(
      (error) => next = next.copyWith(
        status: IssuesStatus.failure,
        errorMessage: NetworkExceptions.getErrorMessage(error),
      ),
      (page) => next = next.copyWith(
        status: IssuesStatus.success,
        issues: page.items,
        page: page.page,
        lastPage: page.lastPage,
        errorMessage: null,
      ),
    );

    categoriesResult.fold(
      (error) => next = next.copyWith(
        isLoadingCategories: false,
        categoriesError: NetworkExceptions.getErrorMessage(error),
      ),
      (categories) => next = next.copyWith(
        isLoadingCategories: false,
        categories: categories,
        categoriesError: null,
      ),
    );

    // A missing status list is not worth an error: the report still renders,
    // labelled with its raw value.
    statusesResult.fold(
      (_) {},
      (statuses) => next = next.copyWith(statuses: statuses),
    );

    emit(next);
  }

  Future<void> _onLoadMore(_LoadMore event, Emitter<IssuesState> emit) async {
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final result = await _getIssues(
      GetIssuesParams(page: state.page + 1, size: _pageSize),
    );

    result.fold(
      // The pages already on screen stay; only the footer stops spinning.
      (error) => emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: NetworkExceptions.getErrorMessage(error),
        ),
      ),
      (page) => emit(
        state.copyWith(
          isLoadingMore: false,
          issues: [...state.issues, ...page.items],
          page: page.page,
          lastPage: page.lastPage,
        ),
      ),
    );
  }

  Future<void> _onReloadCategories(
    _ReloadCategories event,
    Emitter<IssuesState> emit,
  ) async {
    if (state.isLoadingCategories) return;

    emit(state.copyWith(isLoadingCategories: true, categoriesError: null));

    final result = await _getCategories(NoParams());

    result.fold(
      (error) => emit(
        state.copyWith(
          isLoadingCategories: false,
          categoriesError: NetworkExceptions.getErrorMessage(error),
        ),
      ),
      (categories) => emit(
        state.copyWith(
          isLoadingCategories: false,
          categories: categories,
          categoriesError: null,
        ),
      ),
    );
  }

  Future<void> _onSubmit(_Submit event, Emitter<IssuesState> emit) async {
    final title = event.title.trim();
    final description = event.description.trim();
    // The form guards these too; the bloc refuses as well so a caller can
    // never file an empty report by dispatching directly.
    if (event.category.isEmpty || title.isEmpty || description.isEmpty) return;
    if (state.isSubmitting) return;

    emit(
      state.copyWith(
        isSubmitting: true,
        submitError: null,
        justCreated: false,
      ),
    );

    final result = await _createIssue(
      CreateIssueParams(
        category: event.category,
        title: title,
        description: description,
        mediaItemIds: event.mediaItemIds,
      ),
    );

    result.fold(
      (error) => emit(
        state.copyWith(
          isSubmitting: false,
          submitError: NetworkExceptions.getErrorMessage(error),
        ),
      ),
      (issue) => emit(
        state.copyWith(
          isSubmitting: false,
          submitError: null,
          // Prepended rather than refetched: the create response already is
          // the record, and a reload would blank the list the user is
          // looking at. The next load puts it in the server's order.
          issues: [issue, ...state.issues],
          // The list is authoritative from here even if the first load
          // failed.
          status: IssuesStatus.success,
          justCreated: true,
        ),
      ),
    );
  }
}
