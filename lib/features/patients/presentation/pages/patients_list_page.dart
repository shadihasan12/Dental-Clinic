import 'dart:async';

import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/state_card.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/denta_nav_bar.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/detach_patient_use_case.dart';
import 'package:dental_clinic_app/features/patients/presentation/manager/list_patients/patients_list_bloc.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/confirm_delete_dialog.dart';
import 'package:dental_clinic_app/features/root/presentation/pages/root_page.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' hide TextDirection;

import '../widgets/widgets.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/patient_row_actions_menu.dart';

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

  /// Search runs on the server, so it waits for a pause in typing rather
  /// than firing two requests per keystroke.
  Timer? _searchDebounce;
  static const Duration _searchDebounceDelay = Duration(milliseconds: 350);
  final _scrollController = ScrollController();
  int _selectedFilterIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    RootPage.selectedTab.addListener(_onTabChanged);
    UserStorage.patientsChangedNotifier.addListener(_onPatientsChanged);
  }

  /// Rows per page on the desktop table: enough to be useful, few enough
  /// that the page scrolls only a little rather than running on.
  static const int _desktopPageSize = 10;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Re-checked on every resize, so a window dragged across the desktop
    // breakpoint switches between paged and scrolled lists cleanly. Mobile
    // keeps the server's default size, as it always has.
    final size = Responsive.isDesktop(context) ? _desktopPageSize : null;
    final bloc = context.read<PatientsListBloc>();
    if (bloc.pageSize == size) return;
    bloc.pageSize = size;
    // A list already loaded at the other size has the wrong page bounds.
    if (bloc.currentPage > 0) {
      bloc.add(const PatientsListEvent.loadPatients());
    }
  }

  @override
  void dispose() {
    RootPage.selectedTab.removeListener(_onTabChanged);
    UserStorage.patientsChangedNotifier.removeListener(_onPatientsChanged);
    _searchDebounce?.cancel();
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
    _reload(bloc);
  }

  /// Desktop pages through the table, so it refreshes the page it is on;
  /// mobile starts the scrolled list over from the top.
  void _reload(PatientsListBloc bloc) {
    if (Responsive.isDesktop(context) && bloc.currentPage > 0) {
      bloc.add(PatientsListEvent.goToPage(bloc.currentPage));
    } else {
      bloc.add(const PatientsListEvent.loadPatients());
    }
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
    _reload(bloc);
  }

  void _onScroll() {
    // The desktop table has page buttons; reaching the bottom there must
    // not append the next page underneath.
    if (Responsive.isDesktop(context)) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PatientsListBloc>().add(const PatientsListEvent.loadMore());
    }
  }

  /// Back to the top on every page change, so the new page is read from its
  /// first row rather than from wherever the last one was scrolled to.
  void _goToPage(int page) {
    context.read<PatientsListBloc>().add(PatientsListEvent.goToPage(page));
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _onRefresh() async {
    context.read<PatientsListBloc>().add(
      const PatientsListEvent.loadPatients(),
    );
    // Wait for the bloc to emit a non-loading state
    await context.read<PatientsListBloc>().stream.settled(
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

  void _onSearchChanged(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_searchDebounceDelay, () {
      if (!mounted) return;
      context.read<PatientsListBloc>().add(PatientsListEvent.search(query));
    });
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
            balanceCurrencyCode: e.balanceCurrencyCode,
            hasOpenCase: e.hasOpenCase,
            createdAt: e.createdAt,
          ),
        )
        .toList();
  }

  /// How recently a patient must have been added to count as "New"
  /// (`newFilter` / "الأحدث" - the newest).
  static const Duration _newPatientWindow = Duration(days: 30);

  /// Only the "New" chip is applied here. The name search is the server's
  /// job now - doing it locally meant filtering the rows that happened to be
  /// in memory, so a patient on page 3 of the roster could not be found.
  List<Patient> _applyFilters(List<Patient> patients) {
    if (_selectedFilterIndex != 1) return patients;

    // The chip used to filter `balance == 0`, which matched every patient
    // once the balance itself was always zero - the filter did nothing at
    // all. Both labels say recency, so recency is what it filters on.
    final cutoff = DateTime.now().subtract(_newPatientWindow);
    return patients
        .where((p) => p.createdAt != null && p.createdAt!.isAfter(cutoff))
        .toList();
  }

  /// Room for the floating tab bar at the foot of every scroll view here.
  /// This tab runs full-bleed - see `RootPage._fullBleedTabs`.
  double get _bottomInset => DentaNavBar.contentBottomInset(context);

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return _DesktopPatientsView(
        searchController: _searchController,
        scrollController: _scrollController,
        selectedFilterIndex: _selectedFilterIndex,
        onFilterChanged: (i) => setState(() => _selectedFilterIndex = i),
        // Sends the query to the server like the phone does; this only
        // rebuilt the page before, so typing on desktop searched nothing.
        onSearchChanged: () => _onSearchChanged(_searchController.text),
        onAddPatient: _navigateToAddPatient,
        onEditPatient: _onEditPatient,
        onDeletePatient: _onDeletePatient,
        mapToDisplay: _mapToDisplayModel,
        applyFilters: _applyFilters,
        onGoToPage: _goToPage,
      );
    }
    return _buildMobile(context);
  }

  Widget _buildMobile(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filters = [l10n.allFilter, l10n.newFilter];

    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      // Going full-bleed gives up the 8pt of top padding RootPage applies to
      // every unconverted tab. The header sits directly under the status bar,
      // so that gap is kept here rather than letting the conversion quietly
      // move the search field up. The bottom stays open - that is the point.
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: BlocBuilder<PatientsListBloc, PatientsListState>(
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
          // Live in every state: a search reloads through `loading`, and
          // keystrokes typed while it does must still reach the server.
          onSearchChanged: _onSearchChanged,
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
            padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, _bottomInset),
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
          onSearchChanged: _onSearchChanged,
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
          child: DentaRefresh(
            onRefresh: _onRefresh,
            child: filtered.isEmpty
                ? _buildEmptyState(l10n, allPatients.isEmpty)
                // Keeps only one row's swipe pane open at a time, matched by
                // PatientCard.groupTag.
                : SlidableAutoCloseBehavior(
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(
                            14.w,
                            0,
                            14.w,
                            _bottomInset,
                          ),
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
      padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, _bottomInset),
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
          // Live in every state: a search reloads through `loading`, and
          // keystrokes typed while it does must still reach the server.
          onSearchChanged: _onSearchChanged,
        ),
        Divider(height: 1, color: ColorManager.of(context).borderLight),
        Expanded(
          child: DentaRefresh(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, _bottomInset),
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

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP VIEW
// ═══════════════════════════════════════════════════════════════════════

class _DesktopPatientsView extends StatelessWidget {
  const _DesktopPatientsView({
    required this.searchController,
    required this.scrollController,
    required this.selectedFilterIndex,
    required this.onFilterChanged,
    required this.onSearchChanged,
    required this.onAddPatient,
    required this.onEditPatient,
    required this.onDeletePatient,
    required this.mapToDisplay,
    required this.applyFilters,
    required this.onGoToPage,
  });

  final TextEditingController searchController;
  final ScrollController scrollController;
  final int selectedFilterIndex;
  final ValueChanged<int> onFilterChanged;
  final VoidCallback onSearchChanged;
  final VoidCallback onAddPatient;
  final ValueChanged<Patient> onEditPatient;
  final ValueChanged<Patient> onDeletePatient;
  final List<Patient> Function(List<PatientEntity>) mapToDisplay;
  final List<Patient> Function(List<Patient>) applyFilters;
  final ValueChanged<int> onGoToPage;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: BlocBuilder<PatientsListBloc, PatientsListState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () =>
                _buildScaffold(context, patients: const [], isLoading: true),
            loaded: (entities, hasMore) => _buildScaffold(
              context,
              patients: mapToDisplay(entities),
              hasMore: hasMore,
            ),
            loadingMore: (entities) => _buildScaffold(
              context,
              patients: mapToDisplay(entities),
              isLoadingMore: true,
            ),
            error: (message) => _buildScaffold(
              context,
              patients: const [],
              errorMessage: message,
            ),
          );
        },
      ),
    );
  }

  Widget _buildScaffold(
    BuildContext context, {
    required List<Patient> patients,
    bool isLoading = false,
    bool isLoadingMore = false,
    bool hasMore = false,
    String? errorMessage,
  }) {
    final filtered = applyFilters(patients);
    final bloc = context.read<PatientsListBloc>();
    // The server's count across every page; the rows on screen are one page.
    final total = bloc.total ?? patients.length;

    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DesktopHeader(total: total, onAddPatient: onAddPatient),
          const SizedBox(height: 20),
          _DesktopStatsRow(patients: patients, total: total),
          const SizedBox(height: 20),
          _DesktopToolbar(
            searchController: searchController,
            onSearchChanged: onSearchChanged,
            selectedFilterIndex: selectedFilterIndex,
            onFilterChanged: onFilterChanged,
          ),
          const SizedBox(height: 16),
          if (errorMessage != null)
            _DesktopErrorState(message: errorMessage)
          else if (isLoading)
            const _DesktopLoadingTable()
          else if (filtered.isEmpty)
            _DesktopEmptyState(
              isCompletelyEmpty: patients.isEmpty,
              onAddPatient: onAddPatient,
            )
          else
            // Dimmed rather than replaced while the next page loads, so
            // the table does not collapse and jump on every click.
            AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: isLoadingMore ? 0.5 : 1,
              child: IgnorePointer(
                ignoring: isLoadingMore,
                child: _DesktopTable(
                  patients: filtered,
                  onEditPatient: onEditPatient,
                  onDeletePatient: onDeletePatient,
                ),
              ),
            ),
          // Shown even for a single page, so the table always says where
          // it stands; the buttons simply disable.
          if (errorMessage == null &&
              !isLoading &&
              filtered.isNotEmpty &&
              bloc.currentPage > 0) ...[
            const SizedBox(height: 16),
            DesktopPager(
              page: bloc.currentPage,
              lastPage: bloc.lastPage,
              isLoading: isLoadingMore,
              onGoToPage: onGoToPage,
            ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: HEADER
// ═══════════════════════════════════════════════════════════════════════

class _DesktopHeader extends StatelessWidget {
  const _DesktopHeader({required this.total, required this.onAddPatient});

  final int total;
  final VoidCallback onAddPatient;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final l10n = AppLocalizations.of(context)!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    l10n.patients,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: c.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 10,
                  //     vertical: 4,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: ColorManager.primary.withValues(alpha: 0.12),
                  //     borderRadius: BorderRadius.circular(999),
                  //   ),
                  //   child: Text(
                  //     '$total',
                  //     style: TextStyle(
                  //       fontFamily: fontFamily,
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.w700,
                  //       color: ColorManager.primary,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '$total ${l10n.total.toLowerCase()}',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
        ),
        DesktopPrimaryButton(
          icon: Icons.add,
          label: '${l10n.add} ${l10n.patient.toLowerCase()}',
          onPressed: onAddPatient,
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: STATS ROW
// ═══════════════════════════════════════════════════════════════════════

class _DesktopStatsRow extends StatelessWidget {
  const _DesktopStatsRow({required this.patients, required this.total});

  /// The page on screen. [total] is the server's count across all pages.
  final List<Patient> patients;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final withBalance = patients.where((p) => p.balance > 0).toList();
    final newPatients = patients.where((p) => p.balance == 0).length;
    final outstandingTotal = withBalance.fold<double>(
      0,
      (sum, p) => sum + p.balance,
    );

    final cards = [
      (
        icon: Icons.people_outline,
        color: ColorManager.primary,
        value: '$total',
        label: l10n.patients,
      ),
      (
        icon: Icons.auto_awesome_outlined,
        color: ColorManager.success,
        value: '$newPatients',
        label: l10n.newFilter,
      ),
      (
        icon: Icons.account_balance_wallet_outlined,
        color: ColorManager.warning,
        value: '\$${outstandingTotal.toInt()}',
        label: l10n.outstandingBalance,
      ),
    ];

    return Row(
      children: [
        for (var i = 0; i < cards.length; i++) ...[
          Expanded(
            child: _StatCard(
              icon: cards[i].icon,
              color: cards[i].color,
              value: cards[i].value,
              label: cards[i].label,
            ),
          ),
          if (i != cards.length - 1) const SizedBox(width: 14),
        ],
      ],
    );
  }
}

/// Icon beside the figure rather than above it - the appointments page's
/// card, so the two tabs match and the row stays short.
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: c.textPrimary,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12.5,
                    color: c.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: TOOLBAR
// ═══════════════════════════════════════════════════════════════════════

class _DesktopToolbar extends StatelessWidget {
  const _DesktopToolbar({
    required this.searchController,
    required this.onSearchChanged,
    required this.selectedFilterIndex,
    required this.onFilterChanged,
  });

  final TextEditingController searchController;
  final VoidCallback onSearchChanged;
  final int selectedFilterIndex;
  final ValueChanged<int> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final filters = [l10n.allFilter, l10n.newFilter];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        children: [
          // Search
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: c.inputBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: c.borderLight),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (_) => onSearchChanged(),
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13.5,
                  color: c.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: '${l10n.search} ${l10n.patients.toLowerCase()}...',
                  hintStyle: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 13.5,
                    color: c.textSubtle,
                  ),
                  prefixIcon: Icon(Icons.search, size: 18, color: c.textSubtle),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Filter pill group
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: c.inputBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: c.borderLight),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(filters.length, (i) {
                return _DesktopSegmentedButton(
                  label: filters[i],
                  isSelected: selectedFilterIndex == i,
                  onTap: () => onFilterChanged(i),
                  fontFamily: fontFamily,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopSegmentedButton extends StatelessWidget {
  const _DesktopSegmentedButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.fontFamily,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? ColorManager.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: ColorManager.primary.withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : c.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: TABLE
// ═══════════════════════════════════════════════════════════════════════

/// Column flexes and the reserved widths beside them, shared by the header
/// and every row so the two cannot drift apart the way two independently
/// laid-out Rows would.
class _PatientCols {
  const _PatientCols._();

  static const int patient = 4;
  static const int phone = 3;
  static const int registered = 2;
  static const int balance = 2;
  static const int openCase = 2;

  /// Reserved whether or not the row menu is visible, so names do not shift
  /// sideways as the pointer travels down the table.
  static const double actions = 44;
}

/// Which columns a given table width can carry, computed once per layout and
/// handed to the header, the rows and the skeleton alike. The patient cell is
/// never dropped - it is the thing being scanned for - and the rest go in
/// reverse order of how much they are needed at a glance.
class _VisibleCols {
  _VisibleCols(double w)
    : phone = w >= 620,
      balance = w >= 760,
      openCase = w >= 880,
      registered = w >= 1000;

  final bool phone;
  final bool registered;
  final bool balance;
  final bool openCase;
}

const double _tableRowHeight = 60;
const double _tableHeaderHeight = 44;
const EdgeInsets _tableCellPadding = EdgeInsets.symmetric(horizontal: 18);

class _DesktopTable extends StatelessWidget {
  const _DesktopTable({
    required this.patients,
    required this.onEditPatient,
    required this.onDeletePatient,
  });

  final List<Patient> patients;
  final ValueChanged<Patient> onEditPatient;
  final ValueChanged<Patient> onDeletePatient;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = _VisibleCols(constraints.maxWidth);

        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: c.borderLight),
          ),
          child: Column(
            children: [
              _TableHeader(cols: cols),
              for (var i = 0; i < patients.length; i++)
                _PatientRow(
                  key: ValueKey(patients[i].id),
                  patient: patients[i],
                  // The header already draws a rule beneath itself, so
                  // the first row must not add a second one.
                  topDivider: i > 0,
                  cols: cols,
                  onEdit: () => onEditPatient(patients[i]),
                  onDelete: () => onDeletePatient(patients[i]),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({required this.cols});

  final _VisibleCols cols;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    // Tracking pulls Arabic letters apart at their joins and casing is a
    // no-op there, so the small-caps treatment stays Latin-only.
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    final style = TextStyle(
      fontFamily: fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: c.textTertiary,
      letterSpacing: isRtl ? 0 : 0.6,
    );

    Widget cell(int flex, String label) => Expanded(
      flex: flex,
      child: Text(
        isRtl ? label : label.toUpperCase(),
        style: style,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );

    return Container(
      height: _tableHeaderHeight,
      padding: _tableCellPadding,
      decoration: BoxDecoration(
        color: c.cardBgSecondary,
        border: Border(bottom: BorderSide(color: c.borderLight)),
      ),
      child: Row(
        children: [
          cell(_PatientCols.patient, l10n.patientName),
          if (cols.phone) cell(_PatientCols.phone, l10n.phone),
          if (cols.registered)
            cell(_PatientCols.registered, l10n.patientRegisteredColumn),
          if (cols.balance)
            cell(_PatientCols.balance, l10n.outstandingBalance),
          if (cols.openCase)
            cell(_PatientCols.openCase, l10n.patientOpenCaseColumn),
          // Deliberately unlabelled: the row menu needs the width reserved,
          // not a heading over it.
          const SizedBox(width: _PatientCols.actions),
        ],
      ),
    );
  }
}

class _PatientRow extends StatefulWidget {
  const _PatientRow({
    super.key,
    required this.patient,
    required this.topDivider,
    required this.cols,
    required this.onEdit,
    required this.onDelete,
  });

  final Patient patient;
  final bool topDivider;
  final _VisibleCols cols;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  State<_PatientRow> createState() => _PatientRowState();
}

class _PatientRowState extends State<_PatientRow> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final p = widget.patient;
    final genderLabel = p.gender.toLowerCase() == 'female'
        ? l10n.female
        : l10n.male;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.pushNamed(
          AppRoutesNames.patientDetails,
          extra: <String, dynamic>{
            "patientId": p.id,
            "patientName": p.name,
            "tabIndex": 1,
          },
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          height: _tableRowHeight,
          padding: _tableCellPadding,
          decoration: BoxDecoration(
            color: _hovering
                ? ColorManager.primary.withValues(alpha: 0.05)
                : Colors.transparent,
            border: widget.topDivider
                ? Border(top: BorderSide(color: c.divider))
                : null,
          ),
          child: Row(
            children: [
              Expanded(
                flex: _PatientCols.patient,
                child: _identityCell(c, fontFamily, l10n, genderLabel),
              ),
              if (widget.cols.phone)
                Expanded(
                  flex: _PatientCols.phone,
                  child: p.phone.trim().isEmpty
                      ? _placeholder(c, fontFamily)
                      // Align puts the number at the column's own start
                      // edge; the LTR text direction only keeps its digits
                      // in order. With the direction alone, an RTL row drew
                      // the number at the column's far (left) edge, where
                      // it ran into the date beside it.
                      : Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            p.phone,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 13,
                              color: c.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                ),
              if (widget.cols.registered)
                Expanded(
                  flex: _PatientCols.registered,
                  child: _registeredCell(context, c, fontFamily),
                ),
              if (widget.cols.balance)
                Expanded(
                  flex: _PatientCols.balance,
                  child: _balanceCell(c, fontFamily),
                ),
              if (widget.cols.openCase)
                Expanded(
                  flex: _PatientCols.openCase,
                  child: _openCaseCell(c, fontFamily, l10n),
                ),
              SizedBox(
                width: _PatientCols.actions,
                child: _actionsCell(c, fontFamily, l10n),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _identityCell(
    AppColors c,
    String fontFamily,
    AppLocalizations l10n,
    String genderLabel,
  ) {
    final p = widget.patient;
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorManager.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorManager.primary.withValues(alpha: 0.22),
            ),
          ),
          child: Text(
            p.initials,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: ColorManager.primary,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                p.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                  letterSpacing: -0.1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                p.age > 0 ? '${p.age} ${l10n.years} • $genderLabel' : genderLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 11.5,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _registeredCell(
    BuildContext context,
    AppColors c,
    String fontFamily,
  ) {
    final created = widget.patient.createdAt;
    if (created == null) return _placeholder(c, fontFamily);

    final locale = Localizations.localeOf(context).toString();
    return Text(
      DateFormat('d MMM yyyy', locale).format(created.toLocal()),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12.5,
        color: c.textSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// A green pill for an open case; a plain muted "No" otherwise, so the
  /// eye lands only on the patients who are mid-treatment.
  Widget _openCaseCell(
    AppColors c,
    String fontFamily,
    AppLocalizations l10n,
  ) {
    if (!widget.patient.hasOpenCase) {
      return Text(
        l10n.no,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12.5,
          color: c.textSubtle,
        ),
      );
    }

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: ColorManager.success.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          l10n.yes,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: ColorManager.success,
          ),
        ),
      ),
    );
  }

  Widget _balanceCell(AppColors c, String fontFamily) {
    final balance = widget.patient.balance;
    if (balance <= 0) return _placeholder(c, fontFamily);

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: ColorManager.warning.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        // The case's own currency, never a hardcoded '$' - an SYP balance
        // was showing as dollars.
        child: Text(
          widget.patient.balanceLabel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: ColorManager.warning,
          ),
        ),
      ),
    );
  }

  /// An em dash rather than a blank cell, so an empty column still reads as
  /// "nothing recorded" instead of a rendering gap.
  Widget _placeholder(AppColors c, String fontFamily) => Text(
    '—',
    style: TextStyle(fontFamily: fontFamily, fontSize: 13, color: c.textSubtle),
  );

  Widget _actionsCell(AppColors c, String fontFamily, AppLocalizations l10n) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 120),
      opacity: _hovering ? 1 : 0,
      child: IgnorePointer(
        ignoring: !_hovering,
        child: PatientRowActionsMenu(
          onEdit: widget.onEdit,
          onDelete: widget.onDelete,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: LOADING / EMPTY / ERROR
// ═══════════════════════════════════════════════════════════════════════

/// The skeleton mirrors the table's own chrome - same header, same row
/// height - so nothing shifts when the real rows arrive.
class _DesktopLoadingTable extends StatelessWidget {
  const _DesktopLoadingTable();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = _VisibleCols(constraints.maxWidth);

        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: c.borderLight),
          ),
          child: Column(
            children: [
              _TableHeader(cols: cols),
              for (var i = 0; i < 6; i++)
                _ShimmerRow(topDivider: i > 0, cols: cols),
            ],
          ),
        );
      },
    );
  }
}

