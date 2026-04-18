import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_side_nav.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Wraps a page with the desktop side menu + top bar.
/// On mobile, just renders the [body] directly.
///
/// Use this for pages that navigate away from the root (patient details,
/// add patient, etc.) but should still show the shell on desktop.
///
/// [selectedTabIndex] highlights a nav item (e.g. 2 for appointments) so
/// users keep their sense of place while on a sub-page. Pass null to leave
/// all items unhighlighted.
/// [breadcrumb] is shown as a small path above the page title in the top
/// bar, e.g. "Appointments" for the New Appointment page.
class DesktopShell extends StatelessWidget {
  const DesktopShell({
    super.key,
    required this.body,
    this.title,
    this.selectedTabIndex,
    this.breadcrumb,
  });

  final Widget body;
  final String? title;
  final int? selectedTabIndex;
  final String? breadcrumb;

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isDesktop(context)) return body;

    ScreenUtil.configure(
      data: MediaQuery.of(context).copyWith(
        size: const Size(375, 812),
      ),
    );

    final fontFamily = FontHelper.fontFamily(context);

    return Scaffold(
      body: Row(
        children: [
          DesktopSideNav(
            selectedIndex: selectedTabIndex,
            onTabSelected: null,
          ),
          Expanded(
            child: Column(
              children: [
                _SubpageTopBar(
                  fontFamily: fontFamily,
                  title: title,
                  breadcrumb: breadcrumb,
                ),
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// TOP BAR
// ═══════════════════════════════════════════════════════════════════════

class _SubpageTopBar extends StatelessWidget {
  const _SubpageTopBar({
    required this.fontFamily,
    this.title,
    this.breadcrumb,
  });

  final String fontFamily;
  final String? title;
  final String? breadcrumb;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final userStorage = getIt<UserStorage>();
    final userName = userStorage.getFirstName() ?? '';

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: c.cardBg,
        border: Border(bottom: BorderSide(color: c.borderLight)),
      ),
      child: Row(
        children: [
          _BackButton(fontFamily: fontFamily),
          const SizedBox(width: 6),
          if (title != null)
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (breadcrumb != null && breadcrumb!.isNotEmpty)
                    Text(
                      breadcrumb!,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 11,
                        fontWeight: FontWeightManager.medium,
                        color: c.textTertiary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  Text(
                    title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeightManager.semiBold,
                      color: c.textPrimary,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),

          const Spacer(),

          _TopBarIconButton(
            icon: Icons.notifications_outlined,
            tooltip: AppLocalizations.of(context)!.notifications,
            hasBadge: true,
            onTap: () =>
                context.pushNamed(AppRoutesNames.notifications),
          ),
          const SizedBox(width: 4),
          _ProfilePill(
            fontFamily: fontFamily,
            userName: userName,
            onTap: () => context.pushNamed(AppRoutesNames.editProfile),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatefulWidget {
  const _BackButton({required this.fontFamily});

  final String fontFamily;

  @override
  State<_BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Tooltip(
      message: '\u2190  ${AppLocalizations.of(context)!.back}',
      waitDuration: const Duration(milliseconds: 500),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: Material(
          color: _hovered ? c.cardBgSecondary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () =>
                context.canPop() ? context.pop() : context.go('/'),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_back_rounded,
                size: 20,
                color: c.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBarIconButton extends StatefulWidget {
  const _TopBarIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.hasBadge = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool hasBadge;

  @override
  State<_TopBarIconButton> createState() => _TopBarIconButtonState();
}

class _TopBarIconButtonState extends State<_TopBarIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Tooltip(
      message: widget.tooltip,
      waitDuration: const Duration(milliseconds: 500),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: Material(
          color: _hovered ? c.cardBgSecondary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: widget.onTap,
            child: SizedBox(
              width: 40,
              height: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(widget.icon, color: c.textSecondary, size: 20),
                  if (widget.hasBadge)
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: c.cardBg, width: 1.5),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfilePill extends StatefulWidget {
  const _ProfilePill({
    required this.fontFamily,
    required this.userName,
    required this.onTap,
  });

  final String fontFamily;
  final String userName;
  final VoidCallback onTap;

  @override
  State<_ProfilePill> createState() => _ProfilePillState();
}

class _ProfilePillState extends State<_ProfilePill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Material(
        color: _hovered ? c.cardBgSecondary : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: widget.onTap,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: ColorManager.primary10,
                  child: Text(
                    widget.userName.isNotEmpty
                        ? widget.userName[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontFamily: widget.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.userName,
                  style: TextStyle(
                    fontFamily: widget.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeightManager.medium,
                    color: c.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
