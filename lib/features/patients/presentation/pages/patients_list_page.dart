import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/features/patients/presentation/manager/list_patients/patients_list_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
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
      create: (_) => getIt<PatientsListBloc>()..add(const PatientsListEvent.loadPatients()),
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
  int _selectedFilterIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
      backgroundColor: Colors.white,
      body: BlocBuilder<PatientsListBloc, PatientsListState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => _buildLoading(l10n, filters),
            loaded: (entities) =>
                _buildLoaded(l10n, filters, _mapToDisplayModel(entities)),
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
        Divider(height: 1, color: Colors.grey.shade200),
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
            itemBuilder: (_, _) => _ShimmerCard(),
          ),
        ),
      ],
    );
  }

  // ─── Loaded list ───────────────────────────────────────────────────────

  Widget _buildLoaded(
    AppLocalizations l10n,
    List<String> filters,
    List<Patient> allPatients,
  ) {
    final filtered = _applyFilters(allPatients);

    return Column(
      children: [
        PatientsListHeader(
          patientCount: allPatients.length,
          searchController: _searchController,
          onAddTap: () => context.pushNamed(AppRoutesNames.addPatient),
          onSearchChanged: (_) => setState(() {}),
        ),
        Divider(height: 1, color: Colors.grey.shade200),
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
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: filtered.length,
            separatorBuilder: (_, _) =>
                Divider(height: 1, color: Colors.grey.shade100),
            itemBuilder: (context, index) {
              final patient = filtered[index];
              return PatientCard(
                patient: patient,
                onTap: () => context.pushNamed(
                  AppRoutesNames.patientDetails,
                  extra: {
                    "patientId": patient.id,
                    "patientName": patient.name,
                  },
                ),
              );
            },
          ),
        ),
      ],
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
          onAddTap: () => context.pushNamed(AppRoutesNames.addPatient),
          onSearchChanged: (_) {},
        ),
        Divider(height: 1, color: Colors.grey.shade200),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 48.w, color: Colors.grey),
                SizedBox(height: 12.h),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Shimmer placeholder card ──────────────────────────────────────────────

class _ShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
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
          _shimmerBox(52.w, 52.w, isCircle: true),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(140.w, 14.h),
                SizedBox(height: 8.h),
                _shimmerBox(100.w, 10.h),
                SizedBox(height: 8.h),
                _shimmerBox(120.w, 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox(double width, double height, {bool isCircle = false}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: isCircle ? null : BorderRadius.circular(6.r),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}
