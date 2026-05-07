import 'package:dental_clinic_app/custom_widgets/glass_tab_bar.dart';
import 'package:dental_clinic_app/features/home/presentation/pages/home_page.dart';
import 'package:dental_clinic_app/features/expenses/presentation/pages/expenses_page.dart';
import 'package:flutter/material.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/patients_list_page.dart';
import 'package:dental_clinic_app/features/appointments/presentation/pages/appointments_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/more_menu_page.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/custom_widgets/permission_gate.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_bloc.dart';
import 'package:dental_clinic_app/services/permissions/permission_slugs.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getIt<ClinicPermissionsBloc>()
        .add(const ClinicPermissionsEvent.load());
  }

  final List<Widget> _pages = [
    const HomePage(),
    const PermissionGate(
      feature: PermissionSlugs.viewClinicPatients,
      child: PatientsListPage(),
    ),
    const AppointmentsPage(),
    const PermissionGate(
      feature: PermissionSlugs.viewClinicExpenses,
      child: ExpensesPage(),
    ),
    MenuPage(),
  ];

  void _onTabSelected(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Single visual weight across all five tabs: SF Symbol outlines that
    // share roughly the same stroke and bounding box. UITabBar's tint
    // colour signals the active tab; no fill swap needed.
    final tabs = <GlassTabItem>[
      GlassTabItem(title: l10n.home, systemIcon: 'house'),
      GlassTabItem(title: l10n.patients, systemIcon: 'person.2'),
      GlassTabItem(title: l10n.appointments, systemIcon: 'calendar'),
      GlassTabItem(title: l10n.expenses, systemIcon: 'dollarsign.circle'),
      GlassTabItem(title: l10n.more, systemIcon: 'ellipsis'),
    ];

    // Just the bar's own footprint reserved at the bottom — no extra
    // margin. Static content will sit cleanly above the bar; pages that
    // end with a scrollable list add their own bottom padding so the last
    // item can be scrolled clear of the bar.
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final reservedBarHeight =
        (isIOS ? 49.0 : 64.0) + MediaQuery.of(context).padding.bottom;
    const reservedTop = 8.0;

    return Scaffold(
      body: Stack(
        children: [
          // Pages fill everything above the bar — Padding pushes the
          // IndexedStack up by the bar's height so no widget at the bottom
          // of any page sits underneath the bar.
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: reservedTop,
                bottom: reservedBarHeight,
              ),
              child: IndexedStack(index: _currentIndex, children: _pages),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GlassTabBar(
              items: tabs,
              selectedIndex: _currentIndex,
              onTap: _onTabSelected,
              tintColor: ColorManager.primary,
            ),
          ),
        ],
      ),
    );
  }
}
