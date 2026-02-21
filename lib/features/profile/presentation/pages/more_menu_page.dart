import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/user_subscription_entity.dart';
import 'package:dental_clinic_app/features/subscription/presentation/widgets/subscription_status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/gradient_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';

class MoreMenuPage extends StatelessWidget {
  MoreMenuPage({super.key});

  final UserSubscriptionEntity subscription = UserSubscriptionEntity(
    id: 'sub_123',
    userId: 'user_123',
    planTier: PlanTier.trial,
    status: SubscriptionStatus.trial,
    billingCycle: BillingCycle.monthly,
    startDate: DateTime.now(),
    currentPeriodEnd: DateTime.now().add(const Duration(days: 7)),
    trialEndDate: DateTime.now().add(const Duration(days: 7)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            Padding(
              padding: PaddingManager.all16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Stats
                  _buildUserStats(),
                  SizedBox(height: 24.h),

                  // Subscription status card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SubscriptionStatusCard(
                      subscription: subscription,
                      onUpgrade: () {
                        context.pushNamed(AppRoutesNames.pricing);
                      },
                      onManage: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Manage subscription coming soon'),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Account Settings
                  _buildSectionTitle('Account Settings'),
                  SizedBox(height: 12.h),
                  _buildMenuGroup([
                    MenuItem(
                      icon: Icons.person_outline,
                      title: 'Edit Profile',
                      onTap: () {},
                    ),
                    MenuItem(
                      icon: Icons.business_outlined,
                      title: 'Clinic Information',
                      onTap: () {},
                    ),
                    MenuItem(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      trailing: _buildNotificationBadge(),
                      onTap: () {},
                    ),
                  ]),
                  SizedBox(height: 24.h),

                  // App Settings
                  _buildSectionTitle('App Settings'),
                  SizedBox(height: 12.h),
                  _buildMenuGroup([
                    MenuItem(
                      icon: Icons.color_lens_outlined,
                      title: 'Appearance',
                      subtitle: 'Light mode',
                      onTap: () {},
                    ),
                    MenuItem(
                      icon: Icons.language_outlined,
                      title: 'Language',
                      subtitle: 'English',
                      onTap: () {},
                    ),
                    MenuItem(
                      icon: Icons.security_outlined,
                      title: 'Privacy & Security',
                      onTap: () {},
                    ),
                  ]),
                  SizedBox(height: 24.h),

                  // Support
                  _buildSectionTitle('Support'),
                  SizedBox(height: 12.h),
                  _buildMenuGroup([
                    MenuItem(
                      icon: Icons.help_outline,
                      title: 'Help Center',
                      onTap: () {},
                    ),
                    MenuItem(
                      icon: Icons.chat_bubble_outline,
                      title: 'Contact Support',
                      onTap: () {},
                    ),
                    MenuItem(
                      icon: Icons.description_outlined,
                      title: 'Terms & Privacy',
                      onTap: () {},
                    ),
                  ]),
                  SizedBox(height: 24.h),

                  // Logout
                  _buildLogoutButton(context),
                  SizedBox(height: 32.h),

                  // App Version
                  Center(
                    child: Text(
                      'Version 1.0.0',
                      style: TextStyleManager.bodySmall.copyWith(
                        color: ColorManager.textTertiary,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 60.h,
        left: 20.w,
        right: 20.w,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(
        gradient: GradientManager.primaryHeader,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: ColorManager.white,
              shape: BoxShape.circle,
              border: Border.all(color: ColorManager.white, width: 3),
            ),
            child: ClipOval(
              child: Icon(
                Icons.person,
                size: 40.w,
                color: ColorManager.primary,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          // Name
          Text(
            'Dr. Sarah Johnson',
            style: TextStyleManager.headlineMedium.copyWith(
              color: ColorManager.white,
            ),
          ),
          SizedBox(height: 4.h),
          // Role
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: ColorManager.white.withValues(alpha: 0.2),
              borderRadius: BorderRadiusManager.full,
            ),
            child: Text(
              'Dentist',
              style: TextStyleManager.labelMedium.copyWith(
                color: ColorManager.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStats() {
    return CustomCard(
      child: Row(
        children: [
          _buildStatItem('248', 'Patients'),
          _buildStatDivider(),
          _buildStatItem('1,245', 'Visits'),
          _buildStatDivider(),
          _buildStatItem('156', 'Cases'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyleManager.headlineMedium.copyWith(
              color: ColorManager.primary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyleManager.bodySmall.copyWith(
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(width: 1.w, height: 40.h, color: ColorManager.divider);
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyleManager.labelLarge.copyWith(
        color: ColorManager.textSecondary,
      ),
    );
  }

  Widget _buildMenuGroup(List<MenuItem> items) {
    return CustomCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Column(
            children: [
              _buildMenuItem(item),
              if (index < items.length - 1)
                Divider(height: 1.h, indent: 56.w, color: ColorManager.divider),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return Material(
      color: ColorManager.transparent,
      child: InkWell(
        onTap: item.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: ColorManager.gray100,
                  borderRadius: BorderRadiusManager.lg,
                ),
                child: Icon(
                  item.icon,
                  size: 20.w,
                  color: ColorManager.textSecondary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyleManager.titleSmall.copyWith(
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    if (item.subtitle != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        item.subtitle!,
                        style: TextStyleManager.bodySmall.copyWith(
                          color: ColorManager.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (item.trailing != null)
                item.trailing!
              else
                Icon(
                  Icons.chevron_right,
                  size: 20.w,
                  color: ColorManager.textTertiary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: ColorManager.error,
        borderRadius: BorderRadiusManager.full,
      ),
      child: Text(
        '3',
        style: TextStyleManager.labelSmall.copyWith(
          color: ColorManager.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.zero,
      child: Material(
        color: ColorManager.transparent,
        child: InkWell(
          onTap: () {
            _showLogoutDialog(context);
          },
          borderRadius: BorderRadiusManager.xl,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: ColorManager.errorBackground,
                    borderRadius: BorderRadiusManager.lg,
                  ),
                  child: Icon(
                    Icons.logout,
                    size: 20.w,
                    color: ColorManager.error,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Logout',
                    style: TextStyleManager.titleSmall.copyWith(
                      color: ColorManager.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.goNamed(AppRoutesNames.login);
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: ColorManager.error),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });
}
