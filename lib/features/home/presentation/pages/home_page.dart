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
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Row 1: Stats cards + Quick actions ──────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats cards
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                        child: _DesktopStatCard(
                          icon: Icons.people_outline,
                          iconColor: ColorManager.primary,
                          iconBgColor: ColorManager.primary10,
                          value: '248',
                          label: l10n.patients,
                          trend: '+12 this month',
                          trendColor: ColorManager.success,
                          fontFamily: fontFamily,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _DesktopStatCard(
                          icon: Icons.calendar_today_outlined,
                          iconColor: const Color(0xFF3B82F6),
                          iconBgColor: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                          value: '8',
                          label: l10n.todaysAppointments,
                          trend: '3 remaining',
                          trendColor: const Color(0xFFF97316),
                          fontFamily: fontFamily,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _DesktopStatCard(
                          icon: Icons.attach_money,
                          iconColor: ColorManager.success,
                          iconBgColor: ColorManager.success.withValues(alpha: 0.1),
                          value: '\$12.4k',
                          label: l10n.revenue,
                          trend: '+8% vs last month',
                          trendColor: ColorManager.success,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Quick actions
                SizedBox(
                  width: 200,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: c.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: c.borderLight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.quickActions,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: fontFamily,
                            color: c.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _DesktopQuickAction(
                          icon: Icons.person_add_outlined,
                          label: l10n.patient,
                          onTap: () =>
                              context.pushNamed(AppRoutesNames.addPatient),
                        ),
                        const SizedBox(height: 6),
                        _DesktopQuickAction(
                          icon: Icons.calendar_month_outlined,
                          label: l10n.appointment,
                          onTap: () =>
                              context.pushNamed(AppRoutesNames.newAppointment),
                        ),
                        const SizedBox(height: 6),
                        _DesktopQuickAction(
                          icon: Icons.attach_money,
                          label: l10n.payment,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Row 2: Today's schedule + Subscription status ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Schedule (main)
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: c.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: c.borderLight),
                    ),
                    child: TodaysSchedule(onViewAllTap: () {}),
                  ),
                ),
                const SizedBox(width: 16),

                // Subscription (compact sidebar)
                SizedBox(
                  width: 200,
                  child: GestureDetector(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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

class _DesktopQuickAction extends StatelessWidget {
  const _DesktopQuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Material(
      color: ColorManager.primary.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: ColorManager.primary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: c.textPrimary,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, size: 16, color: c.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopStatCard extends StatelessWidget {
  const _DesktopStatCard({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.value,
    required this.label,
    required this.trend,
    required this.trendColor,
    required this.fontFamily,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String value;
  final String label;
  final String trend;
  final Color trendColor;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: trendColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  trend,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: trendColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: c.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 13,
              color: c.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
