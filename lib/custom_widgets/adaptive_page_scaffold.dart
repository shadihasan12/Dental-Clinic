import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_shell.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// One page shell for both form factors, so a sub-page states its title and
/// body once instead of hand-rolling the breakpoint branch.
///
/// Mobile renders [PageHeader] above [body], exactly as before. Desktop hands
/// the page to [DesktopShell], which supplies a top bar already carrying the
/// title and a back affordance — so the mobile header is deliberately not
/// drawn there, and would be a duplicate title bar if it were. The side menu
/// comes from [AppShell], one level above the navigator.
///
/// Prefer this over branching on [Responsive.isDesktop] inside a page: pages
/// that hand-roll the branch are the ones that lose their desktop layout the
/// next time a merge resolves in favour of one side.
class AdaptivePageScaffold extends StatelessWidget {
  const AdaptivePageScaffold({
    super.key,
    required this.title,
    required this.body,
    this.onBack,
    this.actions,
    this.mobileHeader,
    this.breadcrumb,
    this.backgroundColor,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  /// Shown in the mobile [PageHeader] and in the desktop top bar.
  final String title;

  final Widget body;

  /// Defaults to popping the route, falling back to the root when the stack
  /// is empty — the same rule [PageHeader] applies.
  final VoidCallback? onBack;

  /// Trailing header actions. Mobile only: the desktop top bar owns its own
  /// trailing area.
  final List<Widget>? actions;

  /// Replaces the default [PageHeader] on mobile — for the form pages that
  /// use `FormTopBar` instead. Ignored on desktop, where [DesktopShell]'s top
  /// bar already carries the title and back affordance; drawing this as well
  /// would stack two title bars.
  final Widget? mobileHeader;

  /// Small path shown above the desktop title, e.g. "Appointments" for the
  /// New Appointment page.
  final String? breadcrumb;

  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? ColorManager.of(context).scaffoldBg;

    if (Responsive.isDesktop(context)) {
      return DesktopShell(
        title: title,
        breadcrumb: breadcrumb,
        body: Scaffold(
          backgroundColor: bg,
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
          body: body,
        ),
      );
    }

    return Scaffold(
      backgroundColor: bg,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: Column(
        children: [
          mobileHeader ??
              PageHeader(
                title: title,
                actions: actions,
                onBack:
                    onBack ??
                    () => context.canPop() ? context.pop() : context.go('/'),
              ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
