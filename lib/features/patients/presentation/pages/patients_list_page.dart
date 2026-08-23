import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/state_card.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/detach_patient_use_case.dart';
import 'package:dental_clinic_app/features/patients/presentation/manager/list_patients/patients_list_bloc.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/confirm_delete_dialog.dart';
import 'package:dental_clinic_app/features/root/presentation/pages/root_page.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class PatientsListPage extends StatelessWidget {
  const PatientsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<PatientsListBloc>()
            ..add(const PatientsListEvent.loadPatients()),
      child: const _PatientsListContent(),
    );
  }
}

class _PatientsListContent extends StatefulWidget {
  const _PatientsListContent();

  @override
  State<_PatientsListContent> createState() => _PatientsListContentState();
}

class _PatientsListContentState extends State<_PatientsListContent> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  int _selectedFilterIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    RootPage.selectedTab.addListener(_onTabChanged);
    UserStorage.patientsChangedNotifier.addListener(_onPatientsChanged);
  }

  @override
  void dispose() {
    RootPage.selectedTab.removeListener(_onTabChanged);
    UserStorage.patientsChangedNotifier.removeListener(_onPatientsChanged);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onPatientsChanged() {
    // Fires after add / edit / delete from anywhere. Guard against duplicate
    // calls while a load is already in flight.
    if (!mounted) return;
    final bloc = context.read<PatientsListBloc>();
    final isBusy = bloc.state.maybeWhen(
      loading: () => true,
      loadingMore: (_) => true,
      orElse: () => false,
    );
    if (isBusy) return;
    bloc.add(const PatientsListEvent.loadPatients());
  }

  void _onTabChanged() {
    // Refresh the list each time the user lands on the Patients tab so new /
    // edited / deleted patients show up without a manual pull-to-refresh.
    // Guarded so we don't fire while a load is already in flight.
    if (RootPage.selectedTab.value != 1) return;
    if (!mounted) return;
    final bloc = context.read<PatientsListBloc>();
    final isBusy = bloc.state.maybeWhen(
      loading: () => true,
      loadingMore: (_) => true,
      orElse: () => false,
    );
    if (isBusy) return;
    bloc.add(const PatientsListEvent.loadPatients());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PatientsListBloc>().add(const PatientsListEvent.loadMore());
    }
  }

  Future<void> _onRefresh() async {
    context.read<PatientsListBloc>().add(
      const PatientsListEvent.loadPatients(),
    );
    // Wait for the bloc to emit a non-loading state
    await context.read<PatientsListBloc>().stream.firstWhere(
      (state) => state.maybeWhen(loading: () => false, orElse: () => true),
    );
  }

  Future<void> _navigateToAddPatient() async {
    if (!await SubscriptionGuardHelper.requireActive(context)) return;
    if (!mounted) return;
    await context.pushNamed(AppRoutesNames.addPatient);
    if (mounted) {
      context.read<PatientsListBloc>().add(
        const PatientsListEvent.loadPatients(),
      );
    }
  }

  Future<void> _onEditPatient(Patient patient) async {
    final entity = context
        .read<PatientsListBloc>()
        .state
        .maybeWhen(
          loaded: (entities, _) => entities,
          loadingMore: (entities) => entities,
          orElse: () => const <PatientEntity>[],
        )
        .firstWhere(
          (e) => e.id == patient.id,
          orElse: () => PatientEntity(
            id: patient.id,
            name: patient.name,
            age: patient.age,
            gender: patient.gender,
            phone: patient.phone,
            email: '',
            address: '',
            dateOfBirth: DateTime.now(),
          ),
        );
    await context.pushNamed(
      AppRoutesNames.editPatient,
      extra: <String, dynamic>{'patient': entity},
    );
    if (mounted) {
      context.read<PatientsListBloc>().add(
        const PatientsListEvent.loadPatients(),
      );
    }
  }

  Future<void> _onDeletePatient(Patient patient) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await ConfirmDeleteDialog.show(
      context,
      title: l10n.deletePatient,
      message: l10n.deletePatientConfirmation(patient.name),
    );
    if (!confirmed || !mounted) return;

    final result = await getIt<DetachPatientUseCase>()(patient.id);
    if (!mounted) return;

    result.fold(
      (error) => AppSnackbar.showError(
        context,
        title: l10n.error,
        message: NetworkExceptions.getErrorMessage(error),
      ),
      (_) {
        UserStorage.notifyPatientsChanged();
        AppSnackbar.showSuccess(
          context,
          title: l10n.success,
          message: l10n.patientDeleted,
        );
      },
    );
  }

  List<Patient> _mapToDisplayModel(List<PatientEntity> entities) {
    return entities
        .map(
          (e) => Patient(
            id: e.id,
            name: e.name,
            age: e.age,
            gender: e.gender,
            phone: e.phone,
            nextVisit: e.nextVisit,
            balance: e.balance,
          ),
        )
        .toList();
  }

  List<Patient> _applyFilters(List<Patient> patients) {
    final query = _searchController.text.toLowerCase();

    var filtered = patients;
    if (query.isNotEmpty) {
      filtered = filtered
          .where((p) => p.name.toLowerCase().contains(query))
          .toList();
    }

    // Index 1 = "New" filter — show only patients with balance == 0
    if (_selectedFilterIndex == 1) {
      filtered = filtered.where((p) => p.balance == 0).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filters = [l10n.allFilter, l10n.newFilter];

    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: BlocBuilder<PatientsListBloc, PatientsListState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => _buildLoading(l10n, filters),
            loaded: (entities, hasMore) => _buildLoaded(
              l10n,
              filters,
              _mapToDisplayModel(entities),
              hasMore: hasMore,
            ),
            loadingMore: (entities) => _buildLoaded(
              l10n,
              filters,
              _mapToDisplayModel(entities),
              isLoadingMore: true,
            ),
            error: (message) => _buildError(l10n, filters, message),
          );
        },
      ),
    );
  }

  // ─── Loading skeleton ──────────────────────────────────────────────────

  Widget _buildLoading(AppLocalizations l10n, List<String> filters) {
    return Column(
      children: [
        PatientsListHeader(
          patientCount: 0,
          showCount: false,
          searchController: _searchController,
          onAddTap: () {},
          onSearchChanged: (_) {},
        ),
        Divider(height: 1, color: ColorManager.of(context).borderLight),
        Padding(
          padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 10.h),
          child: PatientFilterChips(
            filters: filters,
            selectedFilter: filters[0],
            onFilterSelected: (_) {},
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            itemCount: 6,
            itemBuilder: (_, i) => const _PatientCardSkeleton(),
          ),
        ),
      ],
    );
  }

  // ─── Loaded list ───────────────────────────────────────────────────────

  Widget _buildLoaded(
    AppLocalizations l10n,
    List<String> filters,
    List<Patient> allPatients, {
    bool hasMore = false,
    bool isLoadingMore = false,
  }) {
    final filtered = _applyFilters(allPatients);

    return Column(
      children: [
        PatientsListHeader(
          patientCount: allPatients.length,
          searchController: _searchController,
          onAddTap: _navigateToAddPatient,
          onSearchChanged: (_) => setState(() {}),
        ),
        Divider(height: 1, color: ColorManager.of(context).borderLight),
        Padding(
          padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 10.h),
          child: PatientFilterChips(
            filters: filters,
            selectedFilter: filters[_selectedFilterIndex],
            onFilterSelected: (filter) =>
                setState(() => _selectedFilterIndex = filters.indexOf(filter)),
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? _buildEmptyState(l10n, allPatients.isEmpty)
              // Keeps only one row's swipe pane open at a time, matched by
              // PatientCard.groupTag.
              : SlidableAutoCloseBehavior(
                  child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    CupertinoSliverRefreshControl(onRefresh: _onRefresh),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 24.h),
                      // Cards carry their own hairline and 8.h gap, so no
                      // separator: a divider between bordered cards would
                      // read as a double rule.
                      sliver: SliverList.builder(
                        itemCount:
                            filtered.length +
                            (isLoadingMore || hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == filtered.length) {
                            return const _PatientCardSkeleton();
                          }

                          final patient = filtered[index];
                          return PatientCard(
                            patient: patient,
                            onTap: () => context.pushNamed(
                              AppRoutesNames.patientDetails,
                              extra: <String, dynamic>{
                                "patientId": patient.id,
                                "patientName": patient.name,
                                "tabIndex": 1,
                              },
                            ),
                            onEdit: () => _onEditPatient(patient),
                            onDelete: () => _onDeletePatient(patient),
                          );
                        },
                      ),
                    ),
                  ],
                  ),
                ),
        ),
      ],
    );
  }

  // ─── Empty state ──────────────────────────────────────────────────────

  /// Same shape as the home screen's empty schedule: quiet grey disc, one
  /// sentence, and the action that fills the list. A no-match result gets no
  /// button - the fix is editing the search, which is already on screen.
  Widget _buildEmptyState(AppLocalizations l10n, bool isCompletelyEmpty) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 24.h),
      child: StateCard(
        icon: isCompletelyEmpty
            ? Icons.people_outline
            : Icons.search_off_outlined,
        title: isCompletelyEmpty ? l10n.noPatientsYet : l10n.noMatchingPatients,
        message: isCompletelyEmpty
            ? l10n.noPatientsYetDesc
            : l10n.noMatchingPatientsDesc,
        actionLabel: isCompletelyEmpty ? l10n.addPatient : null,
        onAction: isCompletelyEmpty ? _navigateToAddPatient : null,
      ),
    );
  }

  // ─── Error state ───────────────────────────────────────────────────────

  Widget _buildError(
    AppLocalizations l10n,
    List<String> filters,
    String message,
  ) {
    return Column(
      children: [
        PatientsListHeader(
          patientCount: 0,
          showCount: false,
          searchController: _searchController,
          onAddTap: _navigateToAddPatient,
          onSearchChanged: (_) {},
        ),
        Divider(height: 1, color: ColorManager.of(context).borderLight),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
            child: StateCard(
              icon: Icons.cloud_off_rounded,
              tone: ColorManager.error,
              title: l10n.patientsLoadFailed,
              message: message,
              actionLabel: l10n.retry,
              onAction: () => context.read<PatientsListBloc>().add(
                const PatientsListEvent.loadPatients(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Shimmer skeleton mirroring PatientCard's layout ──────────────────────

class _PatientCardSkeleton extends StatelessWidget {
  const _PatientCardSkeleton();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.borderLight),
      ),
      child: AppShimmer(
        child: Row(
          children: [
            ShimmerBox(
              width: 40.w,
              height: 40.w,
              radius: BorderRadius.circular(40.w),
            ),
            SizedBox(width: 11.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 130.w, height: 12.h),
                  SizedBox(height: 7.h),
                  ShimmerBox(width: 100.w, height: 10.h),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            ShimmerBox(
              width: 42.w,
              height: 20.h,
              radius: BorderRadius.circular(6.r),
            ),
          ],
        ),
      ),
    );
  }
}
