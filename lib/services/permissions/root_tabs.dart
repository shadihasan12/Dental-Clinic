import 'package:dental_clinic_app/services/permissions/clinic_permissions_bloc.dart';
import 'package:dental_clinic_app/services/permissions/permission_slugs.dart';

/// The root destinations, in canonical order.
///
/// The *index* of each value is the app's stable tab id: `RootPage.selectedTab`
/// and `DesktopShell.selectedTabIndex` are both spoken in these numbers by
/// pages all over the app, so hiding a tab must never renumber the rest.
/// Everything that filters tabs maps back through this enum, never through a
/// position in a filtered list.
enum RootTab {
  home,
  patients,
  appointments,
  expenses;

  /// Slugs that grant this tab, any one of which is enough — the backend
  /// doesn't always emit the `view-` slug for a user who has `manage-`, and
  /// manage trivially implies view. Home is granted to everyone.
  List<String> get slugs {
    switch (this) {
      case RootTab.home:
        return const [];
      case RootTab.patients:
        return const [
          PermissionSlugs.viewClinicPatients,
          PermissionSlugs.manageClinicPatients,
        ];
      case RootTab.appointments:
        return const [
          PermissionSlugs.viewClinicAppointments,
          PermissionSlugs.manageClinicAppointments,
        ];
      case RootTab.expenses:
        return const [
          PermissionSlugs.viewClinicExpenses,
          PermissionSlugs.manageClinicExpenses,
        ];
    }
  }
}

/// The tabs to actually put in front of the user for [state].
///
/// A secretary has no expenses permission, and the backend refuses the call,
/// so the tab is dead weight that leads to a locked page — it comes out of
/// the bar entirely.
///
/// Until the permissions call lands, and if it fails, every tab is listed:
/// the bar is a convenience, and the `PermissionGate` around each page is what
/// actually refuses access. Hiding while loading would also make the bar
/// reshuffle on every clinic switch.
List<RootTab> visibleRootTabs(ClinicPermissionsState state) {
  return state.maybeWhen(
    loaded: (permissions) => RootTab.values
        .where((tab) => tab.slugs.isEmpty || tab.slugs.any(permissions.hasFeature))
        .toList(),
    orElse: () => RootTab.values.toList(),
  );
}
