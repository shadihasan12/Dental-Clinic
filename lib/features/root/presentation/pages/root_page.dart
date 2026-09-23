import 'package:dental_clinic_app/custom_widgets/denta_nav_bar.dart';
import 'package:dental_clinic_app/features/home/presentation/pages/home_page.dart';
import 'package:dental_clinic_app/features/expenses/presentation/pages/expenses_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/patients_list_page.dart';
import 'package:dental_clinic_app/features/appointments/presentation/pages/appointments_page.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/custom_widgets/permission_gate.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_bloc.dart';
import 'package:dental_clinic_app/services/permissions/permission_slugs.dart';
import 'package:dental_clinic_app/services/permissions/root_tabs.dart';
import 'package:dental_clinic_app/core/config/app_config.dart';
import 'package:dental_clinic_app/features/billing/presentation/pages/billing_page.dart';
import 'package:dental_clinic_app/features/root/presentation/widgets/subscription_access_widgets.dart';
import 'package:dental_clinic_app/services/subscription_guard/access_mode.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  /// Drives the active bottom-nav tab. Children call
  /// `RootPage.selectedTab.value = <index>` to switch tabs (e.g. the home
  /// page's "View all" button jumping to Appointments).
  static final ValueNotifier<int> selectedTab = ValueNotifier<int>(0);

  @override
  State<RootPage> createState() => _RootPageState();
}

/// Tabs that run edge to edge behind the floating bar.
///
/// Opting in is a promise the page makes: it paints its own background over
/// the full height and pads its own scroll view by
/// [DentaNavBar.contentBottomInset] or more, so nothing it draws ends up
/// stuck under the pill. Every tab now does.
const Set<RootTab> _fullBleedTabs = {
  RootTab.home,
  RootTab.patients,
  RootTab.appointments,
  RootTab.expenses,
};

class _RootPageState extends State<RootPage> {
  // Held as a [RootTab], not a position: the bar drops the tabs this user has
  // no permission for, so a list index means nothing outside one build.
  RootTab _currentTab = RootTab.home;
  // Bumped whenever the active clinic changes. Used as part of each tab's
  // ValueKey so Flutter discards the existing State and re-mounts the
  // subtree, which forces every per-tab initState (and therefore every
  // clinic-scoped API fetch) to run again against the new clinic.
  int _clinicVersion = 0;

  @override
  void initState() {
    super.initState();
    getIt<ClinicPermissionsBloc>().add(const ClinicPermissionsEvent.load());
    RootPage.selectedTab.addListener(_onExternalTabChange);
    UserStorage.clinicChangedNotifier.addListener(_onClinicChanged);
  }

  @override
  void dispose() {
    RootPage.selectedTab.removeListener(_onExternalTabChange);
    UserStorage.clinicChangedNotifier.removeListener(_onClinicChanged);
    super.dispose();
  }

  void _onExternalTabChange() {
    final next = RootPage.selectedTab.value;
    if (next < 0 || next >= RootTab.values.length) return;
    final tab = RootTab.values[next];
    // A jump from elsewhere in the app can name a tab this user doesn't have;
    // ignoring it keeps the notifier and the visible selection from drifting
    // apart, since the bar could not show that tab anyway.
    final allowed = visibleRootTabs(getIt<ClinicPermissionsBloc>().state);
    if (!allowed.contains(tab)) return;
    if (tab != _currentTab) {
      setState(() => _currentTab = tab);
    }
  }

  void _onClinicChanged() {
    if (!mounted) return;
    // The new clinic's mode arrives with its permissions; until then it must
    // not inherit the old clinic's lock or read-only banner.
    getIt<SubscriptionGuard>().reset();
    getIt<ClinicPermissionsBloc>().add(const ClinicPermissionsEvent.load());
    setState(() => _clinicVersion++);
  }

  /// The page behind one tab. A tab that survived [visibleRootTabs] still
  /// keeps its own gate: permissions fail open while loading and on error, and
  /// the gate is what actually refuses the content in that window.
  Widget _pageFor(RootTab tab) {
    final v = _clinicVersion;
    switch (tab) {
      case RootTab.home:
        return HomePage(key: ValueKey('home-$v'));
      case RootTab.patients:
        return PermissionGate(
          key: ValueKey('patients-$v'),
          anyOf: const [
            PermissionSlugs.viewClinicPatients,
            PermissionSlugs.manageClinicPatients,
          ],
          child: const PatientsListPage(),
        );
      case RootTab.appointments:
        return PermissionGate(
          key: ValueKey('appointments-$v'),
          anyOf: const [
            PermissionSlugs.viewClinicAppointments,
            PermissionSlugs.manageClinicAppointments,
          ],
          child: const AppointmentsPage(),
        );
      case RootTab.expenses:
        return PermissionGate(
          key: ValueKey('expenses-$v'),
          anyOf: const [
            PermissionSlugs.viewClinicExpenses,
            PermissionSlugs.manageClinicExpenses,
          ],
          child: const ExpensesPage(),
        );
    }
  }

