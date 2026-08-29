import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/assets.gen.dart';
import 'package:dental_clinic_app/custom_widgets/denta_nav_bar.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class DesktopNavItem {
  /// An SVG path `d` string from [DentaNavIcons] - the same icon
  /// vocabulary the mobile nav pill draws, so a destination reads
  /// identically on both layouts.
  final String iconPath;
  final String label;

  /// 1-5: the digit in the Ctrl/Cmd+N chord this row answers to.
  final int shortcutDigit;

  const DesktopNavItem({
    required this.iconPath,
    required this.label,
    required this.shortcutDigit,
  });

  /// The chord spelled out for the host platform. Tooltip only - the badge
  /// carries the bare digit, since the modifier is the same for every row
  /// and only eats width next to the label.
  String get shortcutLabel => desktopTabShortcut(shortcutDigit);
}

/// Label for the Ctrl/Cmd+N badge on a nav row.
///
/// RootPage binds both Control and Meta, so the badge has to name whichever
/// modifier the platform actually uses. It also has to stay in the Latin
/// range off macOS: the bundled font families carry no U+2318 glyph, so a
/// hardcoded command symbol rendered as tofu next to the digit on Windows.
String desktopTabShortcut(int digit) =>
    defaultTargetPlatform == TargetPlatform.macOS
    ? '\u2318$digit'
    : 'Ctrl $digit';

List<DesktopNavItem> buildDesktopNavItems(AppLocalizations l10n) {
  return [
    DesktopNavItem(
      iconPath: DentaNavIcons.home,
      label: l10n.home,
      shortcutDigit: 1,
    ),
    DesktopNavItem(
      iconPath: DentaNavIcons.patients,
      label: l10n.patients,
      shortcutDigit: 2,
    ),
    DesktopNavItem(
      iconPath: DentaNavIcons.calendar,
      label: l10n.appointments,
      shortcutDigit: 3,
    ),
    DesktopNavItem(
      iconPath: DentaNavIcons.payments,
      label: l10n.expenses,
      shortcutDigit: 4,
    ),
    DesktopNavItem(
      iconPath: DentaNavIcons.more,
      label: l10n.more,
      shortcutDigit: 5,
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
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              // The mark is a blue D around a white tooth, so it needs a
              // light ground - on a primary tile the D sank into its own
              // background and only the tooth read. Same treatment as the
              // auth split panel.
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(12),
              // In light mode the sidebar is white too, so the tile needs an
              // edge; in dark mode the surface already provides one.
              border: isDark ? null : Border.all(color: c.borderLight),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            // The brand mark, matching the auth split panel and the mobile
            // login header rather than a stand-in glyph.
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Assets.imagesLogoDentaMark.image(fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.appName,
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
                  l10n.professionalClinicManagement,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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

    // The hover fill has to read against the sidebar's own `cardBg`, which
    // rules out `menuGroupBg` - that token is identical to `cardBg` in dark
    // mode and a 2% step from it in light, so it landed as no feedback at
    // all. A low primary tint is the selected row's language one step down,
    // and it holds in both themes.
    final Color bgColor;
    if (selected) {
      bgColor = ColorManager.primary.withValues(alpha: 0.10);
    } else if (_hovered) {
      bgColor = ColorManager.primary.withValues(alpha: 0.06);
    } else {
      bgColor = Colors.transparent;
    }

    // Foreground lifts with the fill so the row still reads as hovered for
    // anyone who cannot pick up a 6% background shift.
    final Color iconColor = selected
        ? ColorManager.primary
        : (_hovered ? c.textPrimary : c.iconDefault);
    final Color textColor = selected
        ? ColorManager.primary
        : (_hovered ? c.textPrimary : c.textSecondary);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Tooltip(
        message: '${widget.item.label}  ·  ${widget.item.shortcutLabel}',
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
                // The MouseRegion above owns the hover fill; the material
                // default would layer a second tint on a different curve and
                // make the row look like it settles twice.
                hoverColor: Colors.transparent,
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
                          SvgPicture.string(
                            DentaNavIcons.wrap(widget.item.iconPath),
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
