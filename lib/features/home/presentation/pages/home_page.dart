import 'dart:async';

import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/get_appointments_params.dart';
import 'package:dental_clinic_app/features/appointments/domain/use_cases/get_all_appointments_use_case.dart';
import 'package:dental_clinic_app/features/appointments/presentation/pages/new_appointment_page.dart';
import 'package:dental_clinic_app/features/expenses/presentation/pages/expenses_page.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_header.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_subscription_card.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/quick_actions.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/todays_schedule.dart';
import 'package:dental_clinic_app/features/root/presentation/pages/root_page.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/use_cases/get_subscription_status_use_case.dart';
import 'package:dental_clinic_app/features/subscription/domain/use_cases/get_subscription_usage_use_case.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
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
  bool _subscriptionLoading = true;
  bool _isSubscriptionCardHidden = false;

  List<AppointmentEntity> _todayAppointments = const [];
  bool _scheduleLoading = true;
  String? _scheduleError;

  static const int _maxScheduleRows = 5;

  /// Desktop puts the schedule in its own full-height column, so it can show
  /// materially more of the day before the user has to jump to Appointments.
  static const int _maxScheduleRowsDesktop = 10;

  /// Fixed rather than flex: the quick-action rows and the plan card have a
  /// natural width, and letting them grow with the window only stretches the
  /// labels away from their icons. The schedule absorbs the rest.
  static const double _sidebarWidth = 320;

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
    NewAppointmentPage.created.addListener(_onAppointmentCreated);
    _loadSubscription();
    _loadTodaysSchedule();

    // Safety net for the "already signed in" cold start: AuthBloc only fires
    // on a fresh login/register, so a session restored from storage - or one
    // whose registration POST failed while offline - would otherwise never
    // register. No-ops in ~1 shared-prefs read once the token is synced.
    unawaited(getIt<NotificationService>().syncTokenIfNeeded());
  }

  void _onAppointmentCreated() {
    if (!mounted) return;
    _loadTodaysSchedule();
  }

  @override
  void dispose() {
    UserStorage.profileUpdateNotifier.removeListener(_onProfileUpdated);
    NewAppointmentPage.created.removeListener(_onAppointmentCreated);
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
      _subscriptionLoading = false;
    });
  }

  Future<void> _loadTodaysSchedule() async {
    final today = DateTime.now();
    final result = await getIt<GetAllAppointmentsUseCase>()(
      GetAppointmentsParams.day(today),
    );
    if (!mounted) return;

    setState(() {
      result.fold(
        (e) {
          _scheduleError = NetworkExceptions.getErrorMessage(e);
          _todayAppointments = const [];
        },
        (list) {
          final sorted = [...list]
            ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
          _todayAppointments = sorted;
          _scheduleError = null;
        },
      );
      _scheduleLoading = false;
    });
  }

  void _hideSubscriptionCard() =>
      setState(() => _isSubscriptionCardHidden = true);

  Future<void> _openNewAppointment() async {
    if (!await SubscriptionGuardHelper.requireActive(context)) return;
    if (!mounted) return;
    context.pushNamed(AppRoutesNames.newAppointment);
  }

  Future<void> _openAddPatient() async {
    if (!await SubscriptionGuardHelper.requireActive(context)) return;
    if (!mounted) return;
    context.pushNamed(AppRoutesNames.addPatient);
  }

  // ── Shared section builders ────────────────────────────────────────
  // Both layouts render the same widgets against the same live data; only
  // the arrangement differs, so nothing here may branch on real vs mock.

  Widget _schedule({required int maxRows}) => TodaysSchedule(
        appointments: _todayAppointments.take(maxRows).toList(),
        totalCount: _todayAppointments.length,
        isLoading: _scheduleLoading,
        error: _scheduleError,
        onViewAllTap: () => RootPage.selectedTab.value = 2,
        onNewAppointment: _openNewAppointment,
        onRetry: () {
          setState(() => _scheduleLoading = true);
          _loadTodaysSchedule();
        },
      );

  Widget get _quickActions => QuickActions(
        onAddPatient: _openAddPatient,
        onScheduleVisit: _openNewAppointment,
        onNewCase: () {},
        onRecordPayment: () {
          RootPage.selectedTab.value = 3;
          ExpensesPage.openAddExpenseRequest.value++;
        },
      );

  Widget get _subscriptionCard => HomeSubscriptionCard(
        status: _status,
        usage: _usage,
        isLoading: _subscriptionLoading,
        onViewPlans: () => context.pushNamed(AppRoutesNames.pricing),
        onUpgrade: () => context.pushNamed(AppRoutesNames.pricing),
        onClose: _hideSubscriptionCard,
      );

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) return _buildDesktop(context);
    return _buildMobile(context);
  }

  // ═════════════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT
  //
  // Two columns instead of one stack. RootPage's desktop top bar already
  // carries the greeting, clinic switcher, notifications and profile, so
  // HomeHeader is deliberately omitted here rather than duplicated.
  // ═════════════════════════════════════════════════════════════════════

  /// Real figures only — the schedule is already loaded for the day, and the
  /// usage metrics come from the subscription endpoint. Nothing here is a
  /// placeholder; a dashboard that invents numbers is worse than no dashboard.
  List<DesktopStatCard> _statCards(AppLocalizations l10n) {
    final now = DateTime.now();
    final remaining =
        _todayAppointments.where((a) => a.dateTime.isAfter(now)).length;
    final done = _todayAppointments.length - remaining;

    final cards = <DesktopStatCard>[
      DesktopStatCard(
        icon: Icons.calendar_today_outlined,
        iconColor: const Color(0xFF3B82F6),
        value: '${_todayAppointments.length}',
        label: l10n.todaysAppointments,
      ),
      DesktopStatCard(
        icon: Icons.schedule_outlined,
        iconColor: ColorManager.warning,
        value: '$remaining',
        label: l10n.upcoming,
      ),
      DesktopStatCard(
        icon: Icons.task_alt_rounded,
        iconColor: ColorManager.success,
        value: '$done',
        label: l10n.completed,
      ),
    ];

    // Fourth tile is the plan, or the first usage metric when the plan name
    // is not loaded yet. Both are real values or the tile is dropped.
    final planName = _status?.planName;
    if (planName != null && planName.isNotEmpty) {
      final days = _status?.remainingDays;
      cards.add(
        DesktopStatCard(
          icon: Icons.workspace_premium_outlined,
          iconColor: ColorManager.primary,
          value: planName,
          label:
              days == null ? l10n.currentPlan : '$days ${l10n.daysRemaining}',
        ),
      );
    } else {
      final metric =
          _usage?.metrics.isNotEmpty == true ? _usage!.metrics.first : null;
      if (metric != null) {
        cards.add(
          DesktopStatCard(
            icon: Icons.storage_outlined,
            iconColor: ColorManager.primary,
            value: metric.isUnlimited
                ? '${metric.used}${metric.unit}'
                : '${metric.used}/${metric.limit}${metric.unit}',
            label: metric.key,
          ),
        );
      }
    }

    return cards;
  }

  Widget _buildDesktop(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          // Below this the two columns get too narrow to be worth splitting.
          final isSingleColumn = width < 1100;
          const contentMaxWidth = 1440.0;
          final outerPadding = width > contentMaxWidth
              ? (width - contentMaxWidth) / 2 + 32
              : 32.0;

          final schedule = _schedule(
            maxRows:
                isSingleColumn ? _maxScheduleRows : _maxScheduleRowsDesktop,
          );

          final sidebar = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SectionHeading(title: l10n.quickActions),
              const SizedBox(height: 10),
              _quickActions,
              if (!_isSubscriptionCardHidden) ...[
                const SizedBox(height: 24),
                _subscriptionCard,
              ],
            ],
          );

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(outerPadding, 28, outerPadding, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Same header / stats / content rhythm as the patients page,
                // so the two tabs read as one product on desktop.
                // No trailing action: Quick Actions below already offers
                // Appointment, and the schedule card has its own entry point.
                DesktopPageHeader(
                  title: _firstName.isEmpty
                      ? l10n.welcomeBack
                      : '${l10n.welcomeBack}, $_firstName',
                  subtitle: _clinicName.isEmpty ? null : _clinicName,
                  // Same destination the mobile header's clinic chip opens.
                  // It was plain grey text here, so nothing said it could be
                  // clicked - and on desktop there is no tap-and-see.
                  onSubtitleTap: () =>
                      context.pushNamed(AppRoutesNames.myClinics),
                ),
                const SizedBox(height: 20),

                if (_scheduleLoading)
                  const _StatsRowSkeleton()
                else
                  DesktopStatsRow(
                    cards: _statCards(l10n),
                    compact: isSingleColumn,
                  ),
                const SizedBox(height: 24),

                if (isSingleColumn)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [sidebar, const SizedBox(height: 24), schedule],
                  )
                else
                  // Row lays out from the reading start edge, which is the
                  // side the nav rail is on in both LTR and RTL. Quick
                  // actions therefore sit against the rail and the schedule
                  // takes the far side, where the wide column suits it.
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: _sidebarWidth, child: sidebar),
                      const SizedBox(width: 24),
                      Expanded(child: schedule),
                    ],
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

  Widget _buildMobile(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),

              HomeHeader(
                userName: _firstName.isNotEmpty ? _firstName : 'Dr. Smith',
                clinicName: _clinicName,
                profileImageUrl: _profileImageUrl,
                isLoading: _firstName.isEmpty,
                onNotificationTap: () {
                  context.pushNamed(AppRoutesNames.notifications);
                },
                onMoreTap: () {
                  context.pushNamed(AppRoutesNames.moreMenu);
                },
              ),

              // The day comes first: what the clinic is actually doing in
              // the next few hours outranks the plan banner and the
              // shortcuts, both of which used to sit above it.
              SizedBox(height: 20.h),
              _schedule(maxRows: _maxScheduleRows),

              SizedBox(height: 20.h),

              _SectionHeading(title: l10n.quickActions),
              SizedBox(height: 10.h),
              _quickActions,

              if (!_isSubscriptionCardHidden) ...[
                SizedBox(height: 20.h),
                _subscriptionCard,
              ],

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// 13px/600 in the primary text colour - one heading weight for every group
/// on the screen, matching the patient reference.
class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        fontFamily: FontHelper.fontFamily(context),
        color: ColorManager.of(context).textPrimary,
      ),
    );
  }
}

/// Placeholder tiles so the stats row reserves its height while the day's
/// appointments are still loading, instead of the page jumping once they land.
class _StatsRowSkeleton extends StatelessWidget {
  const _StatsRowSkeleton();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Row(
      children: [
        for (var i = 0; i < 4; i++) ...[
          Expanded(
            child: Container(
              height: 118,
              decoration: BoxDecoration(
                color: c.cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: c.borderLight),
              ),
            ),
          ),
          if (i != 3) const SizedBox(width: 14),
        ],
      ],
    );
  }
}
