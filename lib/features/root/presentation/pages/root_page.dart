import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/denta_nav_bar.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/more_menu_page.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/features/home/presentation/pages/home_page.dart';
import 'package:dental_clinic_app/features/expenses/presentation/pages/expenses_page.dart';
import 'package:dental_clinic_app/core/widgets/unread_badge.dart';
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
      // Desktop-only fifth slot. The side nav exposes "More" as a tab, while
      // mobile reaches the same page as a pushed route off the home header.
      if (Responsive.isDesktop(context)) MenuPage(key: ValueKey('more-$v')),
    ];
  }

  void _onTabSelected(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    RootPage.selectedTab.value = index;
  }

  /// The "More" tab only exists on desktop. If the window is narrowed while
  /// it is active, fall back to Home so IndexedStack and the mobile bar can
  /// never be handed an index past their last child.
  int _safeIndex(int childCount) =>
      _currentIndex < childCount ? _currentIndex : 0;

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return _buildDesktopLayout(context);
    }
    return _buildMobileLayout(context);
  }

  // ═════════════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT — top bar + tab content. The side menu and the Ctrl+1..5
  // shortcuts belong to AppShell, which outlives this page.
  // ═════════════════════════════════════════════════════════════════════

  Widget _buildDesktopLayout(BuildContext context) {
    final fontFamily = FontHelper.fontFamily(context);
    final pages = _buildPages();

    return Scaffold(
      body: Column(
        children: [
          _DesktopTopBar(fontFamily: fontFamily),
          Expanded(
            child: IndexedStack(
              index: _safeIndex(pages.length),
              children: pages,
            ),
          ),
        ],
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════
  // MOBILE LAYOUT
  // ═════════════════════════════════════════════════════════════════════

  Widget _buildMobileLayout(BuildContext context) {
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
              child: Builder(
                builder: (context) {
                  final pages = _buildPages();
                  return IndexedStack(
                    index: _safeIndex(pages.length),
                    children: pages,
                  );
                },
              ),
            ),
          ),
          DentaNavBar(
            items: tabs,
            selectedIndex: _safeIndex(tabs.length),
            onTap: _onTabSelected,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP TOP BAR
// ═══════════════════════════════════════════════════════════════════════

class _DesktopTopBar extends StatelessWidget {
  const _DesktopTopBar({required this.fontFamily});

  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final userStorage = getIt<UserStorage>();
    final userName = userStorage.getFirstName() ?? '';
    final clinicName = userStorage.getClinicName() ?? '';

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: c.cardBg,
        border: Border(bottom: BorderSide(color: c.borderLight)),
      ),
      child: Row(
        children: [
          // Welcome + active clinic — the desktop stand-in for the mobile
          // home header, which the side nav layout does not show.
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName.isNotEmpty
                    ? '${l10n.welcomeBack}, $userName'
                    : l10n.welcomeBack,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeightManager.semiBold,
                  color: c.textPrimary,
                ),
              ),
              if (clinicName.isNotEmpty) ...[
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () => context.pushNamed(AppRoutesNames.myClinics),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4ADE80),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        clinicName,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 13,
                          color: ColorManager.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: ColorManager.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          const Spacer(),

          IconButton(
            onPressed: () => context.pushNamed(AppRoutesNames.notifications),
            tooltip: l10n.notifications,
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: c.textSecondary,
                  size: 22,
                ),
                // Desktop has no push channel, so this pill is the only thing
                // on screen that says a notification landed while the user was
                // looking at another page. It follows the poller.
                Positioned(
                  right: -6,
                  top: -5,
                  child: UnreadBadge(borderColor: c.cardBg),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          InkWell(
            onTap: () => context.pushNamed(AppRoutesNames.editProfile),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: ColorManager.primary10,
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    userName,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeightManager.medium,
                      color: c.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

