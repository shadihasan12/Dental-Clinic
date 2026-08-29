import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_side_nav.dart';
import 'package:dental_clinic_app/features/root/presentation/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// The desktop chrome that outlives navigation.
///
/// Mounted once by the router's `ShellRoute` and handed each page as [child],
/// so opening a sub-page swaps only the content pane: the side menu is never
/// rebuilt into a second copy, never rides the page transition, and never ends
/// up stacked on top of itself. That is the whole difference from drawing the
/// nav inside every page, which is what this replaces.
///
/// On mobile it is a pass-through - the nav lives in the floating pill on
/// [RootPage] instead.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  /// Ctrl+1..5 (Cmd on macOS) jumps between tabs. It lives here rather than on
  /// [RootPage] so the shortcut works from a sub-page too - the tab switch and
  /// the unwind are the same action either way.
  static final Map<LogicalKeyboardKey, int> _tabDigits = {
    LogicalKeyboardKey.digit1: 0,
    LogicalKeyboardKey.digit2: 1,
    LogicalKeyboardKey.digit3: 2,
    LogicalKeyboardKey.digit4: 3,
    LogicalKeyboardKey.digit5: 4,
  };

  void _selectTab(BuildContext context, int index) {
    // The tabs themselves live on the root page's IndexedStack; this notifier
    // is what it listens to, so the order here matters: pick the tab, then
    // unwind, and the page is already on the right tab when it appears.
    RootPage.selectedTab.value = index;

    // Unconditional, and deliberately not guarded by a "are we already at
    // root" check: a tab is a destination, so anything open on top of it has
    // to close, and `go` discards the pushed pages that a `canPop` walk would
    // miss. Landing on '/' when already there re-matches the same route with
    // the same page key, so the tab stack keeps its state.
    GoRouter.of(context).go('/');
  }

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isDesktop(context)) return child;

    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        for (final entry in _tabDigits.entries) ...{
          SingleActivator(entry.key, control: true): _SwitchTabIntent(
            entry.value,
          ),
          SingleActivator(entry.key, meta: true): _SwitchTabIntent(entry.value),
        },
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _SwitchTabIntent: CallbackAction<_SwitchTabIntent>(
            onInvoke: (intent) {
              _selectTab(context, intent.index);
              return null;
            },
          ),
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
            body: Row(
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: RootPage.selectedTab,
                  builder: (context, tab, _) => DesktopSideNav(
                    // The tab stays lit while a sub-page is open, so the user
                    // keeps their sense of place inside a section.
                    selectedIndex: tab,
                    onTabSelected: (index) => _selectTab(context, index),
                  ),
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SwitchTabIntent extends Intent {
  const _SwitchTabIntent(this.index);

  final int index;
}
