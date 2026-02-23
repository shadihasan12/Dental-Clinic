import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/localization/language_bloc.dart';
import 'package:dental_clinic_app/features/profile/presentation/widgets/language_settings_dialog.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // — Profile header
            _buildProfileHeader(context),
            Divider(height: 1, color: Colors.grey.shade200),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),

                  // — Account Settings
                  _sectionLabel(context, l10n.accountSettings),
                  SizedBox(height: 10.h),
                  _buildMenuGroup(context, [
                    MenuItem(
                      icon: Icons.person_outline,
                      title: l10n.editProfile,
                      onTap: () {
                        context.pushNamed(AppRoutesNames.editProfile);
                      },
                    ),
                    MenuItem(
                      icon: Icons.business_outlined,
                      title: l10n.clinicInformation,
                      onTap: () {
                        context.pushNamed(AppRoutesNames.clinicInfo);
                      },
                    ),
                    MenuItem(
                      icon: Icons.bar_chart_rounded,
                      title: l10n.analytics,
                      onTap: () => context.pushNamed(AppRoutesNames.statistics),
                    ),
                    MenuItem(
                      icon: Icons.notifications_outlined,
                      title: l10n.notifications,
                      trailing: _buildNotificationBadge(context),
                      onTap: () {
                        context.pushNamed(AppRoutesNames.notificationsSettings);
                      },
                    ),
                  ]),
                  SizedBox(height: 24.h),

                  // — App Settings
                  _sectionLabel(context, l10n.appSettings),
                  SizedBox(height: 10.h),
                  _buildMenuGroup(context, [
                    MenuItem(
                      icon: Icons.color_lens_outlined,
                      title: l10n.appearance,
                      subtitle: l10n.lightMode,
                      onTap: () {},
                    ),
                    MenuItem(
                      icon: Icons.language_outlined,
                      title: l10n.language,
                      subtitle:
                          context
                                  .read<LanguageBloc>()
                                  .state
                                  .locale
                                  .languageCode ==
                              'ar'
                          ? l10n.arabic
                          : l10n.english,
                      onTap: () => showLanguageSettingsDialog(context),
                    ),
                    MenuItem(
                      icon: Icons.security_outlined,
                      title: l10n.privacySecurity,
                      onTap: () {},
                    ),
                  ]),
                  SizedBox(height: 24.h),

                  // — Support
                  _sectionLabel(context, l10n.support),
                  SizedBox(height: 10.h),
                  _buildMenuGroup(context, [
                    // TODO: Add help center page and uncomment this
                    // MenuItem(
                    //   icon: Icons.help_outline,
                    //   title: l10n.helpCenter,
                    //   onTap: () {
                    //   },
                    // ),
                    MenuItem(
                      icon: Icons.chat_bubble_outline,
                      title: l10n.contactSupport,
                      onTap: () {
                        context.pushNamed(AppRoutesNames.contactSupport);

                      },
                    ),
                    MenuItem(
                      icon: Icons.description_outlined,
                      title: l10n.termsPrivacy,
                      onTap: () {},
                    ),
                  ]),
                  SizedBox(height: 24.h),

                  // — Logout
                  _buildLogoutRow(context, l10n),
                  SizedBox(height: 32.h),

                  // — Version
                  Center(
                    child: Text(
                      '${l10n.version} 1.0.0',
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 12.sp,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
        fontFamily: FontHelper.fontFamily(context),
      ),
    );
  }

  // ─── Profile Header ─────────────────────────────────────────────────────

  Widget _buildProfileHeader(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 28.r,
              backgroundColor: ColorManager.primary.withValues(alpha: 0.1),
              child: Icon(
                Icons.person,
                size: 28.w,
                color: ColorManager.primary,
              ),
            ),
            SizedBox(width: 14.w),

            // Name + role
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. Sarah Johnson',
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2D2D2D),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    AppLocalizations.of(context)!.dentist,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 13.sp,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Menu Groups ────────────────────────────────────────────────────────

  Widget _buildMenuGroup(BuildContext context, List<MenuItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Column(
            children: [
              _buildMenuItem(context, item),
              if (index < items.length - 1)
                Padding(
                  padding: EdgeInsets.only(left: 56.w),
                  child: Divider(height: 1, color: Colors.grey.shade200),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
          child: Row(
            children: [
              Container(
                width: 34.w,
                height: 34.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(item.icon, size: 18.w, color: Colors.black45),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    if (item.subtitle != null) ...[
                      SizedBox(height: 1.h),
                      Text(
                        item.subtitle!,
                        style: TextStyle(
                          fontFamily: FontHelper.fontFamily(context),
                          fontSize: 12.sp,
                          color: Colors.black38,
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
                  size: 18.w,
                  color: Colors.grey.shade400,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Notification Badge ─────────────────────────────────────────────────

  Widget _buildNotificationBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        '3',
        style: TextStyle(
          fontFamily: FontHelper.fontFamily(context),
          fontSize: 11.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ─── Logout ─────────────────────────────────────────────────────────────

  Widget _buildLogoutRow(BuildContext context, AppLocalizations l10n) {
    return GestureDetector(
      onTap: () => _showLogoutDialog(context, l10n),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.logout, size: 18.w, color: Colors.red.shade400),
            ),
            SizedBox(width: 12.w),
            Text(
              l10n.logout,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.red.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          l10n.logout,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            fontFamily: FontHelper.fontFamily(context),
          ),
        ),
        content: Text(
          l10n.areYouSureLogout,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontFamily: FontHelper.fontFamily(context),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              l10n.cancel,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.goNamed(AppRoutesNames.login);
            },
            child: Text(
              l10n.logout,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
              ),
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