class _ShimmerRow extends StatelessWidget {
  const _ShimmerRow({required this.topDivider, required this.cols});

  final bool topDivider;
  final _VisibleCols cols;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return Container(
      height: _tableRowHeight,
      padding: _tableCellPadding,
      decoration: BoxDecoration(
        border: topDivider ? Border(top: BorderSide(color: c.divider)) : null,
      ),
      child: Row(
        children: [
          Expanded(
            flex: _PatientCols.patient,
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: c.shimmerBase,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _bar(c, 130, 11),
                      const SizedBox(height: 6),
                      _bar(c, 80, 9),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
          if (cols.phone)
            Expanded(flex: _PatientCols.phone, child: _bar(c, 110, 10)),
          if (cols.registered)
            Expanded(flex: _PatientCols.registered, child: _bar(c, 80, 10)),
          if (cols.balance)
            Expanded(flex: _PatientCols.balance, child: _bar(c, 54, 10)),
          if (cols.openCase)
            Expanded(flex: _PatientCols.openCase, child: _bar(c, 36, 10)),
          const SizedBox(width: _PatientCols.actions),
        ],
      ),
    );
  }

  Widget _bar(AppColors c, double w, double h) => Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      color: c.shimmerBase,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

class _DesktopEmptyState extends StatelessWidget {
  const _DesktopEmptyState({
    required this.isCompletelyEmpty,
    required this.onAddPatient,
  });

  final bool isCompletelyEmpty;
  final VoidCallback onAddPatient;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompletelyEmpty
                  ? Icons.person_add_outlined
                  : Icons.search_off_outlined,
              size: 30,
              color: ColorManager.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            isCompletelyEmpty ? l10n.noPatientsYet : l10n.noMatchingPatients,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            isCompletelyEmpty
                ? l10n.noPatientsYetDesc
                : l10n.noMatchingPatientsDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 13,
              color: c.textTertiary,
            ),
          ),
          if (isCompletelyEmpty) ...[
            const SizedBox(height: 20),
            DesktopPrimaryButton(
              icon: Icons.add,
              label: '${l10n.add} ${l10n.patient.toLowerCase()}',
              onPressed: onAddPatient,
            ),
          ],
        ],
      ),
    );
  }
}

class _DesktopErrorState extends StatelessWidget {
  const _DesktopErrorState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 32),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: ColorManager.error.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.error_outline,
              color: ColorManager.error,
              size: 28,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 13.5,
              color: c.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
