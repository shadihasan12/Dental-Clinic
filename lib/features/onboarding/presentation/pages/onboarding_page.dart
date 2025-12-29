import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      icon: Icons.people,
      badgeIcon: Icons.groups_outlined,
      title: 'Manage Patients\nEffortlessly',
      description:
          'Streamline patient management with automated case creation and comprehensive patient profiles',
    ),
    OnboardingItem(
      icon: Icons.calendar_today,
      badgeIcon: Icons.calendar_month_outlined,
      title: 'Smart Scheduling',
      description:
          'Easily manage appointments with intuitive calendar views and automated reminders',
    ),
    OnboardingItem(
      icon: Icons.description,
      badgeIcon: Icons.description_outlined,
      title: 'Interactive Treatment\nRecords',
      description:
          'Record treatments with our 2D teeth diagram for precise and visual treatment tracking',
      useToothIcon: true,
    ),
    OnboardingItem(
      icon: Icons.bar_chart,
      badgeIcon: Icons.trending_up,
      title: 'Insights & Analytics',
      description:
          'Track clinic performance with comprehensive statistics and payment management',
      useChartIcon: true,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    context.goNamed(AppRoutesNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.gray50,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _navigateToLogin,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyleManager.bodyLarge.copyWith(
                      color: ColorManager.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            // Page View - Takes remaining space
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _buildPage(_items[index], index);
                },
              ),
            ),

            // Page Indicators
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _items.length,
                  (index) => _buildIndicator(index == _currentPage),
                ),
              ),
            ),

            // Next Button
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
              child: SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    foregroundColor: ColorManager.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentPage == _items.length - 1 ? 'Get Started' : 'Next',
                        style: TextStyleManager.button.copyWith(
                          color: ColorManager.white,
                          fontSize: 16.sp,
                        ),
                      ),
                      if (_currentPage < _items.length - 1) ...[
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16.w,
                          color: ColorManager.white,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingItem item, int index) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate sizes based on available height
        final availableHeight = constraints.maxHeight;
        final cardSize = (availableHeight * 0.42).clamp(180.0, 260.0);

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),

                // Large Illustration Card
                Container(
                  width: cardSize,
                  height: cardSize,
                  decoration: BoxDecoration(
                    gradient: GradientManager.primaryHeader,
                    borderRadius: BorderRadius.circular(36.r),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.primary.withValues(alpha: 0.3),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Decorative circles
                      Positioned(
                        top: -15,
                        right: -15,
                        child: Container(
                          width: cardSize * 0.35,
                          height: cardSize * 0.35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.white.withValues(alpha: 0.1),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: cardSize * 0.15,
                        left: -20,
                        child: Container(
                          width: cardSize * 0.28,
                          height: cardSize * 0.28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.white.withValues(alpha: 0.08),
                          ),
                        ),
                      ),

                      // Inner card with icon
                      Center(
                        child: Container(
                          width: cardSize * 0.58,
                          height: cardSize * 0.58,
                          decoration: BoxDecoration(
                            color: ColorManager.primary.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(28.r),
                          ),
                          child: Center(
                            child: _buildMainIcon(item, index, cardSize),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Badge Icon
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    item.badgeIcon,
                    size: 24.w,
                    color: ColorManager.white,
                  ),
                ),

                SizedBox(height: 24.h),

                // Title
                Text(
                  item.title,
                  style: TextStyleManager.headlineSmall.copyWith(
                    color: ColorManager.textPrimary,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 12.h),

                // Description
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    item.description,
                    style: TextStyleManager.bodyMedium.copyWith(
                      color: ColorManager.textSecondary,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainIcon(OnboardingItem item, int index, double cardSize) {
    final iconSize = cardSize * 0.3;

    if (item.useToothIcon == true) {
      return Text(
        '🦷',
        style: TextStyle(fontSize: iconSize * 0.9),
      );
    } else if (item.useChartIcon == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildChartBar(iconSize * 0.65, Colors.green),
          SizedBox(width: 8.w),
          _buildChartBar(iconSize * 0.95, Colors.blue),
          SizedBox(width: 8.w),
          _buildChartBar(iconSize * 0.8, Colors.red.shade400),
        ],
      );
    } else if (index == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: iconSize * 0.85,
            color: ColorManager.primaryDark,
          ),
          Transform.translate(
            offset: Offset(-iconSize * 0.25, 0),
            child: Icon(
              Icons.person,
              size: iconSize * 0.85,
              color: ColorManager.primaryDarker,
            ),
          ),
        ],
      );
    } else {
      return Icon(
        item.icon,
        size: iconSize,
        color: ColorManager.white,
      );
    }
  }

  Widget _buildChartBar(double height, Color color) {
    return Container(
      width: 20.w,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: isActive ? 28.w : 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        color: isActive ? ColorManager.primary : ColorManager.gray300,
        borderRadius: BorderRadiusManager.full,
      ),
    );
  }
}

class OnboardingItem {
  final IconData icon;
  final IconData badgeIcon;
  final String title;
  final String description;
  final bool? useToothIcon;
  final bool? useChartIcon;

  OnboardingItem({
    required this.icon,
    required this.badgeIcon,
    required this.title,
    required this.description,
    this.useToothIcon,
    this.useChartIcon,
  });
}
