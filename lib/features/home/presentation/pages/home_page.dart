import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_header.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_subscription_card.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/quick_actions.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/todays_schedule.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/use_cases/get_subscription_status_use_case.dart';
import 'package:dental_clinic_app/features/subscription/domain/use_cases/get_subscription_usage_use_case.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
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
  SubscriptionStatusEntity? _status;
  SubscriptionUsageEntity? _usage;
  bool _isSubscriptionCardHidden = false;

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
    _loadSubscription();
  }

  @override
  void dispose() {
    UserStorage.profileUpdateNotifier.removeListener(_onProfileUpdated);
    super.dispose();
  }

  void _onProfileUpdated() => setState(() {});

  Future<void> _loadSubscription() async {
    final statusFuture = getIt<GetSubscriptionStatusUseCase>()(NoParams());
    final usageFuture = getIt<GetSubscriptionUsageUseCase>()(NoParams());

    final statusResult = await statusFuture;
    final usageResult = await usageFuture;
    if (!mounted) return;

    setState(() {
      statusResult.fold((_) => _status = null, (s) => _status = s);
      usageResult.fold((_) => _usage = null, (u) => _usage = u);
    });
  }

  void _hideSubscriptionCard() =>
      setState(() => _isSubscriptionCardHidden = true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
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

              if (!_isSubscriptionCardHidden) ...[
                SizedBox(height: 20.h),
                HomeSubscriptionCard(
                  status: _status,
                  usage: _usage,
                  onViewPlans: () =>
                      context.pushNamed(AppRoutesNames.pricing),
                  onUpgrade: () => context.pushNamed(AppRoutesNames.pricing),
                  onClose: _hideSubscriptionCard,
                ),
              ],

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
                onAddPatient: () async {
                  if (!await SubscriptionGuardHelper
                      .requireActive(context)) {
                    return;
                  }
                  if (!context.mounted) return;
                  context.pushNamed(AppRoutesNames.addPatient);
                },
                onScheduleVisit: () async {
                  if (!await SubscriptionGuardHelper
                      .requireActive(context)) {
                    return;
                  }
                  if (!context.mounted) return;
                  context.pushNamed(AppRoutesNames.newAppointment);
                },
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
