import 'dart:async';

import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/utils/role_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/constants/legal_urls.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/widgets/directional_chevron.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/core/storage/token_storage.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/core/localization/language_bloc.dart';
import 'package:dental_clinic_app/core/session/session_manager.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_bloc.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:dental_clinic_app/core/theme/theme_bloc.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/use_cases/get_subscription_status_use_case.dart';
import 'package:dental_clinic_app/features/subscription/domain/use_cases/get_subscription_usage_use_case.dart';
import 'package:dental_clinic_app/features/subscription/presentation/widgets/subscription_card.dart';
import 'package:dental_clinic_app/features/profile/presentation/widgets/language_settings_dialog.dart';
import 'package:dental_clinic_app/features/profile/presentation/widgets/legal_links.dart';
import 'package:dental_clinic_app/features/profile/presentation/widgets/theme_settings_dialog.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  SubscriptionStatusEntity? _subscriptionStatus;
  SubscriptionUsageEntity? _subscriptionUsage;
  bool _subscriptionLoading = true;
  StreamSubscription<ClinicPermissionsState>? _permissionsSub;
  bool _couldManageBilling = SubscriptionGuardHelper.canManageBilling;

  @override
  void initState() {
    super.initState();
    UserStorage.profileUpdateNotifier.addListener(_onProfileUpdated);
    // The subscription section follows the permissions list, which may land
    // (or change, on a refresh) after this page is already open.
    _permissionsSub = getIt<ClinicPermissionsBloc>().stream.listen((_) {
      final can = SubscriptionGuardHelper.canManageBilling;
      if (can == _couldManageBilling || !mounted) return;
      _couldManageBilling = can;
      setState(() => _subscriptionLoading = can);
      if (can) _loadSubscription();
    });
    _loadSubscription();
  }

  /// The plan and what is left of it, for the card at the top of the page.
  ///
  /// Both calls are skipped when billing is off, since nothing renders them
  /// then - the same reason Home used to skip them.
  Future<void> _loadSubscription() async {
    // Every subscription call is behind a feature granted to admins only;
    // anyone else would just collect a 403.
    if (!SubscriptionGuardHelper.canManageBilling) {
      if (mounted) setState(() => _subscriptionLoading = false);
      return;
    }

    final statusFuture = getIt<GetSubscriptionStatusUseCase>()(NoParams());
    final usageFuture = getIt<GetSubscriptionUsageUseCase>()(NoParams());

    final statusResult = await statusFuture;
    final usageResult = await usageFuture;
    if (!mounted) return;

    setState(() {
      statusResult.fold(
        (_) => _subscriptionStatus = null,
        (value) => _subscriptionStatus = value,
      );
      usageResult.fold(
        (_) => _subscriptionUsage = null,
        (value) => _subscriptionUsage = value,
      );
      _subscriptionLoading = false;
    });
  }

  @override
  void dispose() {
    _permissionsSub?.cancel();
    UserStorage.profileUpdateNotifier.removeListener(_onProfileUpdated);
    super.dispose();
  }

  void _onProfileUpdated() => setState(() {});

  /// The card and the menu row both land on the subscription screen, and
  /// the card is re-read on the way back - a request or a report there can
  /// change what it says.
  Future<void> _openSubscription() async {
    await context.pushNamed(AppRoutesNames.billing);
    if (mounted) _loadSubscription();
  }

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

  /// The menu as data, so the mobile column and the desktop grid render the
  /// same sections in the same order and a new section only has to be added
  /// once.
  List<({String label, List<MenuItem> items})> _sections(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return [
      (
        label: l10n.accountSettings,
        items: _buildAccountItems(
          context,
          l10n,
          isAdmin: getIt<UserStorage>().isAdmin,
        ),
      ),
      (
        label: l10n.appSettings,
        items: [
          MenuItem(
            icon: Icons.color_lens_outlined,
            title: l10n.appearance,
            subtitle: _getThemeLabel(l10n),
            onTap: () => showThemeSettingsDialog(context),
          ),
          MenuItem(
            icon: Icons.language_outlined,
            title: l10n.language,
            subtitle:
                context.read<LanguageBloc>().state.locale.languageCode == 'ar'
                ? l10n.arabic
                : l10n.english,
            onTap: () => showLanguageSettingsDialog(context),
          ),
        ],
      ),
      (
        label: l10n.support,
        items: [
          // TODO: Add help center page and uncomment this
          // MenuItem(
          //   icon: Icons.help_outline,
          //   title: l10n.helpCenter,
          //   onTap: () {
          //   },
          // ),
          MenuItem(
            icon: Icons.report_problem_outlined,
            title: l10n.reportIssue,
            onTap: () {
              context.pushNamed(AppRoutesNames.reportIssue);
            },
          ),
        ],
      ),
      (
        // Both stores require these to be reachable from inside the app, not
        // just from the store listing.
        label: l10n.legal,
        items: [
          MenuItem(
            icon: Icons.privacy_tip_outlined,
            title: l10n.privacyPolicy,
            trailing: _externalLinkIcon(context),
            onTap: () => openLegalUrl(context, LegalUrls.privacyPolicy),
          ),
          MenuItem(
            icon: Icons.description_outlined,
            title: l10n.termsOfService,
            trailing: _externalLinkIcon(context),
            onTap: () => openLegalUrl(context, LegalUrls.termsOfService),
          ),
        ],
      ),
    ];
  }

  /// The plan card at the top of the page, on both form factors. Callers
  /// gate it on [SubscriptionGuardHelper.canManageBilling].
  Widget _buildSubscriptionCard() {
    return SubscriptionCard(
      status: _subscriptionStatus,
      usage: _subscriptionUsage,
      isLoading: _subscriptionLoading,
      onViewPlans: _openSubscription,
      onUpgrade: _openSubscription,
    );
  }

  Widget _versionLabel(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Text(
        '${l10n.version} 1.0.0',
        style: TextStyle(
          fontFamily: FontHelper.fontFamily(context),
          fontSize: 11.sp,
          color: ColorManager.of(context).textSubtle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final userStorage = getIt<UserStorage>();
    final fullName = userStorage.getUserName() ?? '';
    final profileImageUrl = userStorage.getProfileImageUrl();
    final c = ColorManager.of(context);
    final sections = _sections(context, l10n);

    if (Responsive.isDesktop(context)) {
      return _buildDesktop(
        context,
        l10n,
        c,
        fullName,
        profileImageUrl,
        sections,
      );
    }

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      appBar: PageHeader(title: l10n.settings, onBack: () => context.pop()),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          14.w,
          12.h,
          14.w,
          24.h + MediaQuery.viewPaddingOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context, fullName, profileImageUrl),
            SizedBox(height: 18.h),

            // — Subscription. First thing under the profile header: how long
            // the plan has left is the one status on this page that can stop
            // the clinic working, and unlike a menu row it says so without
            // being opened. No dismiss here - it is not in anyone's way.
            if (SubscriptionGuardHelper.canManageBilling) ...[
              _buildSubscriptionCard(),
              SizedBox(height: 18.h),
            ],

            for (final section in sections) ...[
              _sectionLabel(context, section.label),
              SizedBox(height: 8.h),
              _buildMenuGroup(context, section.items),
              SizedBox(height: 18.h),
            ],
            _buildLogoutRow(context, l10n),
            SizedBox(height: 24.h),
            _versionLabel(context, l10n),
            SizedBox(height: 18.h),
          ],
        ),
      ),
    );
  }

  /// Desktop reaches this page as the fifth side-nav tab rather than as a
  /// pushed route, so it gets no header and no back button - the side nav is
  /// the chrome. The sections tile into two columns instead of one long
  /// scroll, which is the whole point of the extra width.
  Widget _buildDesktop(
    BuildContext context,
    AppLocalizations l10n,
    AppColors c,
    String fullName,
    String? profileImageUrl,
    List<({String label, List<MenuItem> items})> sections,
  ) {
    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final twoColumn = width >= 1000;
          const contentMaxWidth = 1100.0;
          final outerPadding = width > contentMaxWidth
              ? (width - contentMaxWidth) / 2 + 32
              : 32.0;

          Widget group(({String label, List<MenuItem> items}) section) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionLabel(context, section.label),
                SizedBox(height: 8.h),
                _buildMenuGroup(context, section.items),
              ],
            );
          }

          Widget column(List<({String label, List<MenuItem> items})> items) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final section in items) ...[
                  group(section),
                  const SizedBox(height: 22),
                ],
              ],
            );
          }

          final left = <({String label, List<MenuItem> items})>[];
          final right = <({String label, List<MenuItem> items})>[];
          for (var i = 0; i < sections.length; i++) {
            (i.isEven ? left : right).add(sections[i]);
          }

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(outerPadding, 28, outerPadding, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildProfileHeader(context, fullName, profileImageUrl),
                const SizedBox(height: 28),
                // Same card and gate as mobile, spanning both columns so the
                // plan status reads before any section.
                if (SubscriptionGuardHelper.canManageBilling) ...[
                  _buildSubscriptionCard(),
                  const SizedBox(height: 28),
                ],
                if (!twoColumn)
                  column(sections)
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: column(left)),
                      const SizedBox(width: 24),
                      Expanded(child: column(right)),
                    ],
                  ),
                const SizedBox(height: 6),
                _buildLogoutRow(context, l10n),
                const SizedBox(height: 24),
                _versionLabel(context, l10n),
                const SizedBox(height: 18),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds the Account-Settings group, hiding the admin-only items
  /// (Clinic Info, Clinic Users, Working Days & Holidays) when the current
  /// user's role doesn't include them. The role is cached on login.
  List<MenuItem> _buildAccountItems(
    BuildContext context,
    AppLocalizations l10n, {
    required bool isAdmin,
  }) {
    return [
      MenuItem(
        icon: Icons.person_outline,
        title: l10n.editProfile,
        onTap: () => context.pushNamed(AppRoutesNames.editProfile),
      ),
      if (isAdmin) ...[
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
            context.pushNamed(AppRoutesNames.clinicUsers, extra: clinicId);
          },
        ),
        MenuItem(
          icon: Icons.schedule_outlined,
          title: l10n.workingDaysAndHolidays,
          onTap: () => context.pushNamed(AppRoutesNames.workingDays),
        ),
      ] else
        MenuItem(
          icon: Icons.schedule_outlined,
          title: l10n.myWorkingHours,
          onTap: () {
            final userId = getIt<TokenStorage>().getUserId() ?? '';
            if (userId.isEmpty) return;
            context.pushNamed(
              AppRoutesNames.userHours,
              pathParameters: {'userId': userId},
            );
          },
        ),
      MenuItem(
        icon: Icons.bar_chart_rounded,
        title: l10n.analytics,
        onTap: () => context.pushNamed(AppRoutesNames.statistics),
      ),
      // Built from the permissions list, not from `is_owner`: every
      // subscription and payment endpoint is behind a feature granted to the
      // ADMIN role, and anyone else gets 403 on all of them.
      if (SubscriptionGuardHelper.canManageBilling)
        MenuItem(
          icon: Icons.receipt_long_outlined,
          title: l10n.subscriptionPageTitle,
          onTap: _openSubscription,
        ),
      MenuItem(
        icon: Icons.notifications_outlined,
        title: l10n.notifications,
        onTap: () => context.pushNamed(AppRoutesNames.notificationsSettings),
      ),
      // Last in the group and in red. Both stores require account deletion
      // to be startable from inside the app, and it is an account setting -
      // burying it under Legal, where it used to be a link to a web form,
      // is what a reviewer looks for.
      MenuItem(
        icon: Icons.delete_outline,
        title: l10n.deleteAccount,
        subtitle: l10n.deleteAccountSubtitle,
        isDestructive: true,
        onTap: () => context.pushNamed(AppRoutesNames.deleteAccount),
      ),
    ];
  }

  Widget _sectionLabel(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: ColorManager.of(context).textPrimary,
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
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final hasImage = profileImageUrl != null && profileImageUrl.isNotEmpty;
    final roleLabel = clinicRoleLabelFromName(
      AppLocalizations.of(context)!,
      getIt<UserStorage>().getUserRole(),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: ColorManager.primary.withValues(alpha: 0.15),
            backgroundImage: hasImage ? NetworkImage(profileImageUrl) : null,
            child: hasImage
                ? null
                : Icon(
                    Icons.person,
                    size: 22.w,
                    color: ColorManager.primaryDarker,
                  ),
          ),
          SizedBox(width: 11.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName.isNotEmpty ? fullName : 'Doctor',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: family,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
                // The role the user actually holds in the active clinic, not
                // a fixed "Dentist" - a secretary was being shown as one.
                // Hidden entirely when no role is cached, which is honest
                // rather than guessing.
                if (roleLabel != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    roleLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: 11.sp,
                      color: c.textTertiary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Menu Groups ────────────────────────────────────────────────────────

  Widget _buildMenuGroup(BuildContext context, List<MenuItem> items) {
    final c = ColorManager.of(context);
    // Elevation is the hairline, not a fill: menuGroupBg is gray50 in the
    // light theme, the same value as the page, so the group had no edge at
    // all. Separators start where the label does, not at the card edge.
    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.borderLight),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Column(
            children: [
              _buildMenuItem(context, item),
              if (index < items.length - 1)
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 53.w),
                  child: Divider(height: 1, color: c.borderLight),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  /// Marks a row as leaving the app for the browser.
  Widget _externalLinkIcon(BuildContext context, {Color? color}) {
    return Icon(
      Icons.open_in_new,
      size: 16.w,
      color: color ?? ColorManager.of(context).textSubtle,
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    final c = ColorManager.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
          child: Row(
            children: [
              // Tinted tile in the brand hue; destructive rows take red.
              Container(
                width: 32.w,
                height: 32.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      (item.isDestructive
                              ? ColorManager.error
                              : ColorManager.primary)
                          .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Icon(
                  item.icon,
                  size: 17.w,
                  color: item.isDestructive
                      ? ColorManager.error
                      : ColorManager.primaryDarker,
                ),
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: FontHelper.fontFamily(context),
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                        color: item.isDestructive
                            ? ColorManager.error
                            : c.textPrimary,
                      ),
                    ),
                    if (item.subtitle != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        item.subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: FontHelper.fontFamily(context),
                          fontSize: 11.sp,
                          color: c.textTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              if (item.trailing != null)
                item.trailing!
              else
                DirectionalChevron(size: 18.w, color: c.textSubtle),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Logout ─────────────────────────────────────────────────────────────

  Widget _buildLogoutRow(BuildContext context, AppLocalizations l10n) {
    final c = ColorManager.of(context);
    final radius = BorderRadius.circular(16.r);
    // A card with a red hairline, matching the groups above it. The solid
    // red fill made sign-out look like the loudest thing on the screen.
    return Material(
      color: c.cardBg,
      borderRadius: radius,
      child: InkWell(
        onTap: () => _showLogoutDialog(context, l10n),
        borderRadius: radius,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: ColorManager.errorBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorManager.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Icon(
                  Icons.logout,
                  size: 17.w,
                  color: ColorManager.error,
                ),
              ),
              SizedBox(width: 11.w),
              Text(
                l10n.logout,
                style: TextStyle(
                  fontFamily: FontHelper.fontFamily(context),
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Centre dialog, because signing out is destructive and irreversible in
  /// the session sense. The consequence is stated in a tinted box rather
  /// than left implied, and the confirm button carries the destructive fill.
  void _showLogoutDialog(BuildContext context, AppLocalizations l10n) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    showDialog(
      context: context,
      // The wipe plus the push-token de-registration is a network round trip;
      // dismissing on tap-outside mid-flight would leave the user staring at a
      // signed-in screen with no idea anything was happening.
      barrierDismissible: false,
      builder: (dialogContext) => _LogoutDialog(
        builder: (busy, runLogout) => PopScope(
          canPop: !busy,
          child: AlertDialog(
            backgroundColor: c.cardBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            titlePadding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 0),
            contentPadding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 0),
            actionsPadding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 16.h),
            title: Row(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorManager.error.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Icon(
                    Icons.logout,
                    size: 17.w,
                    color: ColorManager.error,
                  ),
                ),
                SizedBox(width: 11.w),
                Expanded(
                  child: Text(
                    l10n.logout,
                    style: TextStyle(
                      color: c.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      fontFamily: family,
                    ),
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.areYouSureLogout,
                  style: TextStyle(
                    color: c.textSecondary,
                    fontSize: 12.sp,
                    height: 1.5,
                    fontFamily: family,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 11.w,
                    vertical: 9.h,
                  ),
                  decoration: BoxDecoration(
                    color: c.errorBg,
                    borderRadius: BorderRadius.circular(11.r),
                    border: Border.all(color: ColorManager.errorBorder),
                  ),
                  child: Text(
                    l10n.logoutConsequence,
                    style: TextStyle(
                      color: ColorManager.error,
                      fontSize: 11.sp,
                      height: 1.45,
                      fontWeight: FontWeight.w500,
                      fontFamily: family,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              _DialogButton(
                label: l10n.cancel,
                enabled: !busy,
                onTap: () => Navigator.pop(dialogContext),
              ),
              _DialogButton(
                label: l10n.logout,
                filled: true,
                tone: ColorManager.destructive,
                busy: busy,
                // The dialog stays put, showing the spinner, until the session is
                // actually gone. Popping first is what let a second tap start a
                // second sign-out over a half-torn-down navigator.
                onTap: () => runLogout(() async {
                  // Shares the wipe-and-redirect path with the forced sign-out on
                  // a 401, so both clear exactly the same state.
                  await getIt<SessionManager>().endSession();
                  if (dialogContext.mounted) Navigator.pop(dialogContext);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Owns the in-flight state for a destructive dialog action.
///
/// [builder] receives whether the action is running and a callback that runs
/// it exactly once - further taps while it is in flight are dropped rather
/// than queued, which is the difference between a slow logout and two
/// concurrent ones racing each other through the navigator.
class _LogoutDialog extends StatefulWidget {
  const _LogoutDialog({required this.builder});

  final Widget Function(bool busy, void Function(Future<void> Function()) run)
  builder;

  @override
  State<_LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<_LogoutDialog> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await action();
    } finally {
      // The dialog is usually gone by now; only touch state if it is not.
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(_busy, _run);
}

/// Dialog action: outlined by default, filled in its own hue when it is the
/// one that commits the change.
class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.onTap,
    this.filled = false,
    this.tone,
    this.busy = false,
    this.enabled = true,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;
  final Color? tone;

  /// Swaps the label for a spinner and stops accepting taps.
  final bool busy;

  /// Greys the button out while another action on the dialog is running.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final radius = BorderRadius.circular(11.r);
    final accent = tone ?? ColorManager.primary;

    final interactive = enabled && !busy;
    final foreground = filled ? ColorManager.white : c.textSecondary;

    return Opacity(
      opacity: interactive ? 1 : 0.6,
      child: Material(
        color: filled ? accent : c.cardBg,
        borderRadius: radius,
        child: InkWell(
          onTap: interactive ? onTap : null,
          borderRadius: radius,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: filled ? null : Border.all(color: c.border),
            ),
            // The spinner takes the label's place rather than sitting beside
            // it, so the button keeps its width and the row does not jump.
            child: busy
                ? SizedBox(
                    height: 15.sp,
                    width: 15.sp,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(foreground),
                    ),
                  )
                : Text(
                    label,
                    style: TextStyle(
                      color: foreground,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.5.sp,
                      fontFamily: FontHelper.fontFamily(context),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  /// Renders the icon and title in the error color (account deletion).
  final bool isDestructive;
  final VoidCallback onTap;

  MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.isDestructive = false,
    required this.onTap,
  });
}
