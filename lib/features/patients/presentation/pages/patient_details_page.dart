import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/core/resources/resources.dart';
import 'package:dental_clinic_app/features/patients/data/data_sources/patient_remote_data_source.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/data/repositories/patient_repository_impl.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_patient_cases_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_patient_details_use_case.dart';
import 'package:dental_clinic_app/features/patients/presentation/manager/patient_details_bloc.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_history_tab.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_overview_tab.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';

import '../widgets/details/widgets.dart';

class PatientDetailsPage extends StatelessWidget {
  final String patientId;
  final int? tabIndex;

  const PatientDetailsPage({
    super.key,
    required this.patientId,
    this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    final repository = PatientRepositoryImpl(
      PatientRemoteDataSourceImpl(getIt<ApiConsumer>()),
    );

    return BlocProvider(
      create: (context) => PatientDetailsBloc(
        getPatientDetails: GetPatientDetailsUseCase(repository),
        getPatientCases: GetPatientCasesUseCase(repository),
      )..add(PatientDetailsEvent.loadPatientDetails(patientId)),
      child: _PatientDetailsContent(tabIndex: tabIndex),
    );
  }
}

class _PatientDetailsContent extends StatefulWidget {
  final int? tabIndex;

  const _PatientDetailsContent({this.tabIndex});

  @override
  State<_PatientDetailsContent> createState() => _PatientDetailsContentState();
}

class _PatientDetailsContentState extends State<_PatientDetailsContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // UI-only state: which case is currently displayed in the Case tab
  DentalCase? _displayedCase;
  bool _isViewingHistoryCase = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.tabIndex ?? 0,
    );
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.index != 1 && _isViewingHistoryCase) {
      final activeCase = context
          .read<PatientDetailsBloc>()
          .state
          .mapOrNull(loaded: (s) => s.activeCase);
      setState(() {
        _displayedCase = activeCase;
        _isViewingHistoryCase = false;
      });
    }
  }

  void _onHistoryCaseTap(DentalCase selectedCase) {
    setState(() {
      _displayedCase = selectedCase;
      _isViewingHistoryCase = true;
    });
    _tabController.animateTo(1);
  }

  void _createNewCase() {
    context.pushNamed(
      AppRoutesNames.addTreatment,
      extra: {'caseId': 1234, 'isInitial': true},
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
    return BlocConsumer<PatientDetailsBloc, PatientDetailsState>(
      listener: (context, state) {
        // Sync _displayedCase whenever the loaded state arrives
        state.mapOrNull(
          loaded: (s) {
            if (!_isViewingHistoryCase) {
              setState(() => _displayedCase = s.activeCase);
            }
          },
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => const Scaffold(
            body: SizedBox.shrink(),
          ),
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (message) => Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ),
            ),
          ),
          loaded: (patient, activeCase, completedCases) {
            return Scaffold(
              backgroundColor: ColorManager.scaffoldBackground,
              body: Column(
                children: [
                  PatientHeader(
                    name: patient.name,
                    onBackPressed: () => context.pop(),
                    onEditPressed: () {
                      // TODO: Navigate to edit patient
                    },
                    tabController: _tabController,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Tab 1: Patient Info
                        SingleChildScrollView(
                          padding: PaddingManager.all16,
                          child: PatientInfoTab(
                            phone: patient.phone,
                            email: patient.email,
                            address: patient.address,
                            medicalHistory: patient.medicalHistory ?? '',
                            dateOfBirth: patient.dateOfBirth
                                .toIso8601String()
                                .substring(0, 10),
                            allergies: 'None',
                            age: patient.age,
                            gender: patient.gender,
                            initiallyExpanded: true,
                          ),
                        ),

                        // Tab 2: Case
                        _buildCaseTab(activeCase),

                        // Tab 3: History
                        CaseHistoryTab(
                          completedCases: completedCases,
                          onCaseTap: _onHistoryCaseTap,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCaseTab(DentalCase? activeCase) {
    if (_isViewingHistoryCase && _displayedCase != null) {
      return CaseOverviewWidget(
        dentalCase: _displayedCase!,
        isReadOnly: true,
        onPaymentRecorded: () => setState(() {}),
      );
    }

    if (activeCase == null) {
      return _buildNoCaseState();
    }

    return CaseOverviewWidget(
      dentalCase: activeCase,
      isReadOnly: false,
      onPaymentRecorded: () => setState(() {}),
      onMarkAsFinished: () => _showMarkAsFinishedDialog(),
    );
  }

  Widget _buildNoCaseState() {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Text(
              l10n.noOngoingCase,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
                color: ColorManager.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.patientNoActiveTreatment,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.textSecondary,
              ),
            ),
            SizedBox(height: 32.h),
            GestureDetector(
              onTap: _createNewCase,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
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
                      l10n.createNew,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: FontHelper.fontFamily(context),
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
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          l10n.markAsFinished,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w600,
            color: ColorManager.textPrimary,
          ),
        ),
        content: Text(
          l10n.markCaseFinishedQuestion,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w400,
            color: ColorManager.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              l10n.cancel,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w500,
                color: ColorManager.textPrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context
                  .read<PatientDetailsBloc>()
                  .add(const PatientDetailsEvent.markCaseAsFinished());
            },
            child: Text(
              l10n.confirm,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
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
