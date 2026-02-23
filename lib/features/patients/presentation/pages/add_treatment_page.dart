import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_treatment_use_case.dart';
import 'package:dental_clinic_app/features/patients/presentation/manager/add_treatment/add_treatment_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import '../widgets/widgets.dart';

class AddTreatmentPage extends StatelessWidget {
  const AddTreatmentPage({
    super.key,
    required this.patientId,
    this.isInitial = false,
  });

  final String patientId;
  final bool isInitial;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddTreatmentBloc>(),
      child: _AddTreatmentContent(
        patientId: patientId,
        isInitial: isInitial,
      ),
    );
  }
}

class _AddTreatmentContent extends StatefulWidget {
  const _AddTreatmentContent({
    required this.patientId,
    required this.isInitial,
  });

  final String patientId;
  final bool isInitial;

  @override
  State<_AddTreatmentContent> createState() => _AddTreatmentContentState();
}

class _AddTreatmentContentState extends State<_AddTreatmentContent> {
  DateTime _visitDate = DateTime.now();
  final List<String> _selectedTreatmentTypes = [];
  final _visitSummaryController = TextEditingController();
  final _totalCostController = TextEditingController();
  final _labFeesController = TextEditingController();
  List<int> _selectedTeeth = [];
  final List<String> _attachments = [];

  /// Fixed mapping from form index → TreatmentType enum.
  static const _treatmentTypeMap = [
    TreatmentType.cleaning,
    TreatmentType.filling,
    TreatmentType.rootCanal,
    TreatmentType.extraction,
    TreatmentType.crown,
    TreatmentType.implant,
    TreatmentType.whitening,
    TreatmentType.veneer,
  ];

  List<String> _getLocalizedTreatmentTypes(AppLocalizations l10n) {
    return [
      l10n.cleaning,
      l10n.filling,
      l10n.rootCanal,
      l10n.extraction,
      l10n.crown,
      l10n.implant,
      l10n.whitening,
      l10n.veneer,
    ];
  }

  @override
  void dispose() {
    _visitSummaryController.dispose();
    _totalCostController.dispose();
    _labFeesController.dispose();
    super.dispose();
  }

  void _saveTreatment() {
    final localizedTypes = _getLocalizedTreatmentTypes(
      AppLocalizations.of(context)!,
    );

    // Map selected localized labels → TreatmentType enums
    final selectedEnums = <TreatmentType>[];
    for (final label in _selectedTreatmentTypes) {
      final index = localizedTypes.indexOf(label);
      if (index >= 0 && index < _treatmentTypeMap.length) {
        selectedEnums.add(_treatmentTypeMap[index]);
      }
    }

    final params = AddTreatmentParams(
      patientId: widget.patientId,
      visitDate: _visitDate,
      treatmentTypes: selectedEnums,
      selectedTeeth: _selectedTeeth,
      summary: _visitSummaryController.text.trim(),
      totalCost: double.tryParse(_totalCostController.text) ?? 0,
      labFees: double.tryParse(_labFeesController.text) ?? 0,
      attachments: _attachments,
    );

    context.read<AddTreatmentBloc>().add(AddTreatmentEvent.submit(params));
  }

  Future<void> _selectDate() async {
    final l10n = AppLocalizations.of(context)!;
    DateTime tempDate = _visitDate;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => SizedBox(
        height: 300.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      l10n.cancel,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.sp,
                        fontFamily: FontHelper.fontFamily(context),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() => _visitDate = tempDate);
                      Navigator.pop(context);
                    },
                    child: Text(
                      l10n.close,
                      style: TextStyle(
                        color: const Color(0xFF70B2B2),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontHelper.fontFamily(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _visitDate,
                minimumDate: DateTime(2020),
                maximumDate: DateTime.now().add(const Duration(days: 365)),
                onDateTimeChanged: (date) => tempDate = date,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BlocListener<AddTreatmentBloc, AddTreatmentState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          saving: () {
            AppLoadingDialog.show(
              context: context,
              message: localizations.savingTreatment,
            );
          },
          success: (_) {
            AppLoadingDialog.dismiss(context);
            AppSnackbar.showSuccess(
              context,
              title: localizations.success,
              message: localizations.treatmentSavedSuccessfully,
            );
            context.pushReplacementNamed(
              AppRoutesNames.patientDetails,
              extra: {
                'patientId': widget.patientId,
                'patientName': '',
                'tabIndex': 1,
              },
            );
          },
          error: (message) {
            AppLoadingDialog.dismiss(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: Column(
          children: [
            PageHeader(
              title: localizations.addTreatment,
              onBack: () => context.pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: VisitInfoForm(
                  isInitial: widget.isInitial,
                  visitDate: _visitDate,
                  onVisitDateTap: _selectDate,
                  selectedTreatmentTypes: _selectedTreatmentTypes,
                  availableTreatmentTypes: _getLocalizedTreatmentTypes(
                    localizations,
                  ),
                  onTreatmentToggle: (t) => setState(
                    () => _selectedTreatmentTypes.contains(t)
                        ? _selectedTreatmentTypes.remove(t)
                        : _selectedTreatmentTypes.add(t),
                  ),
                  selectedTeeth: _selectedTeeth,
                  onTeethChanged: (teeth) =>
                      setState(() => _selectedTeeth = teeth),
                  visitSummaryController: _visitSummaryController,
                  totalCostController: _totalCostController,
                  labFeesController: _labFeesController,
                  attachments: _attachments,
                  onUploadTap: () {},
                  onAttachmentRemove: (i) =>
                      setState(() => _attachments.removeAt(i)),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h),
          child: SafeArea(
            top: false,
            child: ElevatedButton(
              onPressed: _saveTreatment,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                foregroundColor: ColorManager.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                localizations.save,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
