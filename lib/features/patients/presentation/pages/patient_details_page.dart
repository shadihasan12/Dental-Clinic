import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_overview_tab.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_history_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';

import '../widgets/details/widgets.dart';

class PatientDetailsPage extends StatefulWidget {
  final String patientId;

  const PatientDetailsPage({super.key, required this.patientId});

  @override
  State<PatientDetailsPage> createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Current case to display (either in-progress or selected from history)
  DentalCase? _displayedCase;
  bool _isViewingHistoryCase = false;

  // Mock data
  final _patient = const _MockPatient(
    id: '1',
    name: 'Sarah Johnson',
    age: 32,
    gender: 'Female',
    phone: '+963988026431',
    email: 'sarah.j@email.com',
    address: '123 Main St, New York, NY 10001',
    dateOfBirth: '1992-05-15',
    medicalHistory:
        'No known allergies. Previous dental work includes 2 fillings.',
    insuranceProvider: 'Delta Dental',
    insuranceNumber: 'DD-123456789',
    emergencyContact: 'John Johnson - (555) 987-6543',
  );

  // In-progress case (nullable)
  DentalCase? _currentCase;

  // Completed cases for history
  late List<DentalCase> _completedCases;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    _loadMockData();
  }

  void _onTabChanged() {
    // When switching away from Case tab, reset to current case
    if (_tabController.index != 1 && _isViewingHistoryCase) {
      setState(() {
        _displayedCase = _currentCase;
        _isViewingHistoryCase = false;
      });
    }
  }

  void _loadMockData() {
    // Set to null to test empty state, or uncomment to have a case
    _currentCase = null;

    // Uncomment below to test with an existing case
    _currentCase = DentalCase(
      id: '1',
      patientId: _patient.id,
      patientName: _patient.name,
      title: 'Root Canal Treatment',
      startDate: DateTime(2024, 11, 1),
      status: 'In Progress',
      totalCost: 1500,
      paidAmount: 1000,
      treatmentItems: [
        TreatmentItem(
          id: '3',
          description: 'Root canal completion and temporary crown',
          treatmentTypes: [TreatmentType.rootCanal, TreatmentType.crown],
          selectedTeeth: [14],
          attachments: [],
          createdAt: DateTime(2024, 11, 15),
          isDone: false,
        ),
      ],
    );

    // Completed cases
    _completedCases = [
      DentalCase(
        id: '2',
        patientId: _patient.id,
        patientName: _patient.name,
        title: 'Teeth Cleaning',
        startDate: DateTime(2024, 8, 15),
        endDate: DateTime(2024, 8, 15),
        status: 'Completed',
        totalCost: 200,
        paidAmount: 200,
        treatmentItems: [
          TreatmentItem(
            id: '10',
            description: 'Full teeth cleaning and polishing',
            treatmentTypes: [TreatmentType.cleaning],
            selectedTeeth: [],
            attachments: [],
            createdAt: DateTime(2024, 8, 15),
            completedAt: DateTime(2024, 8, 15),
            isDone: true,
          ),
        ],
      ),
      DentalCase(
        id: '3',
        patientId: _patient.id,
        patientName: _patient.name,
        title: 'Cavity Filling',
        startDate: DateTime(2024, 6, 10),
        endDate: DateTime(2024, 6, 20),
        status: 'Completed',
        totalCost: 350,
        paidAmount: 350,
        treatmentItems: [
          TreatmentItem(
            id: '20',
            description: 'Initial examination',
            treatmentTypes: [TreatmentType.consultation],
            selectedTeeth: [18, 19],
            attachments: [],
            createdAt: DateTime(2024, 6, 10),
            completedAt: DateTime(2024, 6, 10),
            isDone: true,
          ),
          TreatmentItem(
            id: '21',
            description: 'Filling procedure',
            treatmentTypes: [TreatmentType.filling],
            selectedTeeth: [18, 19],
            attachments: [],
            createdAt: DateTime(2024, 6, 20),
            completedAt: DateTime(2024, 6, 20),
            isDone: true,
          ),
        ],
      ),
    ];

    _displayedCase = _currentCase;
  }

  void _onHistoryCaseTap(DentalCase selectedCase) {
    setState(() {
      _displayedCase = selectedCase;
      _isViewingHistoryCase = true;
    });

    // Switch to Case tab
    _tabController.animateTo(1);
  }

  void _createNewCase() {
    // Create an empty case for the patient
    final newCase = DentalCase(
      id: '', // Will be generated by backend
      patientId: _patient.id,
      patientName: _patient.name,
      title: '',
      startDate: DateTime.now(),
      status: 'In Progress',
      totalCost: 0,
      paidAmount: 0,
      treatmentItems: [],
    );

    context.pushNamed(
      AppRoutesNames.addTreatment,
      extra: {
        'dentalCase': newCase,
        'isInitial': true,
      },
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      body: Column(
        children: [
          // Header with TabBar
          PatientHeader(
            name: _patient.name,
            age: _patient.age,
            gender: _patient.gender,
            phone: _patient.phone,
            onBackPressed: () => context.pop(),
            onEditPressed: () {
              // TODO: Navigate to edit patient
            },
            tabController: _tabController,
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Tab 1: Patient Info
                _buildInfoTab(),

                // Tab 2: Case
                _buildCaseTab(),

                // Tab 3: History
                CaseHistoryTab(
                  completedCases: _completedCases,
                  onCaseTap: _onHistoryCaseTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: PaddingManager.all16,
      child: PatientInfoTab(
        phone: _patient.phone,
        email: _patient.email,
        address: _patient.address,
        medicalHistory: _patient.medicalHistory,
        dateOfBirth: _patient.dateOfBirth,
        initiallyExpanded: true,
      ),
    );
  }

  Widget _buildCaseTab() {
    // If viewing history case, show it
    if (_isViewingHistoryCase && _displayedCase != null) {
      return CaseOverviewWidget(
        dentalCase: _displayedCase!,
        isReadOnly: true,
        onPaymentRecorded: () {
          setState(() {});
        },
      );
    }

    // If no current case, show empty state
    if (_currentCase == null) {
      return _buildNoCaseState();
    }

    // Show current case
    return CaseOverviewWidget(
      dentalCase: _currentCase!,
      isReadOnly: false,
      onPaymentRecorded: () {
        setState(() {});
      },
      onMarkAsFinished: () {
        _showMarkAsFinishedDialog();
      },
    );
  }

  Widget _buildNoCaseState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.medical_services_outlined,
                size: 40.w,
                color: ColorManager.primary,
              ),
            ),

            SizedBox(height: 24.h),

            // Title
            Text(
              'No Ongoing Case',
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w600,
                color: ColorManager.textPrimary,
              ),
            ),

            SizedBox(height: 8.h),

            // Description
            Text(
              'This patient doesn\'t have any active treatment case at the moment.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontFamily.geist,
                color: ColorManager.textSecondary,
              ),
            ),

            SizedBox(height: 32.h),

            // Create button
            GestureDetector(
              onTap: _createNewCase,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadiusManager.lg,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 20.w,
                      color: ColorManager.white,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Create New',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: FontFamily.geist,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMarkAsFinishedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Mark as Finished',
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: FontFamily.geist,
            fontWeight: FontWeight.w600,
            color: ColorManager.textPrimary,
          ),
        ),
        content: Text(
          'Are you sure you want to mark this case as finished?',
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontFamily.geist,
            fontWeight: FontWeight.w400,
            color: ColorManager.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w500,
                color: ColorManager.textPrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                // Move current case to completed
                if (_currentCase != null) {
                  final completedCase = _currentCase!.copyWith(
                    status: 'Completed',
                    endDate: DateTime.now(),
                  );
                  _completedCases.insert(0, completedCase);
                  _currentCase = null;
                  _displayedCase = null;
                }
              });
            },
            child: Text(
              'Confirm',
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontFamily.geist,
                fontWeight: FontWeight.w500,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Mock class
class _MockPatient {
  final String id, name, gender, phone, email, address, dateOfBirth;
  final String medicalHistory,
      insuranceProvider,
      insuranceNumber,
      emergencyContact;
  final int age;

  const _MockPatient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.address,
    required this.dateOfBirth,
    required this.medicalHistory,
    required this.insuranceProvider,
    required this.insuranceNumber,
    required this.emergencyContact,
  });
}