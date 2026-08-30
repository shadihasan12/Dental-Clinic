import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/assets.gen.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class DesktopNavItem {
  final String svgPath;
  final String label;
  final String shortcut;

  const DesktopNavItem({
    required this.svgPath,
    required this.label,
    required this.shortcut,
  });
}

List<DesktopNavItem> buildDesktopNavItems(AppLocalizations l10n) {
  return [
    DesktopNavItem(
      svgPath: Assets.iconsRootHome,
      label: l10n.home,
      shortcut: '\u23181',
    ),
    DesktopNavItem(
      svgPath: Assets.iconsRootPatient,
      label: l10n.patients,
      shortcut: '\u23182',
    ),
    DesktopNavItem(
      svgPath: Assets.iconsRootAppointment,
      label: l10n.appointments,
      shortcut: '\u23183',
    ),
    DesktopNavItem(
      svgPath: Assets.iconsRootMoney,
      label: l10n.expenses,
      shortcut: '\u23184',
    ),
    DesktopNavItem(
      svgPath: Assets.iconsRootMenu,
      label: l10n.more,
      shortcut: '\u23185',
    ),
  ];
}

class DesktopSideNav extends StatelessWidget {
  const DesktopSideNav({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final int? selectedIndex;
  final ValueChanged<int>? onTabSelected;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final items = buildDesktopNavItems(l10n);

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: c.cardBg,
        border: Border(right: BorderSide(color: c.borderLight)),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          _BrandHeader(fontFamily: fontFamily),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 1, color: c.borderLight),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
            child: Row(
              children: [
                Text(
                  l10n.menu.toUpperCase(),
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 10,
                    fontWeight: FontWeightManager.semiBold,
                    color: c.textSubtle,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _SideMenuItem(
                  item: items[index],
                  isSelected: selectedIndex == index,
                  fontFamily: fontFamily,
                  onTap: () {
                    if (onTabSelected != null) {
                      onTabSelected!(index);
                    } else {
                      // Subpage navigation: back to root, consumer picks
                      // up the tab via selectedIndex prop.
                      context.go('/');
                    }
                  },
                );
              },
            ),
          ),
          _Footer(fontFamily: fontFamily),
        ],
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader({required this.fontFamily});

  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorManager.primary,
                  ColorManager.primary.withValues(alpha: 0.78),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.primary.withValues(alpha: 0.28),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.medical_services_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'SmylOS',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 20,
                    fontWeight: FontWeightManager.bold,
                    color: c.textPrimary,
                    height: 1.1,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Clinic OS',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeightManager.medium,
                    color: c.textTertiary,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.fontFamily});

  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF4ADE80),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'v1.0.0',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 11,
              fontWeight: FontWeightManager.medium,
              color: c.textSubtle,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _SideMenuItem extends StatefulWidget {
  const _SideMenuItem({
    required this.item,
    required this.isSelected,
    required this.fontFamily,
    required this.onTap,
  });

  final DesktopNavItem item;
  final bool isSelected;
  final String fontFamily;
  final VoidCallback onTap;

  @override
  State<_SideMenuItem> createState() => _SideMenuItemState();
}

class _SideMenuItemState extends State<_SideMenuItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final selected = widget.isSelected;

    final Color bgColor;
    if (selected) {
      bgColor = ColorManager.primary.withValues(alpha: 0.10);
    } else if (_hovered) {
      bgColor = c.menuGroupBg;
    } else {
      bgColor = Colors.transparent;
    }

    final Color iconColor =
        selected ? ColorManager.primary : c.iconDefault;
    final Color textColor =
        selected ? ColorManager.primary : c.textSecondary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Tooltip(
        message: '${widget.item.label}  ·  ${widget.item.shortcut}',
        waitDuration: const Duration(milliseconds: 600),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    if (selected)
                      Positioned(
                        left: 0,
                        top: 10,
                        bottom: 10,
                        child: Container(
                          width: 3,
                          decoration: BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            widget.item.svgPath,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              iconColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              widget.item.label,
                              style: TextStyle(
                                fontFamily: widget.fontFamily,
                                fontSize: 14,
                                fontWeight: selected
                                    ? FontWeightManager.semiBold
                                    : FontWeightManager.medium,
                                color: textColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _ShortcutBadge(
                            label: widget.item.shortcut,
                            highlighted: selected || _hovered,
                            fontFamily: widget.fontFamily,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShortcutBadge extends StatelessWidget {
  const _ShortcutBadge({
    required this.label,
    required this.highlighted,
    required this.fontFamily,
  });

  final String label;
  final bool highlighted;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: highlighted ? 1 : 0.55,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: c.cardBgSecondary,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: c.borderLight),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 10.5,
            fontWeight: FontWeightManager.semiBold,
            color: c.textTertiary,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
