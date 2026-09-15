import 'dart:async';
import 'dart:math' as math;

import 'package:dental_clinic_app/core/config/app_config.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/custom_widgets/denta_nav_bar.dart';
import 'package:dental_clinic_app/custom_widgets/denta_refresh.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/get_appointments_params.dart';
import 'package:dental_clinic_app/features/appointments/domain/use_cases/get_all_appointments_use_case.dart';
import 'package:dental_clinic_app/features/expenses/presentation/pages/expenses_page.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_header.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_subscription_card.dart';
import 'package:dental_clinic_app/features/home/presentation/theme/home_tokens.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/clinic_date_row.dart';
import 'package:dental_clinic_app/features/home/domain/entities/home_summary.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/get_home_summary_use_case.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_stats_carousel.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/quick_actions.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/section_heading.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/todays_schedule.dart';
import 'package:dental_clinic_app/features/root/presentation/pages/root_page.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_status_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/entities/subscription_usage_entity.dart';
import 'package:dental_clinic_app/features/subscription/domain/use_cases/get_subscription_status_use_case.dart';
import 'package:dental_clinic_app/features/subscription/domain/use_cases/get_subscription_usage_use_case.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_bloc.dart';
import 'package:dental_clinic_app/services/permissions/root_tabs.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  /// Null both while loading and whenever there is nothing to report - no
  /// figures for this clinic, no permission, a failed call. The carousel
  /// reads that as "show nothing", which is the right answer to all three.
  HomeSummary? _summary;
  bool _summaryLoading = true;

  List<AppointmentEntity> _todayAppointments = const [];

  /// True only until the first load resolves. Drives the skeleton, so a
  /// background revalidation never blanks a schedule that is already on
  /// screen - the whole point of refetching more often is that the user
  /// stops noticing it happen.
  bool _scheduleLoading = true;

  /// A refetch is in flight over data that is already displayed. Used to
  /// avoid stacking duplicate requests, not to show a spinner.
  bool _scheduleInFlight = false;

  /// The failure itself, not a rendered string. Turning it into text needs
  /// a BuildContext to reach the translations, and doing that at fetch time
  /// is what put an English "Connection request timeout" inside an Arabic
  /// error card. Held as the exception, localised in build.
  NetworkExceptions? _scheduleError;

  static const int _maxScheduleRows = 5;

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
    // Anything that creates an appointment or edits its status raises this,
    // wherever in the app it happened.
    UserStorage.appointmentsChangedNotifier.addListener(_refreshSchedule);
    // Plus a refresh on returning to the Home tab, which also catches edits
    // made through paths that do not raise the signal.
    RootPage.selectedTab.addListener(_onTabChanged);
    _loadSubscription();
    unawaited(_loadInitialContent());

    // Safety net for the "already signed in" cold start: AuthBloc only fires
    // on a fresh login/register, so a session restored from storage - or one
    // whose registration POST failed while offline - would otherwise never
    // register. No-ops in ~1 shared-prefs read once the token is synced.
    unawaited(getIt<NotificationService>().syncTokenIfNeeded());
  }

  /// Cold start, in priority order.
  ///
  /// The summary is one request now, but it is still not the thing the user
  /// opened the app for. Firing it alongside the schedule left the day
  /// competing for the connection at launch; it goes second, once the
  /// schedule is on screen.
  Future<void> _loadInitialContent() async {
    await _loadTodaysSchedule();
    if (!mounted) return;
    await _loadSummary();
  }

  void _onTabChanged() {
    if (RootPage.selectedTab.value != 0) return;
    _refreshSchedule();
  }

  /// Revalidate without disturbing what is on screen.
  void _refreshSchedule() {
    if (!mounted) return;
    _loadTodaysSchedule();
  }

  @override
  void dispose() {
    UserStorage.profileUpdateNotifier.removeListener(_onProfileUpdated);
    UserStorage.appointmentsChangedNotifier.removeListener(_refreshSchedule);
    RootPage.selectedTab.removeListener(_onTabChanged);
    super.dispose();
  }

  void _onProfileUpdated() => setState(() {});

  Future<void> _loadSubscription() async {
    // Nothing renders these when billing is off, so the two round trips are
    // pure cost on a screen the user opens constantly.
    if (!AppConfig.billingEnabled) {
      if (mounted) setState(() => _subscriptionLoading = false);
      return;
    }

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

  /// Fetches today's appointments and swaps them in only once they arrive.
  ///
  /// The list on screen is never cleared first, so a refetch triggered by a
  /// status change or by returning to the tab is invisible when it succeeds
  /// and harmless when it fails - the user keeps the last good schedule
  /// either way. Only the very first load, when there is genuinely nothing
  /// to show, surfaces the skeleton or the error card.
  Future<void> _loadTodaysSchedule() async {
    if (_scheduleInFlight) return;
    _scheduleInFlight = true;

    final today = DateTime.now();
    final result = await getIt<GetAllAppointmentsUseCase>()(
      GetAppointmentsParams.day(today),
    );

    if (!mounted) {
      _scheduleInFlight = false;
      return;
    }

    setState(() {
      result.fold(
        (e) {
          // A failed revalidation keeps the data already displayed; only a
          // failed first load has nothing better to offer than the error.
          if (_scheduleLoading) {
            _scheduleError = e;
            _todayAppointments = const [];
          }
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

    _scheduleInFlight = false;
  }

  /// Month-to-date patient count and revenue, one card per currency.
  ///
  /// A failure is deliberately silent. The figures are a bonus on this
  /// screen, not the reason the user opened it, and the backend withholds the
  /// money cards from a role that may not see them - so an error card here
  /// would be noise for some users and a permissions leak for others.
  Future<void> _loadSummary() async {
    final result = await getIt<GetHomeSummaryUseCase>()(NoParams());
    if (!mounted) return;
    setState(() {
      result.fold((_) => _summary = null, (summary) => _summary = summary);
      _summaryLoading = false;
    });
  }

  /// Pull-to-refresh. Reloads everything the screen shows and holds the
  /// spinner until both are back, so the gesture reports on the whole page
  /// rather than on whichever request happened to finish first.
  Future<void> _refreshAll() async {
    await Future.wait([
      _loadSubscription(),
      _loadTodaysSchedule(),
      _loadSummary(),
    ]);
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

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);
    final l10n = AppLocalizations.of(context)!;

    // The carousel draws nothing when the clinic has no figures at all, so
    // the page asks first rather than reserving a 20pt gap above an empty
    // box.
    final showsStats =
        _summaryLoading || (_summary != null && !_summary!.isEmpty);

    return Scaffold(
      backgroundColor: t.pageBg,
      body: DentaRefresh(
        onRefresh: _refreshAll,
        child: SingleChildScrollView(
          // Handoff: 20 horizontal, 58 top (clear of the status bar), 120
          // bottom so the last card clears the floating tab bar. The page
          // runs full-bleed behind that bar, so the floor is whatever the
          // pill actually occupies on this device - a large home indicator
          // makes it taller than the design's 120.
          padding: EdgeInsets.fromLTRB(
            20.w,
            58.h,
            20.w,
            math.max(120.h, DentaNavBar.reservedHeight(context) + 14.h),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                userName: _firstName.isNotEmpty ? _firstName : 'Dr. Smith',
                profileImageUrl: _profileImageUrl,
                isLoading: _firstName.isEmpty,
                onNotificationTap: () {
                  context.pushNamed(AppRoutesNames.notifications);
                },
                onMoreTap: () {
                  context.pushNamed(AppRoutesNames.moreMenu);
                },
              ),

              SizedBox(height: 20.h),
              ClinicDateRow(
                clinicName: _clinicName,
                isLoading: _clinicName.isEmpty,
              ),

              if (showsStats) ...[
                SizedBox(height: 20.h),
                HomeStatsCarousel(
                  summary: _summary,
                  isLoading: _summaryLoading,
                  onTap: () => context.pushNamed(AppRoutesNames.statistics),
                ),
              ],

              // Quick Actions sits above the schedule on purpose: the three
              // things the user starts most are then reachable without
              // scrolling past a day that may be long.
              SizedBox(height: 20.h),
              SectionHeading(title: l10n.quickActions),
              SizedBox(height: 12.h),
              // Recording a payment lands on the expenses tab, so it is
              // shown on the same terms the tab itself is: a secretary has
              // neither.
              BlocBuilder<ClinicPermissionsBloc, ClinicPermissionsState>(
                bloc: getIt<ClinicPermissionsBloc>(),
                builder: (context, permissionsState) {
                  final canRecordPayment = visibleRootTabs(
                    permissionsState,
                  ).contains(RootTab.expenses);
                  return QuickActions(
                    onAddPatient: _openAddPatient,
                    onScheduleVisit: _openNewAppointment,
                    onRecordPayment: canRecordPayment
                        ? () {
                            RootPage.selectedTab.value = RootTab.expenses.index;
                            ExpensesPage.openAddExpenseRequest.value++;
                          }
                        : null,
                  );
                },
              ),

              SizedBox(height: 20.h),
              TodaysSchedule(
                appointments: _todayAppointments
                    .take(_maxScheduleRows)
                    .toList(),
                totalCount: _todayAppointments.length,
                isLoading: _scheduleLoading,
                error: _scheduleError == null
                    ? null
                    : NetworkExceptions.localizedMessage(
                        context,
                        _scheduleError!,
                      ),
                onViewAllTap: () => RootPage.selectedTab.value = 2,
                onNewAppointment: _openNewAppointment,
                onRetry: () {
                  setState(() => _scheduleLoading = true);
                  _loadTodaysSchedule();
                },
              ),

              if (AppConfig.billingEnabled && !_isSubscriptionCardHidden) ...[
                SizedBox(height: 20.h),
                HomeSubscriptionCard(
                  status: _status,
                  usage: _usage,
                  isLoading: _subscriptionLoading,
                  onViewPlans: () => context.pushNamed(AppRoutesNames.pricing),
                  onUpgrade: () => context.pushNamed(AppRoutesNames.pricing),
                  onClose: _hideSubscriptionCard,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
