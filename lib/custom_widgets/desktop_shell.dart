import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/gen/assets.gen.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

/// Wraps a page with the desktop side menu + top bar.
/// On mobile, just renders the [body] directly.
///
/// Use this for pages that navigate away from the root (patient details,
/// add patient, etc.) but should still show the shell on desktop.
class DesktopShell extends StatelessWidget {
  const DesktopShell({super.key, required this.body, this.title});

  final Widget body;
  final String? title;

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isDesktop(context)) return body;

    // Reconfigure screenutil for desktop
    ScreenUtil.configure(
      data: MediaQuery.of(context).copyWith(
        size: const Size(375, 812),
      ),
    );

    final fontFamily = FontHelper.fontFamily(context);

    return Scaffold(
      body: Row(
        children: [
          // Side menu
          _SideMenu(fontFamily: fontFamily),

          // Main area
          Expanded(
            child: Column(
              children: [
                _TopBar(fontFamily: fontFamily, title: title),
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// SIDE MENU
// ═══════════════════════════════════════════════════════════════════════

class _SideMenu extends StatelessWidget {
  const _SideMenu({required this.fontFamily});

  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    final items = [
      _NavItem(Assets.iconsRootHome, l10n.home),
      _NavItem(Assets.iconsRootPatient, l10n.patients),
      _NavItem(Assets.iconsRootAppointment, l10n.appointments),
      _NavItem(Assets.iconsRootMoney, l10n.expenses),
      _NavItem(Assets.iconsRootMenu, l10n.more),
    ];

    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: c.cardBg,
        border: Border(right: BorderSide(color: c.borderLight)),
      ),
      child: Column(
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorManager.primary10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.medical_services_rounded,
                    color: ColorManager.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'SmylOS',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 20,
                    fontWeight: FontWeightManager.bold,
                    color: c.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // Nav items (no selection since we're on a sub-page)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () => context.go('/'),
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              item.svgPath,
                              width: 20,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                c.iconDefault,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.label,
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeightManager.medium,
                                  color: c.textSecondary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// TOP BAR
// ═══════════════════════════════════════════════════════════════════════

class _TopBar extends StatelessWidget {
  const _TopBar({required this.fontFamily, this.title});

  final String fontFamily;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final userStorage = getIt<UserStorage>();
    final userName = userStorage.getFirstName() ?? '';

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: c.cardBg,
        border: Border(bottom: BorderSide(color: c.borderLight)),
      ),
      child: Row(
        children: [
          // Back + title
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 18, color: c.textPrimary),
            onPressed: () =>
                context.canPop() ? context.pop() : context.go('/'),
          ),
          if (title != null) ...[
            const SizedBox(width: 4),
            Text(
              title!,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 16,
                fontWeight: FontWeightManager.semiBold,
                color: c.textPrimary,
              ),
            ),
          ],

          const Spacer(),

          // Notification
          IconButton(
            onPressed: () => context.pushNamed(AppRoutesNames.notifications),
            icon: Stack(
              children: [
                Icon(Icons.notifications_outlined, color: c.textSecondary, size: 22),
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
          ),

          const SizedBox(width: 8),

          // Profile
          InkWell(
            onTap: () => context.pushNamed(AppRoutesNames.profile),
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

class _NavItem {
  final String svgPath;
  final String label;
  const _NavItem(this.svgPath, this.label);
}
