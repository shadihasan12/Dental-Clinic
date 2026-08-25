import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/added_by_label.dart';
import 'package:dental_clinic_app/features/patients/domain/entities/patient_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

/// Patient reference data, as a collapsible card at the foot of the scroll.
///
/// Replaces the old three-column tab layout: one label-over-value stack per
/// row, dividers instead of avatars, and only the rows that actually have
/// data. Clinical fields carry colour so allergies never read as ordinary
/// text, and the phone numbers are dialable rather than decorative.
class PatientInfoCard extends StatefulWidget {
  const PatientInfoCard({
    super.key,
    required this.patient,
    this.onEdit,
    this.initiallyExpanded = true,
  });

  final PatientEntity patient;
  final VoidCallback? onEdit;
  final bool initiallyExpanded;

  @override
  State<PatientInfoCard> createState() => _PatientInfoCardState();
}

class _PatientInfoCardState extends State<PatientInfoCard> {
  late bool _open = widget.initiallyExpanded;

  static bool _blank(String? v) {
    if (v == null) return true;
    final t = v.trim().toLowerCase();
    return t.isEmpty || t == 'none' || t == 'n/a' || t == '-';
  }

  Future<void> _call(String raw) async {
    final digits = raw.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.isEmpty) return;
    final uri = Uri(scheme: 'tel', path: digits);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final family = FontHelper.fontFamily(context);
    final p = widget.patient;
    final locale = Localizations.localeOf(context).toString();
    final dateFmt = DateFormat('d MMM yyyy', locale);

    final rows = <Widget>[
      if (p.phone.trim().isNotEmpty)
        _InfoRow(
          label: l10n.phone,
          value: p.phone,
          trailingIcon: Icons.call_outlined,
          onTrailing: () => _call(p.phone),
        ),
      _InfoRow(
        label: l10n.dateOfBirth,
        value: p.age > 0
            ? '${dateFmt.format(p.dateOfBirth)} - ${p.age} ${l10n.yrs}'
            : dateFmt.format(p.dateOfBirth),
      ),
      if (p.gender.trim().isNotEmpty)
        _InfoRow(label: l10n.gender, value: p.gender),
      if (p.email.trim().isNotEmpty)
        _InfoRow(label: l10n.email, value: p.email),
      if (p.address.trim().isNotEmpty)
        _InfoRow(label: l10n.address, value: p.address, maxLines: 3),
      _InfoRow(
        label: l10n.allergies,
        value: _blank(p.allergies) ? l10n.notRecorded : p.allergies!.trim(),
        // Red only when something is actually on file. An empty field is a
        // gap in the record, not a clear result.
        valueColor: _blank(p.allergies) ? c.textTertiary : ColorManager.error,
        maxLines: 3,
      ),
      _InfoRow(
        label: l10n.medicalHistory,
        value: _blank(p.medicalHistory)
            ? l10n.notRecorded
            : p.medicalHistory!.trim(),
        valueColor:
            _blank(p.medicalHistory) ? ColorManager.warning : c.textPrimary,
        maxLines: 4,
      ),
      if (!_blank(p.insuranceProvider) || !_blank(p.insuranceNumber))
        _InfoRow(
          label: l10n.insuranceLabel,
          value: [
            if (!_blank(p.insuranceProvider)) p.insuranceProvider!.trim(),
            if (!_blank(p.insuranceNumber)) p.insuranceNumber!.trim(),
          ].join(' - '),
        ),
      if (!_blank(p.emergencyContact))
        _InfoRow(
          label: l10n.emergencyContactLabel,
          value: p.emergencyContact!.trim(),
          trailingIcon: Icons.call_outlined,
          onTrailing: () => _call(p.emergencyContact!),
        ),
      if (!_blank(p.nextVisit))
        _InfoRow(label: l10n.nextVisit, value: p.nextVisit!.trim()),
    ];

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _open = !_open),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 14.h, 12.w, 14.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.patientInformationTitle,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: family,
                        color: c.textPrimary,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _open ? 0.5 : 0,
                    duration: const Duration(milliseconds: 160),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 22.w,
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_open) ...[
            for (final row in rows) ...[
              Divider(height: 1, color: c.borderLight),
              row,
            ],
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 14.h),
              child: AddedByLabel(
                audits: p.audits,
                createdAt: p.createdAt,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.maxLines = 2,
    this.trailingIcon,
    this.onTrailing,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final int maxLines;
  final IconData? trailingIcon;
  final VoidCallback? onTrailing;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 11.h, 8.w, 11.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.4,
                    fontFamily: family,
                    color: c.textTertiary,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  value,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    height: 1.35,
                    fontWeight: FontWeight.w400,
                    fontFamily: family,
                    color: valueColor ?? c.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          if (trailingIcon != null && onTrailing != null)
            IconButton(
              onPressed: onTrailing,
              visualDensity: VisualDensity.compact,
              icon: Icon(
                trailingIcon,
                size: 18.w,
                color: ColorManager.primaryDarker,
              ),
            ),
        ],
      ),
    );
  }
}
