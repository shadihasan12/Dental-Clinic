import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/presentation/manager/list_patients/patients_list_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/injection.dart';
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
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
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
    await context.read<PatientsListBloc>().stream.firstWhere(
      (state) => state.maybeWhen(loading: () => false, orElse: () => true),
    );
  }

  Future<void> _navigateToAddPatient() async {
    await context.pushNamed(AppRoutesNames.addPatient);
    if (mounted) {
      context.read<PatientsListBloc>().add(
        const PatientsListEvent.loadPatients(),
      );
    }
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

    if (_selectedFilterIndex == 1) {
      filtered = filtered.where((p) => p.balance == 0).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return _DesktopPatientsView(
        searchController: _searchController,
        scrollController: _scrollController,
        selectedFilterIndex: _selectedFilterIndex,
        onFilterChanged: (i) => setState(() => _selectedFilterIndex = i),
        onSearchChanged: () => setState(() {}),
        onAddPatient: _navigateToAddPatient,
        mapToDisplay: _mapToDisplayModel,
        applyFilters: _applyFilters,
      );
    }
    return _MobilePatientsView(
      searchController: _searchController,
      scrollController: _scrollController,
      selectedFilterIndex: _selectedFilterIndex,
      onFilterChanged: (i) => setState(() => _selectedFilterIndex = i),
      onSearchChanged: () => setState(() {}),
      onAddPatient: _navigateToAddPatient,
      onRefresh: _onRefresh,
      mapToDisplay: _mapToDisplayModel,
      applyFilters: _applyFilters,
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
    required this.mapToDisplay,
    required this.applyFilters,
  });

  final TextEditingController searchController;
  final ScrollController scrollController;
  final int selectedFilterIndex;
  final ValueChanged<int> onFilterChanged;
  final VoidCallback onSearchChanged;
  final VoidCallback onAddPatient;
  final List<Patient> Function(List<PatientEntity>) mapToDisplay;
  final List<Patient> Function(List<Patient>) applyFilters;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: BlocBuilder<PatientsListBloc, PatientsListState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => _buildScaffold(
              context,
              patients: const [],
              isLoading: true,
            ),
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

    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DesktopHeader(
            total: patients.length,
            onAddPatient: onAddPatient,
          ),
          const SizedBox(height: 20),
          _DesktopStatsRow(patients: patients),
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
            const _DesktopLoadingGrid()
          else if (filtered.isEmpty)
            _DesktopEmptyState(
              isCompletelyEmpty: patients.isEmpty,
              onAddPatient: onAddPatient,
            )
          else
            _DesktopGrid(
              patients: filtered,
              showLoader: hasMore || isLoadingMore,
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: HEADER
// ═══════════════════════════════════════════════════════════════════════

class _DesktopHeader extends StatelessWidget {
  const _DesktopHeader({
    required this.total,
    required this.onAddPatient,
  });

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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '$total',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
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
        _DesktopPrimaryButton(
          icon: Icons.add,
          label: '${l10n.add} ${l10n.patient.toLowerCase()}',
          onTap: onAddPatient,
        ),
      ],
    );
  }
}

class _DesktopPrimaryButton extends StatefulWidget {
  const _DesktopPrimaryButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  State<_DesktopPrimaryButton> createState() => _DesktopPrimaryButtonState();
}

