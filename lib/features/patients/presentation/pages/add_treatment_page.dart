import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_shell.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/add_treatment_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_core_treatments_use_case.dart';
import 'package:dental_clinic_app/features/patients/domain/use_cases/get_all_teeth_use_case.dart';
import 'package:dental_clinic_app/features/patients/presentation/manager/add_treatment/add_treatment_bloc.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/add/tooth_chart.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/desktop/desktop_form_widgets.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import '../widgets/widgets.dart';

class AddTreatmentPage extends StatelessWidget {
  const AddTreatmentPage({
    super.key,
    required this.patientId,
    this.isInitial = false,
    this.caseId,
  });

  final String patientId;
  final bool isInitial;
  final String? caseId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddTreatmentBloc>(),
      child: _AddTreatmentContent(
        patientId: patientId,
        isInitial: isInitial,
        caseId: caseId,
      ),
    );
  }
}

class _AddTreatmentContent extends StatefulWidget {
  const _AddTreatmentContent({
    required this.patientId,
    required this.isInitial,
    this.caseId,
  });

  final String patientId;
  final bool isInitial;
  final String? caseId;

  @override
  State<_AddTreatmentContent> createState() => _AddTreatmentContentState();
}

class _AddTreatmentContentState extends State<_AddTreatmentContent> {
  DateTime _visitDate = DateTime.now();
  final List<String> _selectedTreatmentTypes = [];
  final _visitSummaryController = TextEditingController();
  final _totalCostController = TextEditingController();
  final _labFeesController = TextEditingController();
  List<String> _selectedTeeth = [];
  final List<String> _attachments = [];
  List<Tooth> _teeth = [];
  List<CoreTreatment> _coreTreatments = [];

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    _visitSummaryController.dispose();
    _totalCostController.dispose();
    _labFeesController.dispose();
    super.dispose();
  }

  void _saveTreatment() {
    final params = AddTreatmentParams(
      patientId: widget.patientId,
      isInitial: widget.isInitial,
      caseId: widget.caseId,
      visitDate: _visitDate,
      treatmentTypes: _selectedTreatmentTypes,
      selectedTeeth: _selectedTeeth,
      summary: _visitSummaryController.text.trim(),
      totalCost: double.tryParse(_totalCostController.text) ?? 0,
      labFees: double.tryParse(_labFeesController.text) ?? 0,
      attachments: _attachments,
    );

    context.read<AddTreatmentBloc>().add(AddTreatmentEvent.submit(params));
  }

  Future<void> _selectDateMobile() async {
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

  Future<void> _selectDateDesktop() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _visitDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: ColorManager.primary,
              ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _visitDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<AddTreatmentBloc, AddTreatmentState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          saving: () {
            AppLoadingDialog.show(
              context: context,
              message: l10n.savingTreatment,
            );
          },
          success: (_) {
            AppLoadingDialog.dismiss(context);
            AppSnackbar.showSuccess(
              context,
              title: l10n.success,
              message: l10n.treatmentSavedSuccessfully,
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
            AppSnackbar.showError(
              context,
              title: l10n.error,
              message: message,
            );
          },
        );
      },
      child: Responsive.isDesktop(context)
          ? _buildDesktopLayout(l10n)
          : _buildMobileLayout(l10n),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT
  // ═══════════════════════════════════════════════════════════════

  Widget _buildDesktopLayout(AppLocalizations l10n) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final dateFormatted = DateFormat('MMM d, yyyy').format(_visitDate);
    final isToday = DateUtils.isSameDay(_visitDate, DateTime.now());

    return DesktopShell(
      title: l10n.addTreatment,
      body: Scaffold(
        backgroundColor: c.scaffoldBg,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DesktopPageHeader(
                    title: l10n.addTreatment,
                    subtitle: l10n.treatmentType,
                    trailing: DesktopPrimaryButton(
                      label: l10n.save,
                      icon: Icons.check,
                      onPressed: _saveTreatment,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: date + treatment types + teeth
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            DesktopSectionCard(
                              title: l10n.visits,
                              child: _visitDateRow(
                                  l10n, dateFormatted, isToday, fontFamily, c),
                            ),
                            const SizedBox(height: 16),
                            DesktopSectionCard(
                              title: l10n.treatmentType,
                              subtitle:
                                  '${_selectedTreatmentTypes.length} selected',
                              child: _treatmentChips(c, fontFamily),
                            ),
                            const SizedBox(height: 16),
                            DesktopSectionCard(
                              title: l10n.teeth,
                              subtitle: '${_selectedTeeth.length} selected',
                              padding: const EdgeInsets.all(12),
                              child: Center(
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 520),
                                  child: _teeth.isEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.all(40),
                                          child: CircularProgressIndicator(
                                            color: ColorManager.primary,
                                          ),
                                        )
                                      : ToothChart(
                                          teeth: _teeth,
                                          selectedTeeth: _selectedTeeth,
                                          onSelectionChanged: (t) =>
                                              setState(() {
                                            _selectedTeeth = t;
                                          }),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Right: notes + cost + attachments
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            DesktopSectionCard(
                              title: l10n.notes,
                              child: DesktopTextField(
                                label: '',
                                controller: _visitSummaryController,
                                hintText: l10n.addNotesAboutTreatment,
                                maxLines: 5,
                              ),
                            ),
                            if (widget.isInitial) ...[
                              const SizedBox(height: 16),
                              DesktopSectionCard(
                                title: l10n.totalCost,
                                child: Column(
                                  children: [
                                    DesktopTextField(
                                      label: l10n.totalCost,
                                      controller: _totalCostController,
                                      hintText: l10n.totalCostHint,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(decimal: true),
                                      prefixIcon: Icon(
                                        Icons.attach_money,
                                        color: c.textSubtle,
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    DesktopTextField(
                                      label: l10n.labFees,
                                      controller: _labFeesController,
                                      hintText: l10n.labFeesHint,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(decimal: true),
                                      prefixIcon: Icon(
                                        Icons.science_outlined,
                                        color: c.textSubtle,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            DesktopSectionCard(
                              title: l10n.attachments,
                              subtitle: '${_attachments.length} files',
                              child: _attachmentsBlock(l10n, c, fontFamily),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _visitDateRow(AppLocalizations l10n, String formatted, bool isToday,
      String fontFamily, AppColors c) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _selectDateDesktop,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: c.inputBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: c.borderLight),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.calendar_today_outlined,
                    color: ColorManager.primary, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.visits,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 11,
                        color: c.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isToday ? '${l10n.today}, $formatted' : formatted,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: c.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                l10n.change,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _treatmentChips(AppColors c, String fontFamily) {
    if (_coreTreatments.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: CircularProgressIndicator(color: ColorManager.primary),
        ),
      );
    }
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _coreTreatments.map((treatment) {
        final isSelected = _selectedTreatmentTypes.contains(treatment.id);
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => setState(() {
              if (isSelected) {
                _selectedTreatmentTypes.remove(treatment.id);
              } else {
                _selectedTreatmentTypes.add(treatment.id);
              }
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? ColorManager.primary : c.inputBg,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isSelected
                      ? ColorManager.primary
                      : c.border,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color:
                              ColorManager.primary.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSelected) ...[
                    Icon(Icons.check, color: Colors.white, size: 14),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    treatment.displayName,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : c.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _attachmentsBlock(
      AppLocalizations l10n, AppColors c, String fontFamily) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorManager.primary.withValues(alpha: 0.25),
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.cloud_upload_outlined,
                      color: ColorManager.primary, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.addXraysOrPhotos,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_attachments.isNotEmpty) ...[
          const SizedBox(height: 10),
          ..._attachments.asMap().entries.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: c.inputBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: c.borderLight),
                ),
                child: Row(
                  children: [
                    Icon(Icons.attach_file,
                        size: 15, color: c.textSubtle),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        e.value,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 13,
                          color: c.textPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          setState(() => _attachments.removeAt(e.key)),
                      icon: Icon(Icons.close,
                          size: 15, color: c.textSubtle),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                          minWidth: 24, minHeight: 24),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // MOBILE LAYOUT (unchanged)
  // ═══════════════════════════════════════════════════════════════

  Widget _buildMobileLayout(AppLocalizations l10n) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        children: [
          PageHeader(
            title: l10n.addTreatment,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: VisitInfoForm(
                isInitial: widget.isInitial,
                visitDate: _visitDate,
                onVisitDateTap: _selectDateMobile,
                selectedTreatmentTypes: _selectedTreatmentTypes,
                availableTreatmentTypes: _coreTreatments,
                onTreatmentToggle: (t) => setState(
                  () => _selectedTreatmentTypes.contains(t)
                      ? _selectedTreatmentTypes.remove(t)
                      : _selectedTreatmentTypes.add(t),
                ),
                teeth: _teeth,
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
              l10n.save,
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
