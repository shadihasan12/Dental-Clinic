import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/assets.gen.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_side_nav.dart';
import 'package:dental_clinic_app/features/home/presentation/pages/home_page.dart';
import 'package:dental_clinic_app/features/expenses/presentation/pages/expenses_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/patients_list_page.dart';
import 'package:dental_clinic_app/features/appointments/presentation/pages/appointments_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/more_menu_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/custom_widgets/permission_gate.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_bloc.dart';
import 'package:dental_clinic_app/services/permissions/permission_slugs.dart';
import 'package:go_router/go_router.dart';

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
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return _buildDesktopLayout(context);
    }
    return _buildMobileLayout(context);
  }

  // ═══════════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildDesktopLayout(BuildContext context) {
    final fontFamily = FontHelper.fontFamily(context);

    // Reconfigure screenutil so .sp/.w/.h scale as mobile
    ScreenUtil.configure(
      data: MediaQuery.of(context).copyWith(
        size: const Size(375, 812),
      ),
    );

    final scaffold = Scaffold(
      body: Row(
        children: [
          DesktopSideNav(
            selectedIndex: _currentIndex,
            onTabSelected: _onTabSelected,
          ),
          Expanded(
            child: Column(
              children: [
                _DesktopTopBar(fontFamily: fontFamily),
                Expanded(
                  child: IndexedStack(
                    index: _currentIndex,
                    children: _pages,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // ⌘1–⌘5 (or Ctrl+1–5) to jump between tabs — classic desktop shortcut.
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.digit1, meta: true):
            const _SwitchTabIntent(0),
        const SingleActivator(LogicalKeyboardKey.digit2, meta: true):
            const _SwitchTabIntent(1),
        const SingleActivator(LogicalKeyboardKey.digit3, meta: true):
            const _SwitchTabIntent(2),
        const SingleActivator(LogicalKeyboardKey.digit4, meta: true):
            const _SwitchTabIntent(3),
        const SingleActivator(LogicalKeyboardKey.digit5, meta: true):
            const _SwitchTabIntent(4),
        const SingleActivator(LogicalKeyboardKey.digit1, control: true):
            const _SwitchTabIntent(0),
        const SingleActivator(LogicalKeyboardKey.digit2, control: true):
            const _SwitchTabIntent(1),
        const SingleActivator(LogicalKeyboardKey.digit3, control: true):
            const _SwitchTabIntent(2),
        const SingleActivator(LogicalKeyboardKey.digit4, control: true):
            const _SwitchTabIntent(3),
        const SingleActivator(LogicalKeyboardKey.digit5, control: true):
            const _SwitchTabIntent(4),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _SwitchTabIntent: CallbackAction<_SwitchTabIntent>(
            onInvoke: (intent) {
              _onTabSelected(intent.index);
              return null;
            },
          ),
        },
        child: Focus(autofocus: true, child: scaffold),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // MOBILE LAYOUT (original)
  // ═══════════════════════════════════════════════════════════════════

  Widget _buildMobileLayout(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final inactiveColor = c.iconDefault;

    final List<_BottomNavItem> navItems = [
      _BottomNavItem(
        icon: SvgPicture.asset(
          Assets.iconsRootHome,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(inactiveColor, BlendMode.srcIn),
        ),
        activeIcon: SvgPicture.asset(
          Assets.iconsRootHome,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
        ),
        label: l10n.home,
      ),
      _BottomNavItem(
        icon: SvgPicture.asset(
          Assets.iconsRootPatient,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(inactiveColor, BlendMode.srcIn),
        ),
        activeIcon: SvgPicture.asset(
          Assets.iconsRootPatient,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
        ),
        label: l10n.patients,
      ),
      _BottomNavItem(
        icon: SvgPicture.asset(
          Assets.iconsRootAppointment,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(inactiveColor, BlendMode.srcIn),
        ),
        activeIcon: SvgPicture.asset(
          Assets.iconsRootAppointment,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
        ),
        label: l10n.appointments,
      ),
      _BottomNavItem(
        icon: SvgPicture.asset(
          Assets.iconsRootMoney,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(inactiveColor, BlendMode.srcIn),
        ),
        activeIcon: SvgPicture.asset(
          Assets.iconsRootMoney,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
        ),
        label: l10n.expenses,
      ),
      _BottomNavItem(
        icon: SvgPicture.asset(
          Assets.iconsRootMenu,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(inactiveColor, BlendMode.srcIn),
        ),
        activeIcon: SvgPicture.asset(
          Assets.iconsRootMenu,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
        ),
        label: l10n.more,
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: c.surfaceBg,
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 70.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                navItems.length,
                (index) => _buildMobileNavItem(index, navItems),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(int index, List<_BottomNavItem> navItems) {
    final item = navItems[index];
    final isSelected = _currentIndex == index;
    final c = ColorManager.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabSelected(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24.w,
                height: 24.w,
                child: isSelected ? item.activeIcon : item.icon,
              ),
              SizedBox(height: 4.h),
              Text(
                item.label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 9.sp,
                  color: isSelected
                      ? ColorManager.primary
                      : c.textTertiary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
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
    final userStorage = getIt<UserStorage>();
    final userName = userStorage.getFirstName() ?? '';
    final clinicName = userStorage.getClinicName() ?? '';

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: c.cardBg,
        border: Border(
          bottom: BorderSide(color: c.borderLight),
        ),
      ),
      child: Row(
        children: [
          // Welcome + clinic (same as mobile header)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName.isNotEmpty
                    ? '${AppLocalizations.of(context)!.welcomeBack}, $userName'
                    : AppLocalizations.of(context)!.welcomeBack,
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

          // Notification bell
          IconButton(
            onPressed: () => context.pushNamed(AppRoutesNames.notifications),
            icon: Stack(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: c.textSecondary,
                  size: 22,
                ),
                Positioned(
                  right: 1,
                  top: 1,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            tooltip: AppLocalizations.of(context)!.notifications,
          ),

          const SizedBox(width: 8),

          // Profile avatar + name
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

// ═══════════════════════════════════════════════════════════════════════
// DATA CLASSES / INTENTS
// ═══════════════════════════════════════════════════════════════════════

class _SwitchTabIntent extends Intent {
  final int index;
  const _SwitchTabIntent(this.index);
}

class _BottomNavItem {
  final Widget icon;
  final Widget activeIcon;
  final String label;

  const _BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
