import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_shell.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/desktop/desktop_form_widgets.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/treatment_details_sheet.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/treatment_plan_card.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CompletedCasePage extends StatefulWidget {
  final DentalCase dentalCase;
  final List<Tooth> teeth;
  final List<CoreTreatment> coreTreatments;
  final void Function(String newTitle)? onTitleChanged;
  final VoidCallback? onReopenCase;

  const CompletedCasePage({
    super.key,
    required this.dentalCase,
    required this.teeth,
    required this.coreTreatments,
    this.onTitleChanged,
    this.onReopenCase,
  });

  @override
  State<CompletedCasePage> createState() => _CompletedCasePageState();
}

class _CompletedCasePageState extends State<CompletedCasePage> {
  late String _title;
  bool _isEditingTitle = false;
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _title = widget.dentalCase.title;
    _titleController = TextEditingController(text: _title);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _saveTitle() async {
    final newTitle = _titleController.text.trim();
    if (newTitle.isNotEmpty && newTitle != _title) {
      setState(() {
        _title = newTitle;
        _isEditingTitle = false;
      });
      widget.onTitleChanged?.call(newTitle);
    } else {
      setState(() => _isEditingTitle = false);
    }
  }

  List<PlannedTreatment> _mapTreatments() {
    final result = <PlannedTreatment>[];
    for (final item in widget.dentalCase.treatmentItems) {
      final toothCodes = item.selectedTeeth.map((id) {
        final match = widget.teeth.where((t) => t.id == id);
        return match.isNotEmpty ? match.first.universalCode : null;
      }).whereType<String>().toList();

      for (final typeId in item.treatmentTypes) {
        final ct = widget.coreTreatments.where((t) => t.id == typeId);
        final typeInfo = ct.isNotEmpty
            ? TreatmentTypeInfo(
                id: ct.first.id,
                name: ct.first.name,
                icon: Icons.medical_services_outlined,
                categoryId: ct.first.category.id,
                categoryName: ct.first.category.name,
              )
            : TreatmentTypeInfo(
                id: typeId,
                name: typeId,
                icon: Icons.medical_services_outlined,
                categoryId: '',
                categoryName: '',
              );

        final visitNotes = item.notes.map((n) {
          final dateStr = n['date'] ?? '';
          final date = dateStr.isNotEmpty
              ? DateTime.tryParse(dateStr) ?? DateTime.now()
              : DateTime.now();
          return VisitNote(date: date, text: n['note'] ?? '');
        }).toList();

        result.add(PlannedTreatment(
          id: '${item.id}_$typeId',
          type: typeInfo,
          toothNumber: toothCodes.isNotEmpty ? toothCodes.join(', ') : null,
          status: item.isDone
              ? TreatmentPlanStatus.completed
              : TreatmentPlanStatus.planned,
          notes: item.description,
          visitNotes: visitNotes,
        ));
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return _buildDesktopLayout();
    }
    return _buildMobileLayout();
  }

  // ═══════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT
  // ═══════════════════════════════════════════════════════════════

  Widget _buildDesktopLayout() {
    final dc = widget.dentalCase;
    final treatments = _mapTreatments();
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return DesktopShell(
      title: l10n.completedCase,
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
                    title: _title,
                    subtitle: l10n.completedCase,
                    trailing: widget.onReopenCase != null
                        ? DesktopPrimaryButton(
                            label: l10n.reopenCase,
                            icon: Icons.refresh,
                            onPressed: widget.onReopenCase,
                          )
                        : null,
                  ),
                  const SizedBox(height: 20),
                  _desktopFinancialCard(dc, l10n),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            _desktopTreatmentsCard(treatments, l10n, c),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 320,
                        child: Column(
                          children: [
                            _desktopCaseInfoCard(dc, l10n, c),
                            const SizedBox(height: 16),
                            _desktopTitleCard(l10n, c),
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

  Widget _desktopFinancialCard(DentalCase dc, AppLocalizations l10n) {
    final fontFamily = FontHelper.fontFamily(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ColorManager.primary, ColorManager.primaryDark],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _desktopFinancialStat(
                l10n.totalLabel, '\$${dc.totalCost.toStringAsFixed(0)}',
                big: true, fontFamily: fontFamily),
          ),
          Container(
            width: 1,
            height: 48,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          Expanded(
            child: _desktopFinancialStat(
                l10n.paidLabel, '\$${dc.paidAmount.toStringAsFixed(0)}',
                fontFamily: fontFamily),
          ),
          Container(
            width: 1,
            height: 48,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          Expanded(
            child: _desktopFinancialStat(
                l10n.pendingLabel, '\$${dc.pendingAmount.toStringAsFixed(0)}',
                fontFamily: fontFamily),
          ),
        ],
      ),
    );
  }

  Widget _desktopFinancialStat(String label, String value,
      {bool big = false, required String fontFamily}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: big ? 28 : 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _desktopTitleCard(AppLocalizations l10n, AppColors c) {
    final fontFamily = FontHelper.fontFamily(context);
    return DesktopSectionCard(
      title: l10n.caseTitleOptional,
      trailing: _isEditingTitle
          ? null
          : IconButton(
              tooltip: l10n.edit,
              onPressed: () {
                _titleController.text = _title;
                setState(() => _isEditingTitle = true);
              },
              icon: Icon(Icons.edit_outlined,
                  size: 16, color: c.textSecondary),
            ),
      child: _isEditingTitle
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DesktopTextField(
                  label: '',
                  controller: _titleController,
                  hintText: l10n.caseTitlePlaceholder,
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    DesktopSecondaryButton(
                      label: l10n.cancel,
                      onPressed: () =>
                          setState(() => _isEditingTitle = false),
                      compact: true,
                    ),
                    const SizedBox(width: 8),
                    DesktopPrimaryButton(
                      label: l10n.save,
                      icon: Icons.check,
                      compact: true,
                      onPressed: _saveTitle,
                    ),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: ColorManager.success.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.folder_outlined,
                      size: 18, color: ColorManager.success),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _title,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: c.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _desktopCaseInfoCard(
      DentalCase dc, AppLocalizations l10n, AppColors c) {
    final fontFamily = FontHelper.fontFamily(context);
    return DesktopSectionCard(
      title: l10n.info,
      child: Column(
        children: [
          _desktopInfoRow(Icons.calendar_today_outlined, l10n.started,
              DateFormat('MMM d, yyyy').format(dc.startDate), c, fontFamily),
          if (dc.endDate != null) ...[
            const SizedBox(height: 10),
            _desktopInfoRow(Icons.check_circle_outline, l10n.completed,
                DateFormat('MMM d, yyyy').format(dc.endDate!), c, fontFamily),
          ],
          const SizedBox(height: 10),
          _desktopInfoRow(Icons.medical_services_outlined, l10n.treatments,
              '${dc.treatmentItems.length}', c, fontFamily),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.info_outline, size: 14, color: c.textTertiary),
              const SizedBox(width: 8),
              Text(
                l10n.status,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 12.5,
                  color: c.textTertiary,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: ColorManager.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  dc.status,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.success,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _desktopInfoRow(IconData icon, String label, String value,
      AppColors c, String fontFamily) {
    return Row(
      children: [
        Icon(icon, size: 14, color: c.textTertiary),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 12.5,
            color: c.textTertiary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: c.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _desktopTreatmentsCard(
      List<PlannedTreatment> treatments, AppLocalizations l10n, AppColors c) {
    final fontFamily = FontHelper.fontFamily(context);
    return DesktopSectionCard(
      title: l10n.treatments,
      subtitle: '${treatments.length} total',
      child: treatments.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Icon(Icons.inbox_outlined,
                      size: 36, color: c.textSubtle),
                  const SizedBox(height: 12),
                  Text(
                    l10n.noTreatmentsRecorded,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 13.5,
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: treatments
                  .map(
                    (t) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => _showTreatmentDetailsSheet(t),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: c.inputBg,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: c.borderLight),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: (t.status ==
                                                TreatmentPlanStatus.completed
                                            ? ColorManager.success
                                            : ColorManager.primary)
                                        .withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    t.status == TreatmentPlanStatus.completed
                                        ? Icons.check_circle
                                        : Icons.medical_services_outlined,
                                    color: t.status ==
                                            TreatmentPlanStatus.completed
                                        ? ColorManager.success
                                        : ColorManager.primary,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        t.type.name,
                                        style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w600,
                                          color: c.textPrimary,
                                        ),
                                      ),
                                      if (t.toothNumber != null) ...[
                                        const SizedBox(height: 2),
                                        Text(
                                          'Tooth #${t.toothNumber}',
                                          style: TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: 12,
                                            color: c.textTertiary,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right,
                                    size: 18, color: c.textTertiary),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // MOBILE LAYOUT (unchanged)
  // ═══════════════════════════════════════════════════════════════

  Widget _buildMobileLayout() {
    final dc = widget.dentalCase;
    final treatments = _mapTreatments();

    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: Column(
        children: [
          PageHeader(
            title: AppLocalizations.of(context)!.completedCase,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleCard(context),
                  SizedBox(height: 12.h),
                  _buildInfoCard(context, dc),
                  SizedBox(height: 12.h),
                  _buildFinancialCard(context, dc),
                  SizedBox(height: 16.h),
                  _buildTreatmentsList(context, treatments),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
          if (widget.onReopenCase != null)
            Container(
              padding: EdgeInsets.fromLTRB(
                16.w,
                12.h,
                16.w,
                MediaQuery.of(context).padding.bottom + 12.h,
              ),
              decoration: BoxDecoration(
                color: ColorManager.of(context).cardBg,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: widget.onReopenCase,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadiusManager.lg,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.refresh,
                          size: 18.w, color: ColorManager.white),
                      SizedBox(width: 8.w),
                      Text(
                        AppLocalizations.of(context)!.reopenCase,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          fontWeight: FontWeight.w600,
                          color: ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTitleCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
        borderRadius: BorderRadiusManager.lg,
        border: Border.all(color: ColorManager.of(context).borderLight),
      ),
      child: _isEditingTitle
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _titleController,
                  autofocus: true,
                  maxLines: 3,
                  minLines: 2,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.of(context).textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context)!.caseTitlePlaceholder,
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: ColorManager.of(context).textTertiary,
                    ),
                    filled: true,
                    fillColor: ColorManager.of(context).cardBgSecondary,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          BorderSide(color: ColorManager.of(context).borderLight),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          BorderSide(color: ColorManager.of(context).borderLight),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: ColorManager.primary),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                  ),
                  onSubmitted: (_) => _saveTitle(),
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: _saveTitle,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check,
                            size: 16.w, color: ColorManager.white),
                        SizedBox(width: 4.w),
                        Text(
                          AppLocalizations.of(context)!.save,
                          style: TextStyle(
                            fontSize: 13.sp,
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
            )
          : Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: ColorManager.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.folder_outlined,
                    size: 20.w,
                    color: ColorManager.success,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    _title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: FontHelper.fontFamily(context),
                      fontWeight: FontWeight.w600,
                      color: ColorManager.of(context).textPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _titleController.text = _title;
                    setState(() => _isEditingTitle = true);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: ColorManager.of(context).cardBgSecondary,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 16.w,
                      color: ColorManager.of(context).textSecondary,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildInfoCard(BuildContext context, DentalCase dc) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.of(context).cardBg,
        borderRadius: BorderRadiusManager.lg,
        border: Border.all(color: ColorManager.of(context).borderLight),
      ),
      child: Column(
        children: [
          _infoRow(
            context,
            icon: Icons.calendar_today_outlined,
            label: AppLocalizations.of(context)!.started,
            value: DateFormat('MMM d, yyyy').format(dc.startDate),
          ),
          if (dc.endDate != null) ...[
            SizedBox(height: 10.h),
            _infoRow(
              context,
              icon: Icons.check_circle_outline,
              label: AppLocalizations.of(context)!.completed,
              value: DateFormat('MMM d, yyyy').format(dc.endDate!),
            ),
          ],
          SizedBox(height: 10.h),
          _infoRow(
            context,
            icon: Icons.medical_services_outlined,
            label: AppLocalizations.of(context)!.treatments,
            value: '${dc.treatmentItems.length}',
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(Icons.info_outline,
                  size: 16.w, color: ColorManager.of(context).textTertiary),
              SizedBox(width: 8.w),
              Text(
                AppLocalizations.of(context)!.status,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.of(context).textTertiary,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ColorManager.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  dc.status,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.success,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context,
      {required IconData icon,
      required String label,
      required String value}) {
    return Row(
      children: [
        Icon(icon, size: 16.w, color: ColorManager.of(context).textTertiary),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.of(context).textTertiary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w500,
            color: ColorManager.of(context).textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialCard(BuildContext context, DentalCase dc) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorManager.primary,
            ColorManager.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          _financialStat(context, AppLocalizations.of(context)!.totalLabel,
              dc.totalCost.toStringAsFixed(0)),
          _financialDivider(),
          _financialStat(context, AppLocalizations.of(context)!.paidLabel,
              dc.paidAmount.toStringAsFixed(0)),
          _financialDivider(),
          _financialStat(context, AppLocalizations.of(context)!.pendingLabel,
              dc.pendingAmount.toStringAsFixed(0)),
        ],
      ),
    );
  }

  Widget _financialStat(BuildContext context, String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontFamily: FontHelper.fontFamily(context),
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _financialDivider() {
    return Container(
      width: 1,
      height: 32.h,
      color: Colors.white.withValues(alpha: 0.2),
    );
  }

  Widget _buildTreatmentsList(
      BuildContext context, List<PlannedTreatment> treatments) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.treatments,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: FontHelper.fontFamily(context),
                fontWeight: FontWeight.w600,
                color: ColorManager.of(context).textPrimary,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '${treatments.length}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (treatments.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: ColorManager.of(context).cardBgSecondary,
              borderRadius: BorderRadiusManager.lg,
            ),
            child: Center(
              child: Text(
                l10n.noTreatmentsRecorded,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.of(context).textSecondary,
                ),
              ),
            ),
          )
        else
          ...treatments.map((t) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: TreatmentPlanCard(
                  treatment: t,
                  readOnly: true,
                  onTap: () => _showTreatmentDetailsSheet(t),
                ),
              )),
      ],
    );
  }

  void _showTreatmentDetailsSheet(PlannedTreatment treatment) {
    TreatmentDetailsSheet.show(
      context,
      treatment: treatment,
      teeth: widget.teeth,
    );
  }
}
