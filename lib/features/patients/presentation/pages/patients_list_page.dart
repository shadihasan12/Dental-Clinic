import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import '../widgets/widgets.dart';

class PatientsListPage extends StatefulWidget {
  const PatientsListPage({super.key});

  @override
  State<PatientsListPage> createState() => _PatientsListPageState();
}

class _PatientsListPageState extends State<PatientsListPage> {
  final _searchController = TextEditingController();
  late String _selectedFilter;

  late List<String> _filters;

  final List<Patient> _patients = const [
    Patient(id: '1', name: 'Sarah Johnson', age: 32, gender: 'Female', phone: '(555) 123-4567', nextVisit: '12/28/2024', balance: 0),
    Patient(id: '2', name: 'Michael Brown', age: 45, gender: 'Male', phone: '(555) 234-5678', nextVisit: '12/22/2024', balance: 250),
    Patient(id: '3', name: 'Emma Wilson', age: 28, gender: 'Female', phone: '(555) 345-6789', nextVisit: null, balance: 0),
    Patient(id: '4', name: 'James Davis', age: 56, gender: 'Male', phone: '(555) 456-7890', nextVisit: null, balance: 180),
    Patient(id: '5', name: 'Lisa Anderson', age: 39, gender: 'Female', phone: '(555) 567-8901', nextVisit: '01/05/2025', balance: 0),
    Patient(id: '6', name: 'Robert Taylor', age: 62, gender: 'Male', phone: '(555) 678-9012', nextVisit: '01/10/2025', balance: 320),
  ];

  @override
  void initState() {
    super.initState();
    _filters = [];
    _selectedFilter = '';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Initialize filters on first build
    if (_filters.isEmpty) {
      _filters = [l10n.allFilter, l10n.newFilter];
      _selectedFilter = _filters[0];
    }
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          PatientsListHeader(
            patientCount: _patients.length,
            searchController: _searchController,
            onAddTap: () => context.pushNamed(AppRoutesNames.addPatient),
            onSearchChanged: (_) => setState(() {}),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
            child: PatientFilterChips(
              filters: _filters,
              selectedFilter: _selectedFilter,
              onFilterSelected: (filter) =>
                  setState(() => _selectedFilter = filter),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: _patients.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Colors.grey.shade100),
              itemBuilder: (context, index) {
                final patient = _patients[index];
                return PatientCard(
                  patient: patient,
                  onTap: () => context.pushNamed(
                    AppRoutesNames.patientDetails,
                    extra: {"patientId": patient.id},
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