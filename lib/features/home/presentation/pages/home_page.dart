import 'dart:math' as math;

import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_header.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_subscription_card.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/quick_actions.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/todays_schedule.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_plan_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/user_subscription_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String get _firstName {
    final s = getIt<UserStorage>();
    return s.getFirstName() ?? s.getUserName() ?? '';
  }

  String get _clinicName => getIt<UserStorage>().getClinicName() ?? '';
  String? get _profileImageUrl => getIt<UserStorage>().getProfileImageUrl();

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

  // ── Mock subscription states for demo switching (long-press to cycle) ──
  int _subscriptionTypeIndex = 0;

  final List<UserSubscriptionEntity?> _mockSubscriptions = [
    // 0: Free Trial (23 days left)
    UserSubscriptionEntity(
      id: 'trial_1',
      userId: 'user_123',
      planTier: PlanTier.trial,
      status: SubscriptionStatus.trial,
      billingCycle: BillingCycle.monthly,
      startDate: DateTime.now().subtract(const Duration(days: 7)),
      currentPeriodEnd: DateTime.now().add(const Duration(days: 23)),
      trialEndDate: DateTime.now().add(const Duration(days: 23)),
    ),
    // 1: Starter Plan (active)
    UserSubscriptionEntity(
      id: 'sub_starter',
      userId: 'user_123',
      planTier: PlanTier.starter,
      status: SubscriptionStatus.active,
      billingCycle: BillingCycle.monthly,
      startDate: DateTime.now().subtract(const Duration(days: 15)),
      currentPeriodEnd: DateTime.now().add(const Duration(days: 15)),
    ),
    // 2: Growing Plan (active)
    UserSubscriptionEntity(
      id: 'sub_growing',
      userId: 'user_123',
      planTier: PlanTier.growing,
      status: SubscriptionStatus.active,
      billingCycle: BillingCycle.yearly,
      startDate: DateTime.now().subtract(const Duration(days: 60)),
      currentPeriodEnd: DateTime.now().add(const Duration(days: 305)),
    ),
    // 3: Advanced Plan (active)
    UserSubscriptionEntity(
      id: 'sub_advanced',
      userId: 'user_123',
      planTier: PlanTier.advanced,
      status: SubscriptionStatus.active,
      billingCycle: BillingCycle.yearly,
      startDate: DateTime.now().subtract(const Duration(days: 90)),
      currentPeriodEnd: DateTime.now().add(const Duration(days: 275)),
    ),
    // 4: Trial urgent (3 days left)
    UserSubscriptionEntity(
      id: 'trial_urgent',
      userId: 'user_123',
      planTier: PlanTier.trial,
      status: SubscriptionStatus.trial,
      billingCycle: BillingCycle.monthly,
      startDate: DateTime.now().subtract(const Duration(days: 27)),
      currentPeriodEnd: DateTime.now().add(const Duration(days: 3)),
      trialEndDate: DateTime.now().add(const Duration(days: 3)),
    ),
    // 5: No subscription
    null,
  ];

  // Mock storage values per subscription type [used, total]
  static const _mockStorage = [
    [0.3, 5.0],   // trial
    [1.2, 5.0],   // starter
    [3.8, 10.0],  // growing
    [12.4, 50.0], // advanced
    [0.1, 5.0],   // trial urgent
    [0.0, 0.0],   // no sub
  ];

  void _cycleSubscriptionType() {
    setState(() {
      _subscriptionTypeIndex =
          (_subscriptionTypeIndex + 1) % _mockSubscriptions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentSub = _mockSubscriptions[_subscriptionTypeIndex];
    final storage = _mockStorage[_subscriptionTypeIndex];

    final isDesktop = Responsive.isDesktop(context);

    if (isDesktop) {
      return _buildDesktopHome(context, currentSub, storage);
    }
    return _buildMobileHome(context, currentSub, storage);
  }

  // ═════════════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT
  // ═════════════════════════════════════════════════════════════════════

  Widget _buildDesktopHome(
    BuildContext context,
    UserSubscriptionEntity? currentSub,
    List<double> storage,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);
    final c = ColorManager.of(context);

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isCompact = width < 1100;
          final isUltraCompact = width < 920;

          // Center content on very wide displays
          const contentMaxWidth = 1440.0;
          final outerPadding = width > contentMaxWidth
              ? (width - contentMaxWidth) / 2 + 32
              : (isUltraCompact ? 20.0 : 32.0);

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              outerPadding,
              28,
              outerPadding,
              40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DesktopHeroBanner(
                  firstName:
                      _firstName.isNotEmpty ? _firstName : 'Dr. Smith',
                  clinicName: _clinicName,
                  fontFamily: fontFamily,
                  todayAppointments: 8,
                  pendingCount: 3,
                  onNewAppointment: () =>
                      context.pushNamed(AppRoutesNames.newAppointment),
                  onAddPatient: () =>
                      context.pushNamed(AppRoutesNames.addPatient),
                ),

                const SizedBox(height: 24),

                _DesktopStatsGrid(
                  isCompact: isUltraCompact,
                  fontFamily: fontFamily,
                  l10n: l10n,
                ),

                const SizedBox(height: 24),

                _DesktopMainRow(
                  isCompact: isCompact,
                  fontFamily: fontFamily,
                  currentSub: currentSub,
                  storage: storage,
                  onCycleSub: _cycleSubscriptionType,
                  onViewPlans: () =>
                      context.pushNamed(AppRoutesNames.pricing),
                  onUpgrade: () =>
                      context.pushNamed(AppRoutesNames.pricing),
                  onAddPatient: () =>
                      context.pushNamed(AppRoutesNames.addPatient),
                  onNewAppointment: () =>
                      context.pushNamed(AppRoutesNames.newAppointment),
                ),

                const SizedBox(height: 24),

                _DesktopActivityRow(
                  isCompact: isCompact,
                  fontFamily: fontFamily,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ═════════════════════════════════════════════════════════════════════
  // MOBILE LAYOUT
  // ═════════════════════════════════════════════════════════════════════

  Widget _buildMobileHome(
    BuildContext context,
    UserSubscriptionEntity? currentSub,
    List<double> storage,
  ) {
    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              HomeHeader(
                userName: _firstName.isNotEmpty ? _firstName : 'Dr. Smith',
                clinicName: _clinicName,
                profileImageUrl: _profileImageUrl,
                onNotificationTap: () {
                  context.pushNamed(AppRoutesNames.notifications);
                },
              ),

              SizedBox(height: 20.h),

              GestureDetector(
                onLongPress: _cycleSubscriptionType,
                child: HomeSubscriptionCard(
                  subscription: currentSub,
                  storageUsedGb: storage[0],
                  storageTotalGb: storage[1],
                  onViewPlans: () =>
                      context.pushNamed(AppRoutesNames.pricing),
                  onUpgrade: () =>
                      context.pushNamed(AppRoutesNames.pricing),
                ),
              ),

              SizedBox(height: 24.h),

              Text(
                AppLocalizations.of(context)!.quickActions,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontHelper.fontFamily(context),
                  color: ColorManager.of(context).textSecondary,
                ),
              ),
              SizedBox(height: 12.h),
              QuickActions(
                onAddPatient: () =>
                    context.pushNamed(AppRoutesNames.addPatient),
                onScheduleVisit: () =>
                    context.pushNamed(AppRoutesNames.newAppointment),
                onNewCase: () {},
                onRecordPayment: () {},
              ),

              SizedBox(height: 24.h),

              TodaysSchedule(onViewAllTap: () {}),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: HERO BANNER
// ═══════════════════════════════════════════════════════════════════════

class _DesktopHeroBanner extends StatelessWidget {
  const _DesktopHeroBanner({
    required this.firstName,
    required this.clinicName,
    required this.fontFamily,
    required this.todayAppointments,
    required this.pendingCount,
    required this.onNewAppointment,
    required this.onAddPatient,
  });

  final String firstName;
  final String clinicName;
  final String fontFamily;
  final int todayAppointments;
  final int pendingCount;
  final VoidCallback onNewAppointment;
  final VoidCallback onAddPatient;

  String _greeting(AppLocalizations l10n) {
    final h = DateTime.now().hour;
    if (h < 12) return l10n.goodMorning;
    if (h < 17) return l10n.goodAfternoon;
    return l10n.goodEvening;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateStr = DateFormat('EEEE, MMMM d').format(DateTime.now());

    return LayoutBuilder(
      builder: (context, constraints) {
        final showRightVisual = constraints.maxWidth >= 760;

        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorManager.primaryDarker,
                ColorManager.primary,
                ColorManager.primaryLight,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: ColorManager.primary.withValues(alpha: 0.18),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned(
                right: -60,
                top: -60,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              Positioned(
                right: 80,
                bottom: -40,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
              ),
              Positioned(
                right: 220,
                top: 40,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.07),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(32, 28, 32, 28),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  color: Colors.white.withValues(alpha: 0.95),
                                  size: 12,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    dateStr,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: fontFamily,
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            '${_greeting(l10n)}, $firstName',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'You have $todayAppointments appointments today · $pendingCount still pending.',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 12,
                            runSpacing: 10,
                            children: [
                              _HeroPrimaryButton(
                                label: 'New Appointment',
                                icon: Icons.add_rounded,
                                fontFamily: fontFamily,
                                onTap: onNewAppointment,
                              ),
                              _HeroSecondaryButton(
                                label: 'Add Patient',
                                icon: Icons.person_add_alt_rounded,
                                fontFamily: fontFamily,
                                onTap: onAddPatient,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (showRightVisual) ...[
                      const SizedBox(width: 24),
                      _HeroRightVisual(
                        fontFamily: fontFamily,
                        appointmentsToday: todayAppointments,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HeroPrimaryButton extends StatefulWidget {
  const _HeroPrimaryButton({
    required this.label,
    required this.icon,
    required this.fontFamily,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final String fontFamily;
  final VoidCallback onTap;

  @override
  State<_HeroPrimaryButton> createState() => _HeroPrimaryButtonState();
}

class _HeroPrimaryButtonState extends State<_HeroPrimaryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hover ? 0.18 : 0.1),
                blurRadius: _hover ? 16 : 10,
                offset: Offset(0, _hover ? 6 : 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 17, color: ColorManager.primaryDarker),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: widget.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primaryDarker,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroSecondaryButton extends StatefulWidget {
  const _HeroSecondaryButton({
    required this.label,
    required this.icon,
    required this.fontFamily,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final String fontFamily;
  final VoidCallback onTap;

  @override
  State<_HeroSecondaryButton> createState() => _HeroSecondaryButtonState();
}

class _HeroSecondaryButtonState extends State<_HeroSecondaryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: _hover
                ? Colors.white.withValues(alpha: 0.22)
                : Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 17, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: widget.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroRightVisual extends StatelessWidget {
  const _HeroRightVisual({
    required this.fontFamily,
    required this.appointmentsToday,
  });

  final String fontFamily;
  final int appointmentsToday;

  @override
  Widget build(BuildContext context) {
    final dayAbbr = DateFormat('EEE').format(DateTime.now()).toUpperCase();
    final dayNum = DateFormat('d').format(DateTime.now());
    final monthAbbr = DateFormat('MMM').format(DateTime.now()).toUpperCase();

    return SizedBox(
      width: 260,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Calendar tile
          Container(
            width: 110,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      monthAbbr,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        color: ColorManager.primaryDarker,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  dayNum,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dayAbbr,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Appointments tile
          Container(
            width: 130,
            height: 120,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.event_available_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const Spacer(),
                Text(
                  '$appointmentsToday',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Today',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: STATS GRID
// ═══════════════════════════════════════════════════════════════════════

class _DesktopStatsGrid extends StatelessWidget {
  const _DesktopStatsGrid({
    required this.isCompact,
    required this.fontFamily,
    required this.l10n,
  });

  final bool isCompact;
  final String fontFamily;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _StatData(
        icon: Icons.groups_rounded,
        accent: ColorManager.primary,
        value: '248',
        label: l10n.patients,
        trend: '+12',
        trendIsPositive: true,
        trendLabel: 'this month',
        spark: const [3, 5, 4, 6, 7, 6, 8, 9, 8, 11],
      ),
      _StatData(
        icon: Icons.calendar_today_rounded,
        accent: const Color(0xFF3B82F6),
        value: '8',
        label: l10n.todaysAppointments,
        trend: '3 left',
        trendIsPositive: null,
        trendLabel: 'remaining today',
        spark: const [2, 4, 3, 5, 6, 5, 7, 6, 8, 8],
      ),
      _StatData(
        icon: Icons.payments_rounded,
        accent: ColorManager.success,
        value: '\$12.4k',
        label: l10n.revenue,
        trend: '+8%',
        trendIsPositive: true,
        trendLabel: 'vs last month',
        spark: const [4, 6, 5, 7, 8, 7, 9, 10, 9, 12],
      ),
      _StatData(
        icon: Icons.medical_services_rounded,
        accent: const Color(0xFF9333EA),
        value: '36',
        label: 'Active Cases',
        trend: '+5',
        trendIsPositive: true,
        trendLabel: 'this week',
        spark: const [2, 3, 3, 4, 3, 4, 5, 4, 5, 6],
      ),
    ];

    if (isCompact) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _DesktopStatCard(data: cards[0], fontFamily: fontFamily),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _DesktopStatCard(data: cards[1], fontFamily: fontFamily),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _DesktopStatCard(data: cards[2], fontFamily: fontFamily),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _DesktopStatCard(data: cards[3], fontFamily: fontFamily),
              ),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          Expanded(
            child: _DesktopStatCard(data: cards[i], fontFamily: fontFamily),
          ),
          if (i != cards.length - 1) const SizedBox(width: 16),
        ],
      ],
    );
  }
}

class _StatData {
  final IconData icon;
  final Color accent;
  final String value;
  final String label;
  final String trend;
  final bool? trendIsPositive; // null = neutral
  final String trendLabel;
  final List<double> spark;

  const _StatData({
    required this.icon,
    required this.accent,
    required this.value,
    required this.label,
    required this.trend,
    required this.trendIsPositive,
    required this.trendLabel,
    required this.spark,
  });
}

class _DesktopStatCard extends StatefulWidget {
  const _DesktopStatCard({
    required this.data,
    required this.fontFamily,
  });

  final _StatData data;
  final String fontFamily;

  @override
  State<_DesktopStatCard> createState() => _DesktopStatCardState();
}

class _DesktopStatCardState extends State<_DesktopStatCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final d = widget.data;
    final trendColor = d.trendIsPositive == null
        ? const Color(0xFFF97316)
        : (d.trendIsPositive! ? ColorManager.success : ColorManager.error);

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hover ? -2 : 0, 0),
        decoration: BoxDecoration(
          color: c.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hover
                ? d.accent.withValues(alpha: 0.35)
                : c.borderLight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _hover ? 0.06 : 0.02),
              blurRadius: _hover ? 16 : 8,
              offset: Offset(0, _hover ? 6 : 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        d.accent.withValues(alpha: 0.18),
                        d.accent.withValues(alpha: 0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(d.icon, color: d.accent, size: 20),
                ),
                const Spacer(),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: trendColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (d.trendIsPositive == true)
                          Icon(
                            Icons.arrow_upward_rounded,
                            size: 11,
                            color: trendColor,
                          )
                        else if (d.trendIsPositive == false)
                          Icon(
                            Icons.arrow_downward_rounded,
                            size: 11,
                            color: trendColor,
                          )
                        else
                          Icon(
                            Icons.access_time_rounded,
                            size: 11,
                            color: trendColor,
                          ),
                        const SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            d.trend,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: widget.fontFamily,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: trendColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                d.value,
                style: TextStyle(
                  fontFamily: widget.fontFamily,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: c.textPrimary,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              d.label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: widget.fontFamily,
                fontSize: 13,
                color: c.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 32,
              child: CustomPaint(
                size: const Size.fromHeight(32),
                painter: _SparklinePainter(
                  values: d.spark,
                  color: d.accent,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              d.trendLabel,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: widget.fontFamily,
                fontSize: 11,
                color: c.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;

    final minV = values.reduce(math.min);
    final maxV = values.reduce(math.max);
    final range = (maxV - minV) == 0 ? 1 : (maxV - minV);
    final stepX = size.width / (values.length - 1);

    double yFor(double v) =>
        size.height - ((v - minV) / range) * size.height;

    final linePath = Path();
    final fillPath = Path();

    for (int i = 0; i < values.length; i++) {
      final x = i * stepX;
      final y = yFor(values[i]);
      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        final prevX = (i - 1) * stepX;
        final prevY = yFor(values[i - 1]);
        final cpX = (prevX + x) / 2;
        linePath.cubicTo(cpX, prevY, cpX, y, x, y);
        fillPath.cubicTo(cpX, prevY, cpX, y, x, y);
      }
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0.22),
          color.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(fillPath, fillPaint);

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(linePath, linePaint);

    // Last point dot
    final lastX = (values.length - 1) * stepX;
    final lastY = yFor(values.last);
    canvas.drawCircle(
      Offset(lastX, lastY),
      3,
      Paint()..color = color,
    );
    canvas.drawCircle(
      Offset(lastX, lastY),
      1.5,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter old) =>
      old.values != values || old.color != color;
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: MAIN ROW (Schedule + Sidebar)
// ═══════════════════════════════════════════════════════════════════════

class _DesktopMainRow extends StatelessWidget {
  const _DesktopMainRow({
    required this.isCompact,
    required this.fontFamily,
    required this.currentSub,
    required this.storage,
    required this.onCycleSub,
    required this.onViewPlans,
    required this.onUpgrade,
    required this.onAddPatient,
    required this.onNewAppointment,
  });

  final bool isCompact;
  final String fontFamily;
  final UserSubscriptionEntity? currentSub;
  final List<double> storage;
  final VoidCallback onCycleSub;
  final VoidCallback onViewPlans;
  final VoidCallback onUpgrade;
  final VoidCallback onAddPatient;
  final VoidCallback onNewAppointment;

  @override
  Widget build(BuildContext context) {
    final schedule = _DesktopScheduleCard(fontFamily: fontFamily);
    final sidebar = _DesktopSidebar(
      fontFamily: fontFamily,
      currentSub: currentSub,
      storage: storage,
      onCycleSub: onCycleSub,
      onViewPlans: onViewPlans,
      onUpgrade: onUpgrade,
      onAddPatient: onAddPatient,
      onNewAppointment: onNewAppointment,
    );

    if (isCompact) {
      return Column(
        children: [
          schedule,
          const SizedBox(height: 24),
          sidebar,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 7, child: schedule),
        const SizedBox(width: 24),
        Expanded(flex: 3, child: sidebar),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: SCHEDULE CARD
// ═══════════════════════════════════════════════════════════════════════

class _DesktopScheduleCard extends StatelessWidget {
  const _DesktopScheduleCard({required this.fontFamily});

  final String fontFamily;

  List<_ScheduleItem> get _items => [
        _ScheduleItem(
          initials: 'SJ',
          name: 'Sarah Johnson',
          treatment: 'Teeth Cleaning',
          time: '09:00 AM',
          duration: '30 min',
          status: _ScheduleStatus.done,
          avatarColor: const Color(0xFF8B5CF6),
        ),
        _ScheduleItem(
          initials: 'MC',
          name: 'Michael Chen',
          treatment: 'Root Canal',
          time: '10:30 AM',
          duration: '60 min',
          status: _ScheduleStatus.done,
          avatarColor: const Color(0xFF06B6D4),
        ),
        _ScheduleItem(
          initials: 'ED',
          name: 'Emily Davis',
          treatment: 'Routine Check-up',
          time: '11:45 AM',
          duration: '20 min',
          status: _ScheduleStatus.now,
          avatarColor: const Color(0xFFEC4899),
        ),
        _ScheduleItem(
          initials: 'JW',
          name: 'James Wilson',
          treatment: 'Cavity Filling',
          time: '02:00 PM',
          duration: '45 min',
          status: _ScheduleStatus.upcoming,
          avatarColor: const Color(0xFFF59E0B),
        ),
        _ScheduleItem(
          initials: 'AR',
          name: 'Amelia Ross',
          treatment: 'Orthodontic Adjustment',
          time: '03:30 PM',
          duration: '30 min',
          status: _ScheduleStatus.upcoming,
          avatarColor: const Color(0xFF10B981),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderLight),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ColorManager.primary10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.today_rounded,
                  color: ColorManager.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.todaysSchedule,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${_items.length} appointments scheduled',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        color: c.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              _TextActionButton(
                label: l10n.viewAll,
                icon: Icons.arrow_forward_rounded,
                fontFamily: fontFamily,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Table header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: _headerLabel('Time', fontFamily, c),
                ),
                const SizedBox(width: 12),
                Expanded(child: _headerLabel('Patient', fontFamily, c)),
                const SizedBox(width: 12),
                SizedBox(
                  width: 90,
                  child: _headerLabel('Duration', fontFamily, c),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 100,
                  child: _headerLabel('Status', fontFamily, c),
                ),
                const SizedBox(width: 8),
                const SizedBox(width: 32),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Divider(height: 1, color: c.borderLight),

          // Items
          for (int i = 0; i < _items.length; i++)
            _ScheduleRow(
              item: _items[i],
              fontFamily: fontFamily,
              showDivider: i != _items.length - 1,
            ),
        ],
      ),
    );
  }

  Widget _headerLabel(String t, String f, AppColors c) {
    return Text(
      t.toUpperCase(),
      style: TextStyle(
        fontFamily: f,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: c.textTertiary,
        letterSpacing: 1,
      ),
    );
  }
}

enum _ScheduleStatus { done, now, upcoming }

class _ScheduleItem {
  final String initials;
  final String name;
  final String treatment;
  final String time;
  final String duration;
  final _ScheduleStatus status;
  final Color avatarColor;

  const _ScheduleItem({
    required this.initials,
    required this.name,
    required this.treatment,
    required this.time,
    required this.duration,
    required this.status,
    required this.avatarColor,
  });
}

class _ScheduleRow extends StatefulWidget {
  const _ScheduleRow({
    required this.item,
    required this.fontFamily,
    required this.showDivider,
  });

  final _ScheduleItem item;
  final String fontFamily;
  final bool showDivider;

  @override
  State<_ScheduleRow> createState() => _ScheduleRowState();
}

class _ScheduleRowState extends State<_ScheduleRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final item = widget.item;

    late final Color statusColor;
    late final String statusLabel;
    late final IconData? statusIcon;
    switch (item.status) {
      case _ScheduleStatus.done:
        statusColor = ColorManager.success;
        statusLabel = 'Done';
        statusIcon = Icons.check_circle_rounded;
        break;
      case _ScheduleStatus.now:
        statusColor = const Color(0xFF3B82F6);
        statusLabel = 'In Progress';
        statusIcon = Icons.circle;
        break;
      case _ScheduleStatus.upcoming:
        statusColor = const Color(0xFFF97316);
        statusLabel = 'Upcoming';
        statusIcon = Icons.schedule_rounded;
        break;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        decoration: BoxDecoration(
          color: _hover
              ? ColorManager.primary.withValues(alpha: 0.04)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            bottom: widget.showDivider
                ? BorderSide(color: c.borderLight)
                : BorderSide.none,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
        child: Row(
          children: [
            // Time column
            SizedBox(
              width: 100,
              child: Text(
                item.time,
                style: TextStyle(
                  fontFamily: widget.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Patient column
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: item.avatarColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.initials,
                      style: TextStyle(
                        fontFamily: widget.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: item.avatarColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                            fontFamily: widget.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: c.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.treatment,
                          style: TextStyle(
                            fontFamily: widget.fontFamily,
                            fontSize: 12,
                            color: c.textTertiary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Duration column
            SizedBox(
              width: 90,
              child: Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 14,
                    color: c.textTertiary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.duration,
                    style: TextStyle(
                      fontFamily: widget.fontFamily,
                      fontSize: 12,
                      color: c.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Status
            SizedBox(
              width: 100,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      size: 10,
                      color: statusColor,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        statusLabel,
                        style: TextStyle(
                          fontFamily: widget.fontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),

            AnimatedOpacity(
              duration: const Duration(milliseconds: 140),
              opacity: _hover ? 1 : 0.5,
              child: IconButton(
                onPressed: () {},
                iconSize: 18,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                icon: Icon(
                  Icons.more_horiz_rounded,
                  color: c.textTertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: RIGHT SIDEBAR
// ═══════════════════════════════════════════════════════════════════════

class _DesktopSidebar extends StatelessWidget {
  const _DesktopSidebar({
    required this.fontFamily,
    required this.currentSub,
    required this.storage,
    required this.onCycleSub,
    required this.onViewPlans,
    required this.onUpgrade,
    required this.onAddPatient,
    required this.onNewAppointment,
  });

  final String fontFamily;
  final UserSubscriptionEntity? currentSub;
  final List<double> storage;
  final VoidCallback onCycleSub;
  final VoidCallback onViewPlans;
  final VoidCallback onUpgrade;
  final VoidCallback onAddPatient;
  final VoidCallback onNewAppointment;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Subscription
        GestureDetector(
          onLongPress: onCycleSub,
          child: _DesktopSubscriptionCard(
            subscription: currentSub,
            storageUsedGb: storage[0],
            storageTotalGb: storage[1],
            fontFamily: fontFamily,
            onViewPlans: onViewPlans,
            onUpgrade: onUpgrade,
          ),
        ),
        const SizedBox(height: 20),

        // Quick actions card
        _QuickActionsCard(
          fontFamily: fontFamily,
          title: l10n.quickActions,
          onAddPatient: onAddPatient,
          onNewAppointment: onNewAppointment,
        ),
      ],
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  const _QuickActionsCard({
    required this.fontFamily,
    required this.title,
    required this.onAddPatient,
    required this.onNewAppointment,
  });

  final String fontFamily;
  final String title;
  final VoidCallback onAddPatient;
  final VoidCallback onNewAppointment;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: ColorManager.primary10,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.bolt_rounded,
                  color: ColorManager.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _QuickActionTile(
            icon: Icons.person_add_alt_rounded,
            label: l10n.patient,
            subtitle: 'Register a new patient',
            color: ColorManager.primary,
            fontFamily: fontFamily,
            onTap: onAddPatient,
          ),
          const SizedBox(height: 10),
          _QuickActionTile(
            icon: Icons.event_available_rounded,
            label: l10n.appointment,
            subtitle: 'Book a slot on the calendar',
            color: const Color(0xFF3B82F6),
            fontFamily: fontFamily,
            onTap: onNewAppointment,
          ),
          const SizedBox(height: 10),
          _QuickActionTile(
            icon: Icons.payments_rounded,
            label: l10n.payment,
            subtitle: 'Record a payment',
            color: ColorManager.success,
            fontFamily: fontFamily,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatefulWidget {
  const _QuickActionTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.fontFamily,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final String fontFamily;
  final VoidCallback onTap;

  @override
  State<_QuickActionTile> createState() => _QuickActionTileState();
}

class _QuickActionTileState extends State<_QuickActionTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _hover
                ? widget.color.withValues(alpha: 0.08)
                : c.cardBgSecondary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hover
                  ? widget.color.withValues(alpha: 0.3)
                  : c.borderLight,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(widget.icon, color: widget.color, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                        fontFamily: widget.fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontFamily: widget.fontFamily,
                        fontSize: 11,
                        color: c.textTertiary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                padding: EdgeInsets.only(left: _hover ? 4 : 0),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: _hover ? widget.color : c.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextActionButton extends StatefulWidget {
  const _TextActionButton({
    required this.label,
    required this.icon,
    required this.fontFamily,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final String fontFamily;
  final VoidCallback onTap;

  @override
  State<_TextActionButton> createState() => _TextActionButtonState();
}

class _TextActionButtonState extends State<_TextActionButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _hover
                ? ColorManager.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: widget.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.primary,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                widget.icon,
                size: 14,
                color: ColorManager.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: ACTIVITY ROW
// ═══════════════════════════════════════════════════════════════════════

class _DesktopActivityRow extends StatelessWidget {
  const _DesktopActivityRow({
    required this.isCompact,
    required this.fontFamily,
  });

  final bool isCompact;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final activity = _RecentActivityCard(fontFamily: fontFamily);
    final patients = _NewPatientsCard(fontFamily: fontFamily);

    if (isCompact) {
      return Column(
        children: [
          activity,
          const SizedBox(height: 24),
          patients,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 7, child: activity),
        const SizedBox(width: 24),
        Expanded(flex: 3, child: patients),
      ],
    );
  }
}

class _RecentActivityCard extends StatelessWidget {
  const _RecentActivityCard({required this.fontFamily});
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    final items = <_ActivityItem>[
      _ActivityItem(
        icon: Icons.payments_rounded,
        color: ColorManager.success,
        title: 'Payment received from Sarah Johnson',
        subtitle: '\$240.00 · Teeth cleaning',
        time: '5 min ago',
      ),
      _ActivityItem(
        icon: Icons.person_add_alt_rounded,
        color: ColorManager.primary,
        title: 'New patient registered',
        subtitle: 'Oliver Martinez · Added by you',
        time: '1 hour ago',
      ),
      _ActivityItem(
        icon: Icons.check_circle_rounded,
        color: const Color(0xFF3B82F6),
        title: 'Treatment completed',
        subtitle: 'Michael Chen · Root canal',
        time: '2 hours ago',
      ),
      _ActivityItem(
        icon: Icons.event_busy_rounded,
        color: const Color(0xFFF59E0B),
        title: 'Appointment rescheduled',
        subtitle: 'Emma Garcia · Moved to Apr 22',
        time: '4 hours ago',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderLight),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ColorManager.primary10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.history_rounded,
                  color: ColorManager.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Recent Activity',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Latest updates across your clinic',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        color: c.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              _TextActionButton(
                label: 'View all',
                icon: Icons.arrow_forward_rounded,
                fontFamily: fontFamily,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < items.length; i++) ...[
            _ActivityRow(item: items[i], fontFamily: fontFamily),
            if (i != items.length - 1)
              Divider(height: 1, color: c.borderLight),
          ],
        ],
      ),
    );
  }
}

class _ActivityItem {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String time;

  const _ActivityItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.time,
  });
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.item, required this.fontFamily});

  final _ActivityItem item;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(item.icon, size: 18, color: item.color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12,
                    color: c.textTertiary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            item.time,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 11,
              color: c.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _NewPatientsCard extends StatelessWidget {
  const _NewPatientsCard({required this.fontFamily});
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    final patients = <_MiniPatient>[
      _MiniPatient(
        initials: 'OM',
        name: 'Oliver Martinez',
        meta: 'Added today',
        color: const Color(0xFF8B5CF6),
      ),
      _MiniPatient(
        initials: 'SB',
        name: 'Sophia Brown',
        meta: '2 days ago',
        color: const Color(0xFFEC4899),
      ),
      _MiniPatient(
        initials: 'LG',
        name: 'Liam Garcia',
        meta: '3 days ago',
        color: const Color(0xFF06B6D4),
      ),
      _MiniPatient(
        initials: 'IP',
        name: 'Isabella Perez',
        meta: '5 days ago',
        color: const Color(0xFFF59E0B),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderLight),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: ColorManager.primary10,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.groups_2_rounded,
                  color: ColorManager.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'New Patients',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: c.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < patients.length; i++)
            Padding(
              padding: EdgeInsets.only(
                bottom: i == patients.length - 1 ? 0 : 10,
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: patients[i].color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      patients[i].initials,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: patients[i].color,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          patients[i].name,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: c.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 1),
                        Text(
                          patients[i].meta,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 11,
                            color: c.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _MiniPatient {
  final String initials;
  final String name;
  final String meta;
  final Color color;

  const _MiniPatient({
    required this.initials,
    required this.name,
    required this.meta,
    required this.color,
  });
}

// ═══════════════════════════════════════════════════════════════════════
// DESKTOP: SUBSCRIPTION CARD (raw pixel sizes — avoids ScreenUtil scaling)
// ═══════════════════════════════════════════════════════════════════════

class _DesktopSubscriptionCard extends StatelessWidget {
  const _DesktopSubscriptionCard({
    required this.subscription,
    required this.storageUsedGb,
    required this.storageTotalGb,
    required this.fontFamily,
    required this.onViewPlans,
    required this.onUpgrade,
  });

  final UserSubscriptionEntity? subscription;
  final double storageUsedGb;
  final double storageTotalGb;
  final String fontFamily;
  final VoidCallback onViewPlans;
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    if (subscription == null) {
      return _DesktopNoSubCard(
        fontFamily: fontFamily,
        onStartTrial: onUpgrade,
      );
    }
    if (subscription!.isInTrial) {
      return _DesktopTrialCard(
        subscription: subscription!,
        fontFamily: fontFamily,
        onUpgrade: onUpgrade,
      );
    }
    return _DesktopActivePlanCard(
      subscription: subscription!,
      storageUsedGb: storageUsedGb,
      storageTotalGb: storageTotalGb,
      fontFamily: fontFamily,
      onViewPlans: onViewPlans,
    );
  }
}

class _DesktopNoSubCard extends StatelessWidget {
  const _DesktopNoSubCard({
    required this.fontFamily,
    required this.onStartTrial,
  });

  final String fontFamily;
  final VoidCallback onStartTrial;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorManager.primary.withValues(alpha: 0.08),
            ColorManager.primary.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.rocket_launch_rounded,
                  color: ColorManager.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.noSubscription,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.tryAllFeatures,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 11,
                        color: c.textSubtle,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _DesktopFilledButton(
            label: l10n.startFreeTrial,
            fontFamily: fontFamily,
            onTap: onStartTrial,
          ),
        ],
      ),
    );
  }
}

class _DesktopTrialCard extends StatelessWidget {
  const _DesktopTrialCard({
    required this.subscription,
    required this.fontFamily,
    required this.onUpgrade,
  });

  final UserSubscriptionEntity subscription;
  final String fontFamily;
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final daysLeft = subscription.trialDaysRemaining;
    final isUrgent = daysLeft <= 7;
    final accent =
        isUrgent ? const Color(0xFFF59E0B) : ColorManager.primary;
    final progress = (daysLeft / 30).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: 0.08),
            accent.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isUrgent ? Icons.timer_rounded : Icons.star_rounded,
                  color: accent,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.freeTrial,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      l10n.trialEndsIn(daysLeft),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 11,
                        color: c.textSubtle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  l10n.daysLeft(daysLeft),
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: accent.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(accent),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 16),
          _DesktopFilledButton(
            label: l10n.upgradeNow,
            fontFamily: fontFamily,
            onTap: onUpgrade,
          ),
        ],
      ),
    );
  }
}

class _DesktopActivePlanCard extends StatelessWidget {
  const _DesktopActivePlanCard({
    required this.subscription,
    required this.storageUsedGb,
    required this.storageTotalGb,
    required this.fontFamily,
    required this.onViewPlans,
  });

  final UserSubscriptionEntity subscription;
  final double storageUsedGb;
  final double storageTotalGb;
  final String fontFamily;
  final VoidCallback onViewPlans;

  String _planName(PlanTier tier) {
    switch (tier) {
      case PlanTier.trial:
        return 'Trial';
      case PlanTier.starter:
        return 'Starter';
      case PlanTier.growing:
        return 'Growing';
      case PlanTier.advanced:
        return 'Advanced';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final isActive = subscription.status == SubscriptionStatus.active;
    final statusColor =
        isActive ? const Color(0xFF10B981) : const Color(0xFFF59E0B);
    final statusLabel = isActive ? l10n.active : l10n.inactive;
    final renewDate =
        DateFormat('MMM d, yyyy').format(subscription.currentPeriodEnd);
    final progress = storageTotalGb > 0
        ? (storageUsedGb / storageTotalGb).clamp(0.0, 1.0)
        : 0.0;
    final progressColor =
        progress > 0.85 ? const Color(0xFFF59E0B) : ColorManager.primary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.verified_rounded,
                  color: ColorManager.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${_planName(subscription.planTier)} ${l10n.plan}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      l10n.renewsOn(renewDate),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 11,
                        color: c.textSubtle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                l10n.storageUsed,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 12,
                  color: c.textSubtle,
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  l10n.storageValue(
                    storageUsedGb.toStringAsFixed(1),
                    storageTotalGb.toStringAsFixed(0),
                  ),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: c.borderLight,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 16),
          _DesktopOutlinedButton(
            label: l10n.viewAllPlans,
            fontFamily: fontFamily,
            onTap: onViewPlans,
          ),
        ],
      ),
    );
  }
}

class _DesktopFilledButton extends StatefulWidget {
  const _DesktopFilledButton({
    required this.label,
    required this.fontFamily,
    required this.onTap,
  });

  final String label;
  final String fontFamily;
  final VoidCallback onTap;

  @override
  State<_DesktopFilledButton> createState() => _DesktopFilledButtonState();
}

class _DesktopFilledButtonState extends State<_DesktopFilledButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: _hover
                ? ColorManager.primaryDark
                : ColorManager.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: widget.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopOutlinedButton extends StatefulWidget {
  const _DesktopOutlinedButton({
    required this.label,
    required this.fontFamily,
    required this.onTap,
  });

  final String label;
  final String fontFamily;
  final VoidCallback onTap;

  @override
  State<_DesktopOutlinedButton> createState() => _DesktopOutlinedButtonState();
}

class _DesktopOutlinedButtonState extends State<_DesktopOutlinedButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: _hover
                ? ColorManager.primary.withValues(alpha: 0.08)
                : c.cardBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorManager.primary, width: 1.2),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: widget.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: ColorManager.primary,
            ),
          ),
        ),
      ),
    );
  }
}
