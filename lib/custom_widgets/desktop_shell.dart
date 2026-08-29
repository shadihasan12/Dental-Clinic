import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/core/widgets/unread_badge.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Gives a sub-page its desktop top bar - back affordance, title, and the
/// account controls. On mobile it renders [body] directly.
///
/// The side menu is deliberately not here: [AppShell] draws it once for the
/// whole app, above the navigator, so it stays put while pages come and go.
/// This widget only fills the content pane.
///
/// [breadcrumb] is shown as a small path above the title, e.g. "Appointments"
/// for the New Appointment page.
class DesktopShell extends StatelessWidget {
  const DesktopShell({
    super.key,
    required this.body,
    this.title,
    this.breadcrumb,
  });

  final Widget body;
  final String? title;
  final String? breadcrumb;

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isDesktop(context)) return body;

    final fontFamily = FontHelper.fontFamily(context);

    return Column(
      children: [
        _SubpageTopBar(
          fontFamily: fontFamily,
          title: title,
          breadcrumb: breadcrumb,
        ),
        Expanded(child: body),
      ],
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

  /// Path of the notification inbox, as go_router knows it.
  ///
  /// Kept as a literal rather than reaching for NotificationRouting: this is
  /// a layout widget, and importing the notification service here would drag
  /// RootPage and the whole feature graph into every page's shell.
  static const String _notificationsPath = '/notifications';

  /// Whether the inbox is the route currently on top.
  ///
  /// Reads the delegate rather than `GoRouterState.of`, which throws when the
  /// shell is built under a route pushed with a plain [Navigator] - the add
  /// user form does exactly that.
  static bool _isOnNotificationsPage(BuildContext context) {
    final router = GoRouter.maybeOf(context);
    if (router == null) return false;
    return router.routerDelegate.currentConfiguration.uri.path ==
        _notificationsPath;
  }

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
          // Expanded, not Flexible: a loose Flexible competes with the
          // Spacer for the free space and only ever gives half of it away,
          // which strands the rest *after* the profile pill and drags the
          // trailing controls in towards the title.
          if (title != null)
            Expanded(
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
            )
          else
            const Spacer(),

          // Hidden while the inbox itself is on screen. The bell pushes a
          // route unconditionally, so on that page it stacked a second and
          // third copy of the page the user was already looking at - and a
          // shortcut to where you already are is noise even when it works.
          if (!_isOnNotificationsPage(context)) ...[
            _TopBarIconButton(
              icon: Icons.notifications_outlined,
              tooltip: AppLocalizations.of(context)!.notifications,
              // Live count, not a decorative dot: it was previously pinned on
              // and told the user nothing.
              hasBadge: true,
              onTap: () => context.pushNamed(AppRoutesNames.notifications),
            ),
            const SizedBox(width: 4),
          ],
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
      // No arrow glyph: the bundled fonts have no U+2190, so it drew as
      // tofu on Windows - and nothing is bound to the arrow key anyway.
      message: AppLocalizations.of(context)!.back,
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
            onTap: () => context.canPop() ? context.pop() : context.go('/'),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              // The same chevron the mobile PageHeader uses, so back reads
              // the same on both form factors. It carries
              // matchTextDirection, so it points the right way in Arabic.
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 17,
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

  /// Whether this button carries the live unread-count pill.
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
                      right: 4,
                      top: 4,
                      child: UnreadBadge(borderColor: c.cardBg),
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
