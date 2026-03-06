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
  late final String _userName;
  late final String _clinicName;

  @override
  void initState() {
    super.initState();
    final userStorage = getIt<UserStorage>();
    _userName = userStorage.getUserName() ?? '';
    _clinicName = userStorage.getClinicName() ?? '';
  }

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // — Header: greeting + actions
              HomeHeader(
                userName: _userName.isNotEmpty ? _userName : 'Dr. Smith',
                clinicName: _clinicName,
                onNotificationTap: () {
                  context.pushNamed(AppRoutesNames.notifications);
                },
              ),

              SizedBox(height: 20.h),

              // — Subscription status card (long-press to cycle types for demo)
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

              // — Quick actions row
              Text(
                AppLocalizations.of(context)!.quickActions,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontHelper.fontFamily(context),
                  color: Colors.black54,
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

              // — Treatment Plan Prototype (Test)
              GestureDetector(
                onTap: () =>
                    context.pushNamed(AppRoutesNames.treatmentPrototype),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F9F9),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFF70B2B2).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.science_outlined,
                        size: 22.w,
                        color: const Color(0xFF70B2B2),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          'Treatment Plan Prototype',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF70B2B2),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14.w,
                        color: const Color(0xFF70B2B2),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // — Today's schedule
              TodaysSchedule(onViewAllTap: () {}),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