class _DesktopPrimaryButtonState extends State<_DesktopPrimaryButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final fontFamily = FontHelper.fontFamily(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: _hovering
                ? ColorManager.primaryDark
                : ColorManager.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: ColorManager.primary.withValues(
                  alpha: _hovering ? 0.35 : 0.18,
                ),
                blurRadius: _hovering ? 14 : 8,
                offset: Offset(0, _hovering ? 6 : 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: STATS ROW
// ═══════════════════════════════════════════════════════════════════════

class _DesktopStatsRow extends StatelessWidget {
  const _DesktopStatsRow({required this.patients});

  final List<Patient> patients;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final withBalance = patients.where((p) => p.balance > 0).toList();
    final upcoming = patients.where((p) => p.nextVisit != null).length;
    final newPatients = patients.where((p) => p.balance == 0).length;
    final outstandingTotal =
        withBalance.fold<double>(0, (sum, p) => sum + p.balance);

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.people_outline,
            iconColor: ColorManager.primary,
            iconBg: ColorManager.primary.withValues(alpha: 0.12),
            value: '${patients.length}',
            label: l10n.patients,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _StatCard(
            icon: Icons.auto_awesome_outlined,
            iconColor: ColorManager.success,
            iconBg: ColorManager.success.withValues(alpha: 0.12),
            value: '$newPatients',
            label: l10n.newFilter,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _StatCard(
            icon: Icons.account_balance_wallet_outlined,
            iconColor: ColorManager.warning,
            iconBg: ColorManager.warning.withValues(alpha: 0.12),
            value: '\$${outstandingTotal.toInt()}',
            label: l10n.outstandingBalance,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _StatCard(
            icon: Icons.calendar_today_outlined,
            iconColor: const Color(0xFF3B82F6),
            iconBg: const Color(0xFF3B82F6).withValues(alpha: 0.12),
            value: '$upcoming',
            label: l10n.nextVisit,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: c.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 12.5,
              color: c.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
                  hintText:
                      '${l10n.search} ${l10n.patients.toLowerCase()}...',
                  hintStyle: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 13.5,
                    color: c.textSubtle,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18,
                    color: c.textSubtle,
                  ),
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
// DESKTOP: GRID
// ═══════════════════════════════════════════════════════════════════════

class _DesktopGrid extends StatelessWidget {
  const _DesktopGrid({required this.patients, required this.showLoader});

  final List<Patient> patients;
  final bool showLoader;

  int _crossAxisCount(double width) {
    if (width >= 1600) return 4;
    if (width >= 1200) return 3;
    if (width >= 900) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = _crossAxisCount(constraints.maxWidth);
        return Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: patients.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                mainAxisExtent: 190,
              ),
              itemBuilder: (context, index) {
                final patient = patients[index];
                return PatientCardDesktop(
                  patient: patient,
                  onTap: () => context.pushNamed(
                    AppRoutesNames.patientDetails,
                    extra: <String, dynamic>{
                      "patientId": patient.id,
                      "patientName": patient.name,
                      "tabIndex": 1,
                    },
                  ),
                );
              },
            ),
            if (showLoader)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: ColorManager.primary,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: LOADING / EMPTY / ERROR
// ═══════════════════════════════════════════════════════════════════════

class _DesktopLoadingGrid extends StatelessWidget {
  const _DesktopLoadingGrid();

  int _crossAxisCount(double width) {
    if (width >= 1600) return 4;
    if (width >= 1200) return 3;
    if (width >= 900) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = _crossAxisCount(constraints.maxWidth);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            mainAxisExtent: 190,
          ),
          itemBuilder: (_, _) => const _DesktopShimmerCard(),
        );
      },
    );
  }
}

class _DesktopShimmerCard extends StatelessWidget {
  const _DesktopShimmerCard();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: c.shimmerBase,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmerBar(c, 120, 12),
                    const SizedBox(height: 8),
                    _shimmerBar(c, 80, 10),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _shimmerBar(c, 140, 10),
          const SizedBox(height: 16),
          _shimmerBar(c, 180, 10),
        ],
      ),
    );
  }

  Widget _shimmerBar(AppColors c, double w, double h) => Container(
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
            _DesktopPrimaryButton(
              icon: Icons.add,
              label: '${l10n.add} ${l10n.patient.toLowerCase()}',
              onTap: onAddPatient,
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

// ═══════════════════════════════════════════════════════════════════════
// MOBILE VIEW (original layout preserved)
// ═══════════════════════════════════════════════════════════════════════

class _MobilePatientsView extends StatelessWidget {
  const _MobilePatientsView({
    required this.searchController,
    required this.scrollController,
    required this.selectedFilterIndex,
    required this.onFilterChanged,
    required this.onSearchChanged,
    required this.onAddPatient,
    required this.onRefresh,
    required this.mapToDisplay,
    required this.applyFilters,
  });

  final TextEditingController searchController;
  final ScrollController scrollController;
  final int selectedFilterIndex;
  final ValueChanged<int> onFilterChanged;
  final VoidCallback onSearchChanged;
  final VoidCallback onAddPatient;
  final Future<void> Function() onRefresh;
  final List<Patient> Function(List<PatientEntity>) mapToDisplay;
  final List<Patient> Function(List<Patient>) applyFilters;

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
            loading: () => _buildLoading(context, l10n, filters),
            loaded: (entities, hasMore) => _buildLoaded(
              context,
              l10n,
              filters,
              mapToDisplay(entities),
              hasMore: hasMore,
            ),
            loadingMore: (entities) => _buildLoaded(
              context,
              l10n,
              filters,
              mapToDisplay(entities),
              isLoadingMore: true,
            ),
            error: (message) => _buildError(context, l10n, filters, message),
          );
        },
      ),
    );
  }

  Widget _buildLoading(
    BuildContext context,
    AppLocalizations l10n,
    List<String> filters,
  ) {
    return Column(
      children: [
        PatientsListHeader(
          patientCount: 0,
          searchController: searchController,
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
            itemCount: 5,
            itemBuilder: (_, __) => _MobileShimmerCard(),
          ),
        ),
      ],
    );
  }

  Widget _buildLoaded(
    BuildContext context,
    AppLocalizations l10n,
    List<String> filters,
    List<Patient> allPatients, {
    bool hasMore = false,
    bool isLoadingMore = false,
  }) {
    final filtered = applyFilters(allPatients);

    return Column(
      children: [
        PatientsListHeader(
          patientCount: allPatients.length,
          searchController: searchController,
          onAddTap: onAddPatient,
          onSearchChanged: (_) => onSearchChanged(),
        ),
        Divider(height: 1, color: ColorManager.of(context).divider),
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
          child: PatientFilterChips(
            filters: filters,
            selectedFilter: filters[selectedFilterIndex],
            onFilterSelected: (filter) =>
                onFilterChanged(filters.indexOf(filter)),
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? _buildEmptyState(context, l10n, allPatients.isEmpty)
              : _buildMobileList(
                  context, filtered, isLoadingMore || hasMore),
        ),
      ],
    );
  }

  Widget _buildMobileList(
    BuildContext context,
    List<Patient> filtered,
    bool showLoader,
  ) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        CupertinoSliverRefreshControl(onRefresh: onRefresh),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          sliver: SliverList.separated(
            itemCount: filtered.length + (showLoader ? 1 : 0),
            separatorBuilder: (_, __) =>
                Divider(height: 1, color: ColorManager.of(context).divider),
            itemBuilder: (context, index) {
              if (index == filtered.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Center(
                    child: SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
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
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    AppLocalizations l10n,
    bool isCompletelyEmpty,
  ) {
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
              onTap: onAddPatient,
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

  Widget _buildError(
    BuildContext context,
    AppLocalizations l10n,
    List<String> filters,
    String message,
  ) {
    return Column(
      children: [
        PatientsListHeader(
          patientCount: 0,
          searchController: searchController,
          onAddTap: onAddPatient,
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
                  Icon(Icons.error_outline,
                      size: 48.w,
                      color: ColorManager.of(context).textTertiary),
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

// ═══════════════════════════════════════════════════════════════════════
// MOBILE SHIMMER
// ═══════════════════════════════════════════════════════════════════════

class _MobileShimmerCard extends StatelessWidget {
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
      child: Row(
        children: [
          _shimmerBox(context, 52.w, 52.w, isCircle: true),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(context, 140.w, 14.h),
                SizedBox(height: 8.h),
                _shimmerBox(context, 100.w, 10.h),
                SizedBox(height: 8.h),
                _shimmerBox(context, 120.w, 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox(
    BuildContext context,
    double width,
    double height, {
    bool isCircle = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ColorManager.of(context).divider,
        borderRadius: isCircle ? null : BorderRadius.circular(6.r),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}
