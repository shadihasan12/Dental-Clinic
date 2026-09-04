import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/added_by_label.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/patients/data/models/core_treatment.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_item.dart';
import 'package:dental_clinic_app/features/patients/data/models/treatment_plan_models.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/treatment_details_sheet.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/details/treatment_plan_card.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';

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
      final toothCodes = item.selectedTeeth
          .map((id) {
            final match = widget.teeth.where((t) => t.id == id);
            return match.isNotEmpty ? match.first.universalCode : null;
          })
          .whereType<String>()
          .toList();

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

        result.add(
          PlannedTreatment(
            id: '${item.id}_$typeId',
            type: typeInfo,
            toothNumber: toothCodes.isNotEmpty ? toothCodes.join(', ') : null,
            status: item.isDone
                ? TreatmentPlanStatus.completed
                : TreatmentPlanStatus.planned,
            notes: item.description,
            visitNotes: visitNotes,
          ),
        );
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
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
                  // Title card (editable)
                  _buildTitleCard(context),
                  SizedBox(height: 8.h),
                  AddedByLabel(audits: dc.audits, createdAt: dc.createdAt),
                  SizedBox(height: 12.h),

                  // Info card
                  _buildInfoCard(context, dc),
                  SizedBox(height: 12.h),

                  // Financial card
                  _buildFinancialCard(context, dc),
                  SizedBox(height: 16.h),

                  // Treatments list
                  _buildTreatmentsList(context, treatments),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),

          // Sticky "Reopen Case" button
          if (widget.onReopenCase != null)
            Container(
              padding: EdgeInsets.fromLTRB(
                16.w,
                12.h,
                16.w,
                scaffoldBottomPadding(context, 12.h),
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
                      Icon(
                        Icons.refresh,
                        size: 18.w,
                        color: ColorManager.white,
                      ),
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
                  decoration:
                      formOutlinedInput(
                        context,
                        hintText: AppLocalizations.of(
                          context,
                        )!.caseTitlePlaceholder,
                      ).copyWith(
                        // The title is edited at the size it is read at.
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: FontHelper.fontFamily(context),
                          color: ColorManager.of(context).textTertiary,
                        ),
                      ),
                  onSubmitted: (_) => _saveTitle(),
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: _saveTitle,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check,
                          size: 16.w,
                          color: ColorManager.white,
                        ),
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
            value: AppDate.medium(context, dc.startDate),
          ),
          if (dc.endDate != null) ...[
            SizedBox(height: 10.h),
            _infoRow(
              context,
              icon: Icons.check_circle_outline,
              label: AppLocalizations.of(context)!.completed,
              value: AppDate.medium(context, dc.endDate!),
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
              Icon(
                Icons.info_outline,
                size: 16.w,
                color: ColorManager.of(context).textTertiary,
              ),
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
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
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

  Widget _infoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
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
          colors: [ColorManager.primary, ColorManager.primaryDark],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          _financialStat(
            context,
            AppLocalizations.of(context)!.totalLabel,
            dc.totalCost.toStringAsFixed(0),
          ),
          _financialDivider(),
          _financialStat(
            context,
            AppLocalizations.of(context)!.paidLabel,
            dc.paidAmount.toStringAsFixed(0),
          ),
          _financialDivider(),
          _financialStat(
            context,
            AppLocalizations.of(context)!.pendingLabel,
            dc.pendingAmount.toStringAsFixed(0),
          ),
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
    BuildContext context,
    List<PlannedTreatment> treatments,
  ) {
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
          ...treatments.map(
            (t) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: TreatmentPlanCard(
                treatment: t,
                readOnly: true,
                onTap: () => _showTreatmentDetailsSheet(t),
              ),
            ),
          ),
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
