import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/core/localization/language_bloc.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/core/theme/theme_bloc.dart';
import 'package:dental_clinic_app/features/profile/presentation/widgets/language_settings_dialog.dart';
import 'package:dental_clinic_app/features/profile/presentation/widgets/theme_settings_dialog.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    UserStorage.profileUpdateNotifier.addListener(_onProfileUpdated);
  }

  @override
  void dispose() {
    UserStorage.profileUpdateNotifier.removeListener(_onProfileUpdated);
    super.dispose();
  }

  void _onProfileUpdated() => setState(() {});

  String _getThemeLabel(AppLocalizations l10n) {
    final mode = getIt<ThemeBloc>().state.themeMode;
    switch (mode) {
      case ThemeMode.dark:
        return l10n.darkMode;
      case ThemeMode.light:
        return l10n.lightMode;
      case ThemeMode.system:
        return l10n.systemDefault;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return _buildDesktop(context);
    }
    return _buildMobile(context);
  }

  // ═════════════════════════════════════════════════════════════════════
  // MOBILE
  // ═════════════════════════════════════════════════════════════════════

  Widget _buildMobile(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final userStorage = getIt<UserStorage>();
    final fullName = userStorage.getUserName() ?? '';
    final profileImageUrl = userStorage.getProfileImageUrl();

    final c = ColorManager.of(context);
    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // — Profile header
            _buildProfileHeader(context, fullName, profileImageUrl),
            Divider(height: 1, color: c.divider),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),

                  // — Account Settings
                  _sectionLabel(context, l10n.accountSettings),
                  SizedBox(height: 10.h),
                  _buildMenuGroup(context, _accountItems(context, l10n)),
                  SizedBox(height: 24.h),

                  // — App Settings
                  _sectionLabel(context, l10n.appSettings),
                  SizedBox(height: 10.h),
                  _buildMenuGroup(context, _appSettingsItems(context, l10n)),
                  SizedBox(height: 24.h),

                  // — Support
                  _sectionLabel(context, l10n.support),
                  SizedBox(height: 10.h),
                  _buildMenuGroup(context, _supportItems(context, l10n)),
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
                        color: ColorManager.of(context).textSubtle,
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

  // ═════════════════════════════════════════════════════════════════════
  // DESKTOP
  // ═════════════════════════════════════════════════════════════════════

  Widget _buildDesktop(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final userStorage = getIt<UserStorage>();
    final fullName = userStorage.getUserName() ?? '';
    final profileImageUrl = userStorage.getProfileImageUrl();

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDesktopProfileHero(context, fullName, profileImageUrl),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left column: Account Settings (wider)
                    Expanded(
                      flex: 3,
                      child: _buildDesktopSectionCard(
                        context: context,
                        icon: Icons.manage_accounts_outlined,
                        title: l10n.accountSettings,
                        items: _accountItems(context, l10n),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Right column: App Settings + Support + Logout + Version
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDesktopSectionCard(
                            context: context,
                            icon: Icons.tune_outlined,
                            title: l10n.appSettings,
                            items: _appSettingsItems(context, l10n),
                          ),
                          const SizedBox(height: 20),
                          _buildDesktopSectionCard(
                            context: context,
                            icon: Icons.support_agent_outlined,
                            title: l10n.support,
                            items: _supportItems(context, l10n),
                          ),
                          const SizedBox(height: 20),
                          _buildDesktopLogoutCard(context, l10n),
                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              '${l10n.version} 1.0.0',
                              style: TextStyle(
                                fontFamily: FontHelper.fontFamily(context),
                                fontSize: 12,
                                color: c.textSubtle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Desktop: Profile Hero ──────────────────────────────────────────────

  Widget _buildDesktopProfileHero(
    BuildContext context,
    String fullName,
    String? profileImageUrl,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(28, 26, 28, 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  ColorManager.primary.withValues(alpha: 0.22),
                  ColorManager.primary.withValues(alpha: 0.10),
                ]
              : [
                  ColorManager.primary,
                  ColorManager.primary.withValues(alpha: 0.75),
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: isDark ? 0.12 : 0.22),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar with soft ring
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.35),
            ),
            child: CircleAvatar(
              radius: 42,
              backgroundColor: Colors.white,
              backgroundImage:
                  (profileImageUrl != null && profileImageUrl.isNotEmpty)
                      ? NetworkImage(profileImageUrl)
                      : null,
              child: (profileImageUrl == null || profileImageUrl.isEmpty)
                  ? Icon(Icons.person,
                      size: 42, color: ColorManager.primary)
                  : null,
            ),
          ),
          const SizedBox(width: 24),

          // Name + role + edit button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName.isNotEmpty ? fullName : 'Doctor',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.medical_services_outlined,
                              size: 13, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            l10n.dentist,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Edit Profile button
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () => context.pushNamed(AppRoutesNames.editProfile),
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit_outlined,
                        size: 16, color: ColorManager.primary),
                    const SizedBox(width: 8),
                    Text(
                      l10n.editProfile,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Desktop: Section Card ──────────────────────────────────────────────

  Widget _buildDesktopSectionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required List<MenuItem> items,
  }) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 17, color: ColorManager.primary),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: c.divider),
          // Items
          ...items.asMap().entries.map((entry) {
            final idx = entry.key;
            final item = entry.value;
            return Column(
              children: [
                _buildDesktopMenuItem(context, item),
                if (idx < items.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 66),
                    child: Divider(height: 1, color: c.divider),
                  ),
              ],
            );
          }),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildDesktopMenuItem(BuildContext context, MenuItem item) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        hoverColor: ColorManager.primary.withValues(alpha: 0.04),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: c.menuIconBg,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: c.borderLight),
                ),
                child: Icon(item.icon, size: 18, color: c.iconDefault),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: c.textPrimary,
                      ),
                    ),
                    if (item.subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle!,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 12,
                          color: c.textTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (item.trailing != null)
                item.trailing!
              else
                Icon(Icons.chevron_right, size: 18, color: c.textSubtle),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLogoutCard(
      BuildContext context, AppLocalizations l10n) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    return Material(
      color: c.errorBg,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () => _showLogoutDialog(context, l10n),
        borderRadius: BorderRadius.circular(14),
        hoverColor: ColorManager.error.withValues(alpha: 0.08),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: c.menuIconBg,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(Icons.logout,
                    size: 18, color: ColorManager.error),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  l10n.logout,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.error,
                  ),
                ),
              ),
              Icon(Icons.chevron_right,
                  size: 18, color: ColorManager.error.withValues(alpha: 0.6)),
            ],
          ),
        ),
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════
  // SHARED MENU ITEM DEFINITIONS (same navigation/APIs on both layouts)
  // ═════════════════════════════════════════════════════════════════════

  List<MenuItem> _accountItems(BuildContext context, AppLocalizations l10n) => [
        MenuItem(
          icon: Icons.person_outline,
          title: l10n.editProfile,
          onTap: () => context.pushNamed(AppRoutesNames.editProfile),
        ),
        MenuItem(
          icon: Icons.business_outlined,
          title: l10n.clinicInformation,
          onTap: () => context.pushNamed(AppRoutesNames.clinicInfo),
        ),
        MenuItem(
          icon: Icons.people_outlined,
          title: l10n.clinicUsers,
          onTap: () {
            final clinicId = getIt<UserStorage>().getSelectedClinicId() ?? '';
            context.pushNamed(
              AppRoutesNames.clinicUsers,
              extra: clinicId,
            );
          },
        ),
        MenuItem(
          icon: Icons.schedule_outlined,
          title: l10n.workingHoursAndHolidays,
          onTap: () => context.pushNamed(AppRoutesNames.workingHours),
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
          onTap: () => context.pushNamed(AppRoutesNames.notificationsSettings),
        ),
      ];

  List<MenuItem> _appSettingsItems(
          BuildContext context, AppLocalizations l10n) =>
      [
        MenuItem(
          icon: Icons.color_lens_outlined,
          title: l10n.appearance,
          subtitle: _getThemeLabel(l10n),
          onTap: () => showThemeSettingsDialog(context),
        ),
        MenuItem(
          icon: Icons.language_outlined,
          title: l10n.language,
          subtitle: context.read<LanguageBloc>().state.locale.languageCode ==
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
      ];

  List<MenuItem> _supportItems(BuildContext context, AppLocalizations l10n) => [
        MenuItem(
          icon: Icons.chat_bubble_outline,
          title: l10n.contactSupport,
          onTap: () => context.pushNamed(AppRoutesNames.contactSupport),
        ),
        MenuItem(
          icon: Icons.description_outlined,
          title: l10n.termsPrivacy,
          onTap: () {},
        ),
      ];

  Widget _sectionLabel(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: ColorManager.of(context).textSecondary,
        fontFamily: FontHelper.fontFamily(context),
      ),
    );
  }

  // ─── Profile Header ─────────────────────────────────────────────────────

  Widget _buildProfileHeader(
    BuildContext context,
    String fullName,
    String? profileImageUrl,
  ) {
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
              backgroundImage:
                  profileImageUrl != null && profileImageUrl.isNotEmpty
                  ? NetworkImage(profileImageUrl)
                  : null,
              child: profileImageUrl == null || profileImageUrl.isEmpty
                  ? Icon(Icons.person, size: 28.w, color: ColorManager.primary)
                  : null,
            ),
            SizedBox(width: 14.w),

            // Name + role
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName.isNotEmpty ? fullName : 'Doctor',
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.of(context).textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    AppLocalizations.of(context)!.dentist,
                    style: TextStyle(
                      fontFamily: FontHelper.fontFamily(context),
                      fontSize: 13.sp,
                      color: ColorManager.of(context).textTertiary,
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
    final c = ColorManager.of(context);
    return Container(
      decoration: BoxDecoration(
        color: c.menuGroupBg,
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
                  child: Divider(height: 1, color: c.divider),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    final c = ColorManager.of(context);
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
                  color: c.menuIconBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(item.icon, size: 18.w, color: c.iconDefault),
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
                        color: c.textPrimary,
                      ),
                    ),
                    if (item.subtitle != null) ...[
                      SizedBox(height: 1.h),
                      Text(
                        item.subtitle!,
                        style: TextStyle(
                          fontFamily: FontHelper.fontFamily(context),
                          fontSize: 12.sp,
                          color: c.textTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (item.trailing != null)
                item.trailing!
              else
                Icon(Icons.chevron_right, size: 18.w, color: c.textSubtle),
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
    final c = ColorManager.of(context);
    return GestureDetector(
      onTap: () => _showLogoutDialog(context, l10n),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: c.errorBg,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                color: c.menuIconBg,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.logout, size: 18.w, color: ColorManager.error),
            ),
            SizedBox(width: 12.w),
            Text(
              l10n.logout,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: ColorManager.error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AppLocalizations l10n) {
    final c = ColorManager.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          l10n.logout,
          style: TextStyle(
            color: ColorManager.error,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            fontFamily: FontHelper.fontFamily(context),
          ),
        ),
        content: Text(
          l10n.areYouSureLogout,
          style: TextStyle(
            color: c.textPrimary,
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
                color: c.textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                fontFamily: FontHelper.fontFamily(context),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await getIt<TokenStorage>().clearAuthData();
              await getIt<UserStorage>().clear();
              if (context.mounted) {
                context.goNamed(AppRoutesNames.login);
              }
            },
            child: Text(
              l10n.logout,
              style: TextStyle(
                color: ColorManager.error,
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
