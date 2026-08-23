import 'package:dental_clinic_app/custom_widgets/denta_nav_bar.dart';
import 'package:dental_clinic_app/features/home/presentation/pages/home_page.dart';
import 'package:dental_clinic_app/features/expenses/presentation/pages/expenses_page.dart';
import 'package:flutter/material.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/patients_list_page.dart';
import 'package:dental_clinic_app/features/appointments/presentation/pages/appointments_page.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/custom_widgets/permission_gate.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_bloc.dart';
import 'package:dental_clinic_app/services/permissions/permission_slugs.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  /// Drives the active bottom-nav tab. Children call
  /// `RootPage.selectedTab.value = <index>` to switch tabs (e.g. the home
  /// page's "View all" button jumping to Appointments).
  static final ValueNotifier<int> selectedTab = ValueNotifier<int>(0);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  // Bumped whenever the active clinic changes. Used as part of each tab's
  // ValueKey so Flutter discards the existing State and re-mounts the
  // subtree, which forces every per-tab initState (and therefore every
  // clinic-scoped API fetch) to run again against the new clinic.
  int _clinicVersion = 0;

  @override
  void initState() {
    super.initState();
    getIt<ClinicPermissionsBloc>()
        .add(const ClinicPermissionsEvent.load());
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
    if (next != _currentIndex) {
      setState(() => _currentIndex = next);
    }
  }

  void _onClinicChanged() {
    if (!mounted) return;
    getIt<ClinicPermissionsBloc>()
        .add(const ClinicPermissionsEvent.load());
    setState(() => _clinicVersion++);
  }

  List<Widget> _buildPages() {
    final v = _clinicVersion;
    // Each gate accepts either the `view-` or `manage-` slug — the
    // backend doesn't always emit the view counterpart for users who
    // have manage rights, and manage trivially implies view.
    return [
      HomePage(key: ValueKey('home-$v')),
      PermissionGate(
        key: ValueKey('patients-$v'),
        anyOf: const [
          PermissionSlugs.viewClinicPatients,
          PermissionSlugs.manageClinicPatients,
        ],
        child: const PatientsListPage(),
      ),
      PermissionGate(
        key: ValueKey('appointments-$v'),
        anyOf: const [
          PermissionSlugs.viewClinicAppointments,
          PermissionSlugs.manageClinicAppointments,
        ],
        child: const AppointmentsPage(),
      ),
      PermissionGate(
        key: ValueKey('expenses-$v'),
        anyOf: const [
          PermissionSlugs.viewClinicExpenses,
          PermissionSlugs.manageClinicExpenses,
        ],
        child: const ExpensesPage(),
      ),
    ];
  }

  void _onTabSelected(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    RootPage.selectedTab.value = index;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // One stroke weight and one bounding box across all four, drawn from the
    // redesign's own icon set rather than a per-platform symbol lookup.
    final tabs = <DentaNavItem>[
      DentaNavItem(label: l10n.home, iconPath: DentaNavIcons.home),
      DentaNavItem(label: l10n.patients, iconPath: DentaNavIcons.patients),
      DentaNavItem(
        label: l10n.appointments,
        iconPath: DentaNavIcons.calendar,
      ),
      DentaNavItem(label: l10n.expenses, iconPath: DentaNavIcons.payments),
    ];

    // The pill floats, so the pages are pushed up by its full footprint. It
    // still renders translucent over whatever scrolls into the gap beneath
    // it, but nothing a page draws can end up hidden underneath it.
    final reservedBarHeight = DentaNavBar.reservedHeight(context);
    const reservedTop = 8.0;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: reservedTop,
                bottom: reservedBarHeight,
              ),
              child: IndexedStack(index: _currentIndex, children: _buildPages()),
            ),
          ),
          DentaNavBar(
            items: tabs,
            selectedIndex: _currentIndex,
            onTap: _onTabSelected,
          ),
        ],
      ),
    );
  }
}
