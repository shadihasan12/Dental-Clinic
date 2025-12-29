import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:dental_clinic_app/features/patients/presentation/pages/patients_list_page.dart';
import 'package:dental_clinic_app/features/appointments/presentation/pages/appointments_page.dart';
import 'package:dental_clinic_app/features/statistics/presentation/pages/statistics_page.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/more_menu_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    PatientsListPage(),
    AppointmentsPage(),
    StatisticsPage(),
    MoreMenuPage(),
  ];

  final List<_BottomNavItem> _navItems = const [
    _BottomNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    _BottomNavItem(
      icon: Icons.groups_outlined,
      activeIcon: Icons.groups,
      label: 'Patients',
    ),
    _BottomNavItem(
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_today,
      label: 'Schedule',
    ),
    _BottomNavItem(
      icon: Icons.bar_chart_outlined,
      activeIcon: Icons.bar_chart,
      label: 'Stats',
    ),
    _BottomNavItem(
      icon: Icons.menu,
      activeIcon: Icons.menu,
      label: 'More',
    ),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
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
                (index) => _buildNavItem(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final item = _navItems[index];
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
              Icon(
                isSelected ? item.activeIcon : item.icon,
                size: 24.w,
                color: isSelected ? ColorManager.primary : ColorManager.gray400,
              ),
              SizedBox(height: 4.h),
              Text(
                item.label,
                style: TextStyleManager.labelSmall.copyWith(
                  color: isSelected ? ColorManager.primary : ColorManager.gray500,
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
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
