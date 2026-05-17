import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
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
          searchController: _searchController,
          onAddTap: () {},
          onSearchChanged: (_) {},
        ),
        Divider(height: 1, color: ColorManager.of(context).divider),
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
          child: PatientFilterChips(
            filters: filters,
            selectedFilter: filters[0],
            onFilterSelected: (_) {},
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: 6,
            itemBuilder: (_, __) => const _PatientCardSkeleton(),
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
        Divider(height: 1, color: ColorManager.of(context).divider),
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
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
              : CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    CupertinoSliverRefreshControl(onRefresh: _onRefresh),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                      sliver: SliverList.separated(
                        itemCount:
                            filtered.length +
                            (isLoadingMore || hasMore ? 1 : 0),
                        separatorBuilder: (_, __) =>
                            Divider(height: 1, color: ColorManager.of(context).divider),
                        itemBuilder: (context, index) {
                          if (index == filtered.length) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: _PatientCardSkeleton(),
                            );
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
      ],
    );
  }

  // ─── Empty state ──────────────────────────────────────────────────────

  Widget _buildEmptyState(AppLocalizations l10n, bool isCompletelyEmpty) {
    final fontFamily = FontHelper.fontFamily(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isCompletelyEmpty
                  ? Icons.person_add_outlined
                  : Icons.search_off_outlined,
              size: 30.w,
              color: ColorManager.of(context).border,
            ),
            SizedBox(height: 16.h),
            Text(
              isCompletelyEmpty ? l10n.noPatientsYet : l10n.noMatchingPatients,
              style: TextStyle(
                fontSize: FontSizesManager.s14,
                fontFamily: fontFamily,
                color: ColorManager.of(context).textTertiary,
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: _navigateToAddPatient,
              child: Text(
                isCompletelyEmpty
                    ? l10n.noPatientsYetDesc
                    : l10n.noMatchingPatientsDesc,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ],
        ),
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
          searchController: _searchController,
          onAddTap: _navigateToAddPatient,
          onSearchChanged: (_) {},
        ),
        Divider(height: 1, color: ColorManager.of(context).divider),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, size: 48.w, color: ColorManager.of(context).textTertiary),
                  SizedBox(height: 12.h),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorManager.of(context).textTertiary,
                      fontFamily: FontHelper.fontFamily(context),
                    ),
                  ),
                ],
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
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppShimmer(
        child: Row(
          children: [
            ShimmerBox(
              width: 52.w,
              height: 52.w,
              radius: BorderRadius.circular(52.w),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 140.w, height: 14.h),
                  SizedBox(height: 8.h),
                  ShimmerBox(width: 100.w, height: 10.h),
                  SizedBox(height: 8.h),
                  ShimmerBox(width: 120.w, height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
