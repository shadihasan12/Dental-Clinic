import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';

/// "Page 2 of 15", then previous, the page numbers and next beneath the
/// table.
class DesktopPager extends StatelessWidget {
  const DesktopPager({
    super.key,
    required this.page,
    required this.lastPage,
    required this.isLoading,
    required this.onGoToPage,
  });

  final int page;
  final int lastPage;
  final bool isLoading;
  final ValueChanged<int> onGoToPage;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    return Row(
      children: [
        Text(
          l10n.paginationPageOf(page, lastPage),
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 13,
            color: c.textTertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (isLoading) ...[
          const SizedBox(width: 10),
          const SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: ColorManager.primary,
            ),
          ),
        ],
        const Spacer(),
        _PagerButton(
          // Points back toward the start edge in both LTR and RTL; the icon
          // mirrors itself.
          icon: Icons.chevron_left,
          label: l10n.paginationPrevious,
          iconFirst: true,
          onTap: !isLoading && page > 1 ? () => onGoToPage(page - 1) : null,
        ),
        const SizedBox(width: 6),
        for (final n in _pageNumbers()) ...[
          if (n == null)
            SizedBox(
              width: 24,
              child: Text(
                '…',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: fontFamily, color: c.textSubtle),
              ),
            )
          else
            _PageNumberButton(
              number: n,
              selected: n == page,
              onTap: !isLoading && n != page ? () => onGoToPage(n) : null,
            ),
          const SizedBox(width: 6),
        ],
        _PagerButton(
          icon: Icons.chevron_right,
          label: l10n.next,
          iconFirst: false,
          onTap: !isLoading && page < lastPage
              ? () => onGoToPage(page + 1)
              : null,
        ),
      ],
    );
  }

  /// Every page when there are few; otherwise the first, the last, and the
  /// current one with its neighbours, with null marking each gap ("…").
  List<int?> _pageNumbers() {
    if (lastPage <= 7) return [for (var i = 1; i <= lastPage; i++) i];

    final around = {
      1,
      lastPage,
      for (var i = page - 1; i <= page + 1; i++)
        if (i >= 1 && i <= lastPage) i,
    }.toList()..sort();

    final out = <int?>[];
    for (final n in around) {
      if (out.isNotEmpty && n - out.last! > 1) out.add(null);
      out.add(n);
    }
    return out;
  }
}

class _PageNumberButton extends StatelessWidget {
  const _PageNumberButton({
    required this.number,
    required this.selected,
    required this.onTap,
  });

  final int number;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return MouseRegion(
      cursor: onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? ColorManager.primary : c.cardBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? ColorManager.primary : c.borderLight,
            ),
          ),
          child: Text(
            '$number',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : c.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _PagerButton extends StatelessWidget {
  const _PagerButton({
    required this.icon,
    required this.label,
    required this.iconFirst,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool iconFirst;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final enabled = onTap != null;
    final color = enabled ? c.textPrimary : c.textSubtle;

    // chevron_left / chevron_right already mirror themselves in RTL, so no
    // flip here - adding one turned them back the wrong way in Arabic.
    final iconWidget = Icon(icon, size: 18, color: color);
    final text = Text(
      label,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );

    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: c.borderLight),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: iconFirst
                ? [iconWidget, const SizedBox(width: 4), text]
                : [text, const SizedBox(width: 4), iconWidget],
          ),
        ),
      ),
    );
  }
}
