import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import '../widgets/widgets.dart';

class AddTreatmentPage extends StatefulWidget {
  const AddTreatmentPage({
    super.key,
    required this.caseId,
    this.isInitial = false,
  });

  final int caseId;
  final bool isInitial;

  @override
  State<AddTreatmentPage> createState() => _AddTreatmentPageState();
}

class _AddTreatmentPageState extends State<AddTreatmentPage> {
  DateTime _visitDate = DateTime.now();
  final List<String> _selectedTreatmentTypes = [];
  final _visitSummaryController = TextEditingController();
  final _totalCostController = TextEditingController();
  final _labFeesController = TextEditingController();
  List<int> _selectedTeeth = [];
  final List<String> _attachments = [];

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

  Future<void> _saveTreatment() async {
    final localizations = AppLocalizations.of(context)!;
    AppLoadingDialog.show(context: context, message: localizations.savingTreatment);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) AppLoadingDialog.dismiss(context);

    if (mounted) {
      AppSnackbar.showSuccess(
        context,
        title: localizations.success,
        message: localizations.treatmentSavedSuccessfully,
      );
      context.pushReplacementNamed(
        AppRoutesNames.patientDetails,
        extra: {'patientId': widget.caseId.toString(), 'tabIndex': 1},
      );
    }
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
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: PageHeader(
        title: localizations.addTreatment,
        onBack: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: VisitInfoForm(
          isInitial: widget.isInitial,
          visitDate: _visitDate,
          onVisitDateTap: _selectDate,
          selectedTreatmentTypes: _selectedTreatmentTypes,
          availableTreatmentTypes: _getLocalizedTreatmentTypes(localizations),
          onTreatmentToggle: (t) => setState(
            () => _selectedTreatmentTypes.contains(t)
                ? _selectedTreatmentTypes.remove(t)
                : _selectedTreatmentTypes.add(t),
          ),
          selectedTeeth: _selectedTeeth,
          onTeethChanged: (teeth) => setState(() => _selectedTeeth = teeth),
          visitSummaryController: _visitSummaryController,
          totalCostController: _totalCostController,
          labFeesController: _labFeesController,
          attachments: _attachments,
          onUploadTap: () {},
          onAttachmentRemove: (i) => setState(() => _attachments.removeAt(i)),
        ),
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
    );
  }
}
