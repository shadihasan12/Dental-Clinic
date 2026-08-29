import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/patients/presentation/widgets/patient_card.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';

/// Rich desktop patient card with hover effects, larger typography,
/// and more information surfaced compared to the compact mobile card.
class PatientCardDesktop extends StatefulWidget {
  const PatientCardDesktop({
    super.key,
    required this.patient,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final Patient patient;
  final VoidCallback onTap;

  /// Desktop parity with the mobile card's slide actions. The overflow menu
  /// is only rendered when a handler is supplied.
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  State<PatientCardDesktop> createState() => _PatientCardDesktopState();
}

class _PatientCardDesktopState extends State<PatientCardDesktop> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final patient = widget.patient;

    final genderLabel = patient.gender.toLowerCase() == 'female'
        ? l10n.female
        : l10n.male;

    final hasBalance = patient.balance > 0;
    final hasNext = patient.nextVisit != null;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovering ? -2 : 0, 0),
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hovering
                  ? ColorManager.primary.withValues(alpha: 0.35)
                  : c.borderLight,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: ColorManager.black.withValues(
                  alpha: _hovering ? 0.08 : 0.03,
                ),
                blurRadius: _hovering ? 18 : 8,
                offset: Offset(0, _hovering ? 8 : 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(c, fontFamily, genderLabel, l10n),
              const SizedBox(height: 14),
              _buildContact(c, fontFamily),
              if (hasBalance || hasNext) ...[
                const SizedBox(height: 14),
                Divider(height: 1, color: c.divider),
                const SizedBox(height: 12),
                _buildFooter(c, fontFamily, l10n, hasBalance, hasNext),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    AppColors c,
    String fontFamily,
    String genderLabel,
    AppLocalizations l10n,
  ) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorManager.primary.withValues(alpha: 0.18),
                ColorManager.primary.withValues(alpha: 0.10),
              ],
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorManager.primary.withValues(alpha: 0.25),
            ),
          ),
          child: Center(
            child: Text(
              widget.patient.initials.toUpperCase(),
              style: TextStyle(
                color: ColorManager.primary,
                fontWeight: FontWeight.w700,
                fontSize: 15,
                fontFamily: fontFamily,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.patient.name,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: fontFamily,
                  color: c.textPrimary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                '${widget.patient.age} ${l10n.years} • $genderLabel',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: fontFamily,
                  color: c.textTertiary,
                ),
              ),
            ],
          ),
        ),
        if (widget.patient.balance > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: ColorManager.warning.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '\$${widget.patient.balance.toInt()}',
              style: TextStyle(
                fontSize: 11,
                fontFamily: fontFamily,
                color: ColorManager.warning,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        if (widget.onEdit != null || widget.onDelete != null)
          _buildActionsMenu(c, fontFamily, l10n),
      ],
    );
  }

  /// Kept at a constant width whether or not it is visible, so the name and
  /// balance badge do not shift sideways as the pointer enters the card.
  Widget _buildActionsMenu(
    AppColors c,
    String fontFamily,
    AppLocalizations l10n,
  ) {
    return SizedBox(
      width: 28,
      height: 28,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 140),
        opacity: _hovering ? 1 : 0,
        child: IgnorePointer(
          ignoring: !_hovering,
          child: PopupMenuButton<int>(
            tooltip: '',
            padding: EdgeInsets.zero,
            iconSize: 18,
            icon: Icon(Icons.more_horiz, color: c.textTertiary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onSelected: (value) {
              if (value == 0) widget.onEdit?.call();
              if (value == 1) widget.onDelete?.call();
            },
            itemBuilder: (context) => [
              if (widget.onEdit != null)
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.edit_outlined, size: 16, color: c.textSecondary),
                      const SizedBox(width: 10),
                      Text(
                        l10n.edit,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: fontFamily,
                          color: c.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.onDelete != null)
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        size: 16,
                        color: ColorManager.error,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        l10n.delete,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: fontFamily,
                          color: ColorManager.error,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContact(AppColors c, String fontFamily) {
    return Row(
      children: [
        Icon(
          Icons.phone_outlined,
          size: 14,
          color: c.textTertiary,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            widget.patient.phone,
            style: TextStyle(
              fontSize: 12.5,
              fontFamily: fontFamily,
              color: c.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(
    AppColors c,
    String fontFamily,
    AppLocalizations l10n,
    bool hasBalance,
    bool hasNext,
  ) {
    if (hasNext) {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.calendar_today_outlined,
              size: 12,
              color: ColorManager.primary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.nextVisit,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontFamily: fontFamily,
                    color: c.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  widget.patient.nextVisit!,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: fontFamily,
                    color: ColorManager.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      );
    }

    // Fallback: outstanding balance shown below
    return Row(
      children: [
        Icon(Icons.account_balance_wallet_outlined,
            size: 13, color: ColorManager.warning),
        const SizedBox(width: 6),
        Text(
          l10n.outstandingBalance,
          style: TextStyle(
            fontSize: 12,
            fontFamily: fontFamily,
            color: c.textSecondary,
          ),
        ),
      ],
    );
  }
}
