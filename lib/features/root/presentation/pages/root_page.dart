import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/assets.gen.dart';
import 'package:dental_clinic_app/features/home/presentation/pages/home_page.dart';
import 'package:dental_clinic_app/features/payments/presentation/pages/payments_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/patients_list_page.dart';
import 'package:dental_clinic_app/features/appointments/presentation/pages/appointments_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/more_menu_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const PatientsListPage(),
    const AppointmentsPage(),
    const PaymentsPage(),
    MenuPage(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<_BottomNavItem> _navItems = [
      _BottomNavItem(
        icon: SvgPicture.asset(
          Assets.iconsRootHome,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(ColorManager.darkGrey, BlendMode.srcIn),
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
          colorFilter: ColorFilter.mode(ColorManager.darkGrey, BlendMode.srcIn),
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
          colorFilter: ColorFilter.mode(ColorManager.darkGrey, BlendMode.srcIn),
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
          Assets.iconsRootStatistics,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(ColorManager.darkGrey, BlendMode.srcIn),
        ),
        activeIcon: SvgPicture.asset(
          Assets.iconsRootStatistics,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
        ),
        label: l10n.payments,
      ),
      _BottomNavItem(
        icon: SvgPicture.asset(
          Assets.iconsRootMenu,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(ColorManager.darkGrey, BlendMode.srcIn),
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
          color: ColorManager.white,
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
                _navItems.length,
                (index) => _buildNavItem(index, _navItems),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, List<_BottomNavItem> navItems) {
    final item = navItems[index];
    final isSelected = _currentIndex == index;

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
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 10.sp,
                  color: isSelected
                      ? ColorManager.primary
                      : ColorManager.gray500,
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
