import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/app_snackbar.dart';
import 'package:dental_clinic_app/custom_widgets/denta_refresh.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/presentation/manager/issues_bloc.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/presentation/widgets/issue_card.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/presentation/widgets/issues_list_states.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/presentation/widgets/new_issue_form.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Report an Issue.
///
/// The user comes here to say something is broken and then to check what
/// happened to it, so the screen is one scroll: the compose card first,
/// then every report they have filed with its status. No tabs, no second
/// screen — filing and tracking are the same subject.
class ReportIssuePage extends StatelessWidget {
  const ReportIssuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<IssuesBloc>()..add(const IssuesEvent.load()),
      child: const _ReportIssueView(),
    );
  }
}

class _ReportIssueView extends StatefulWidget {
  const _ReportIssueView();

  @override
  State<_ReportIssueView> createState() => _ReportIssueViewState();
}

class _ReportIssueViewState extends State<_ReportIssueView> {
  final _formKey = GlobalKey<NewIssueFormState>();

  /// Only the reports list is refetched - the compose card above it holds
  /// whatever the user has typed, and a pull must not clear that.
  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<IssuesBloc>();
    bloc.add(const IssuesEvent.load());
    await bloc.stream.settled((state) => !state.isLoadingList);
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: Column(
        children: [
          PageHeader(title: l10n.reportIssue),
          Expanded(
            child: BlocConsumer<IssuesBloc, IssuesState>(
              listenWhen: (prev, curr) => !prev.justCreated && curr.justCreated,
              listener: (context, state) {
                // The bloc raises justCreated for one emission; clear the
                // fields and confirm, then let it fall away on its own.
                _formKey.currentState?.reset();
                AppSnackbar.showSuccess(
                  context,
                  title: l10n.success,
                  message: l10n.reportSent,
                );
              },
              builder: (context, state) {
                return DentaRefresh(
                  onRefresh: () => _refresh(context),
                  child: ListView(
                    // 14px screen gutters.
                    padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 28.h),
                    children: [
                      NewIssueForm(
                        key: _formKey,
                        isSubmitting: state.isSubmitting,
                        errorMessage: state.submitError,
                        categories: state.categories,
                        isLoadingCategories: state.isLoadingCategories,
                        categoriesError: state.categoriesError,
                        onRetryCategories: () => context
                            .read<IssuesBloc>()
                            .add(const IssuesEvent.reloadCategories()),
                        onSubmit: (category, title, description, mediaIds) {
                          context.read<IssuesBloc>().add(
                            IssuesEvent.submit(
                              category: category,
                              title: title,
                              description: description,
                              mediaItemIds: mediaIds,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 22.h),
                      SectionLabel(
                        l10n.yourReports,
                        // What is on screen, which is a page at a time until
                        // the user asks for more.
                        trailing: state.hasIssues
                            ? CountPill(state.issues.length)
                            : null,
                      ),
                      SizedBox(height: 10.h),
                      _ReportsList(state: state),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportsList extends StatelessWidget {
  const _ReportsList({required this.state});

  final IssuesState state;

  @override
  Widget build(BuildContext context) {
    // A failed load replaces only the list; the form above still works, so
    // a user can file a report even when the history cannot be fetched.
    if (state.status == IssuesStatus.failure) {
      return IssuesErrorState(
        message: state.errorMessage ?? '',
        onRetry: () => context.read<IssuesBloc>().add(const IssuesEvent.load()),
      );
    }

    if (state.isLoadingList && !state.hasIssues) {
      return const IssuesSkeleton();
    }

    if (!state.hasIssues) return const IssuesEmptyState();

    return Column(
      children: [
        for (var i = 0; i < state.issues.length; i++) ...[
          if (i > 0) SizedBox(height: 8.h),
          IssueCard(
            issue: state.issues[i],
            statusLabel: state.labelForStatus(state.issues[i].status),
            categoryLabel: state.labelForCategory(state.issues[i].category),
          ),
        ],
        // Paged 15 at a time. Rather than an infinite scroll inside a page
        // that is already one long scroll, the next page is asked for.
        if (state.hasMore) ...[
          SizedBox(height: 10.h),
          // A page that failed to load leaves what is already on screen
          // alone and says why above the button, which is still the retry.
          if (state.errorMessage != null && !state.isLoadingMore) ...[
            Text(
              state.errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.5.sp,
                height: 1.35,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.warning,
              ),
            ),
            SizedBox(height: 4.h),
          ],
          _LoadMoreButton(isLoading: state.isLoadingMore),
        ],
      ],
    );
  }
}

class _LoadMoreButton extends StatelessWidget {
  const _LoadMoreButton({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    return TextButton(
      onPressed: isLoading
          ? null
          : () => context.read<IssuesBloc>().add(const IssuesEvent.loadMore()),
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, 40.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: 16.w,
              height: 16.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: c.textTertiary,
              ),
            )
          : Text(
              l10n.loadMore,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.primaryDarker,
              ),
            ),
    );
  }
}