  DentaNavItem _navItemFor(RootTab tab, AppLocalizations l10n) {
    switch (tab) {
      case RootTab.home:
        return DentaNavItem(label: l10n.home, iconPath: DentaNavIcons.home);
      case RootTab.patients:
        return DentaNavItem(
          label: l10n.patients,
          iconPath: DentaNavIcons.patients,
        );
      case RootTab.appointments:
        return DentaNavItem(
          label: l10n.appointments,
          iconPath: DentaNavIcons.calendar,
        );
      case RootTab.expenses:
        return DentaNavItem(
          label: l10n.expenses,
          iconPath: DentaNavIcons.payments,
        );
    }
  }

  void _onTabSelected(RootTab tab) {
    if (tab == _currentTab) return;
    setState(() => _currentTab = tab);
    RootPage.selectedTab.value = tab.index;
  }

  /// A clinic switch can take a tab away while the user is standing on it, so
  /// the selection lands back on home rather than on whatever slid into that
  /// slot.
  void _onPermissionsChanged(ClinicPermissionsState state) {
    if (visibleRootTabs(state).contains(_currentTab)) return;
    setState(() => _currentTab = RootTab.home);
    RootPage.selectedTab.value = RootTab.home.index;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Pages that have not been converted are pushed up by the pill's full
    // footprint, so nothing they draw can end up hidden underneath it. A
    // full-bleed tab reserves that room inside its own scroll view instead,
    // and its content passes behind the glass.
    final reservedBarHeight = DentaNavBar.reservedHeight(context);
    const reservedTop = 8.0;

    return BlocConsumer<ClinicPermissionsBloc, ClinicPermissionsState>(
      bloc: getIt<ClinicPermissionsBloc>(),
      listener: (_, state) => _onPermissionsChanged(state),
      builder: (context, state) => ValueListenableBuilder<AccessMode>(
        valueListenable: getIt<SubscriptionGuard>().mode,
        builder: (context, mode, _) {
          if (AppConfig.billingEnabled && mode.isLocked) {
            // billing_only (or no subscription): every other tab would
            // answer 402, so the app opens on the subscription screen and
            // offers nowhere else. Someone who cannot pay is told who can.
            return SubscriptionGuardHelper.canManageBilling
                ? BillingPage(
                    key: ValueKey('locked-billing-$_clinicVersion'),
                    locked: true,
                  )
                : const SubscriptionLockedView();
          }
          return _buildTabs(
            context,
            state,
            reservedBarHeight,
            reservedTop,
            l10n,
            readOnly: AppConfig.billingEnabled && mode == AccessMode.readOnly,
          );
        },
      ),
    );
  }

  Widget _buildTabs(
    BuildContext context,
    ClinicPermissionsState state,
    double reservedBarHeight,
    double reservedTop,
    AppLocalizations l10n, {
    required bool readOnly,
  }) {
    // A secretary, for one, has no expenses permission — that tab is gone
    // from the bar rather than sitting there leading to a locked page.
    final tabs = visibleRootTabs(state);
    // The listener puts this right, but it runs in the same frame as this
    // build, so the fallback is applied here too.
    final current = tabs.contains(_currentTab) ? _currentTab : RootTab.home;
    final index = tabs.indexOf(current);

    final content = Stack(
      children: [
        Positioned.fill(
          child: IndexedStack(
            index: index,
            children: [
              for (final tab in tabs)
                Padding(
                  // A full-bleed tab paints its own background to the
                  // edges and leaves its own room at the bottom, so the
                  // pill floats over its content - which is the whole
                  // point of a translucent, blurred bar. Every other
                  // tab still has the space reserved for it, and can
                  // drop out of this padding as it is converted.
                  padding: _fullBleedTabs.contains(tab)
                      ? EdgeInsets.zero
                      : EdgeInsets.only(
                          top: reservedTop,
                          bottom: reservedBarHeight,
                        ),
                  child: _pageFor(tab),
                ),
            ],
          ),
        ),
        // One stroke weight and one bounding box across all of them,
        // drawn from the redesign's own icon set rather than a
        // per-platform symbol lookup.
        DentaNavBar(
          items: [for (final tab in tabs) _navItemFor(tab, l10n)],
          selectedIndex: index,
          onTap: (i) => _onTabSelected(tabs[i]),
        ),
      ],
    );

    // Expired: everything stays readable, nothing can be changed. The banner
    // takes the status bar's inset, so the tab under it must not add it a
    // second time. The slot is always there, empty or not, so the banner
    // coming and going never remounts the tabs underneath.
    return Scaffold(
      body: Column(
        children: [
          readOnly ? const ReadOnlyBanner() : const SizedBox.shrink(),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: readOnly,
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}
