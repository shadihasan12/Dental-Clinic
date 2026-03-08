import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/resources.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/payment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_payment_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_core_treatments_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_teeth_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_payments_use_case.dart';
import 'package:dental_clinic_app/features/patients/presentation/manager/patient_details/patient_details_bloc.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_history_tab.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_overview_tab.dart';
import 'package:dental_clinic_app/features/treatment_plan_prototype/models/prototype_models.dart';
import 'package:dental_clinic_app/features/treatment_plan_prototype/pages/treatment_plan_view_page.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../widgets/details/widgets.dart';

class PatientDetailsPage extends StatelessWidget {
  final String patientId;
  final String patientName;
  final int? tabIndex;
  final TreatmentPlan? prototypePlan;

  const PatientDetailsPage({
    super.key,
    required this.patientId,
    required this.patientName,
    this.tabIndex,
    this.prototypePlan,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<PatientDetailsBloc>()
            ..add(PatientDetailsEvent.loadPatientDetails(patientId)),
      child: _PatientDetailsContent(
        patientId: patientId,
        tabIndex: tabIndex,
        patientName: patientName,
        prototypePlan: prototypePlan,
      ),
    );
  }
}

class _PatientDetailsContent extends StatefulWidget {
  final String patientId;
  final int? tabIndex;
  final String patientName;
  final TreatmentPlan? prototypePlan;

  const _PatientDetailsContent({
    required this.patientId,
    this.tabIndex,
    required this.patientName,
    this.prototypePlan,
  });

  @override
  State<_PatientDetailsContent> createState() => _PatientDetailsContentState();
}

class _PatientDetailsContentState extends State<_PatientDetailsContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // UI-only state: which case is currently displayed in the Case tab
  DentalCase? _displayedCase;
  bool _isViewingHistoryCase = false;
  List<Tooth> _teeth = [];
  List<CoreTreatment> _coreTreatments = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.tabIndex ?? 0,
    );
    _tabController.addListener(_onTabChanged);
    _loadTeeth();
    _loadCoreTreatments();
  }

  Future<void> _loadTeeth() async {
    final result = await getIt<GetAllTeethUseCase>()(NoParams());
    result.fold(
      (_) {},
      (teeth) => setState(() => _teeth = teeth),
    );
  }

  Future<void> _loadCoreTreatments() async {
    final result = await getIt<GetAllCoreTreatmentsUseCase>()(NoParams());
    result.fold(
      (_) {},
      (treatments) => setState(() => _coreTreatments = treatments),
    );
  }

  void _onTabChanged() {
    if (_tabController.index != 1 && _isViewingHistoryCase) {
      final activeCase = context.read<PatientDetailsBloc>().state.mapOrNull(
        loaded: (s) => s.activeCase,
      );
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
      extra: {
        'patientId': widget.patientId,
        'patientName': widget.patientName,
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
          initial: () => const Scaffold(body: SizedBox.shrink()),
          loading: () => Scaffold(
                backgroundColor: ColorManager.scaffoldBackground,
                body: Column(
                  children: [
                    PatientHeader(
                      name: widget.patientName,
                      onBackPressed: () => context.pop(),
                      tabController: _tabController,
                    ),
                    const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
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

  Future<List<Payment>> _loadPayments(String caseId) async {
    final result = await getIt<GetPaymentsUseCase>()(
      GetPaymentsParams(patientId: widget.patientId, caseId: caseId),
    );
    return result.fold((_) => [], (payments) => payments);
  }

  Widget _buildCaseTab(DentalCase? activeCase) {
    if (_isViewingHistoryCase && _displayedCase != null) {
      return CaseOverviewWidget(
        dentalCase: _displayedCase!,
        teeth: _teeth,
        coreTreatments: _coreTreatments,
        isReadOnly: true,
        onLoadPayments: () => _loadPayments(_displayedCase!.id),
      );
    }

    if (activeCase == null && widget.prototypePlan != null) {
      return TreatmentPlanViewPage(
        plan: widget.prototypePlan!,
        embedded: true,
      );
    }

    if (activeCase == null) {
      return _buildNoCaseState();
    }

    return CaseOverviewWidget(
      dentalCase: activeCase,
      teeth: _teeth,
      coreTreatments: _coreTreatments,
      isReadOnly: false,
      onPaymentRecorded: (amount, notes) async {
        final result = await getIt<AddPaymentUseCase>()(
          AddPaymentParams(
            patientId: widget.patientId,
            caseId: activeCase.id,
            amount: amount,
            notes: notes,
          ),
        );
        final error = result.fold<NetworkExceptions?>(
          (l) => l,
          (_) => null,
        );
        if (error != null) {
          throw Exception(NetworkExceptions.getErrorMessage(error));
        }
        if (mounted) {
          context.read<PatientDetailsBloc>().add(
            PatientDetailsEvent.loadPatientDetails(widget.patientId),
          );
        }
      },
      onLoadPayments: () => _loadPayments(activeCase.id),
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
    final activeCase = context.read<PatientDetailsBloc>().state.mapOrNull(
      loaded: (s) => s.activeCase,
    );
    if (activeCase == null) return;

    final titleController = TextEditingController();

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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.markCaseFinishedQuestion,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w400,
                color: ColorManager.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: l10n.caseTitleOptional,
                hintText: l10n.caseTitleHint,
                labelStyle: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.textSecondary,
                ),
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.textTertiary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.borderLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.primary),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 10.h,
                ),
              ),
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.textPrimary,
              ),
            ),
          ],
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
              final title = titleController.text.trim();
              Navigator.pop(dialogContext);
              context.read<PatientDetailsBloc>().add(
                PatientDetailsEvent.markCaseAsFinished(
                  patientId: widget.patientId,
                  caseId: activeCase.id,
                  title: title.isEmpty ? null : title,
                ),
              );
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
