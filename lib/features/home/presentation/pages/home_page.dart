import 'dart:async';
import 'dart:math' as math;

import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/denta_nav_bar.dart';
import 'package:dental_clinic_app/custom_widgets/denta_refresh.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/get_appointments_params.dart';
import 'package:dental_clinic_app/features/appointments/domain/use_cases/get_all_appointments_use_case.dart';
import 'package:dental_clinic_app/features/expenses/presentation/pages/expenses_page.dart';
import 'package:dental_clinic_app/features/home/domain/entities/home_card.dart';
import 'package:dental_clinic_app/features/home/domain/use_cases/get_home_cards_use_case.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_header.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/home_stats_carousel.dart';
import 'package:dental_clinic_app/features/home/presentation/theme/home_tokens.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/clinic_date_row.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/quick_actions.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/section_heading.dart';
import 'package:dental_clinic_app/features/home/presentation/widgets/todays_schedule.dart';
import 'package:dental_clinic_app/features/root/presentation/pages/root_page.dart';
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

  /// The carousel's cards, exactly as the server ordered them. Empty means
  /// "draw nothing": that is what a secretary gets, and it is also where
  /// every failure lands - these cards decorate a working screen and must
  /// never be the reason it shows an error.
  List<HomeCard> _cards = const [];

  /// First load only. A refresh keeps the cards that are already up rather
  /// than flashing a skeleton over figures that are still true.
  bool _cardsLoading = true;

  /// A refetch is in flight over cards already displayed - used to avoid
  /// stacking requests when the tab regains focus mid-load.
  bool _cardsInFlight = false;

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
    // A different clinic is a different set of figures, and showing one
    // clinic's takings under another's name is the one mistake these cards
    // must never make.
    UserStorage.clinicChangedNotifier.addListener(_refreshCards);
    // Recording a payment moves a revenue card and opening a case moves the
    // cases card, so both signals are worth a refetch.
    UserStorage.patientsChangedNotifier.addListener(_refreshCards);
    unawaited(_loadTodaysSchedule());
    unawaited(_loadHomeCards());

    // Safety net for the "already signed in" cold start: AuthBloc only fires
    // on a fresh login/register, so a session restored from storage - or one
    // whose registration POST failed while offline - would otherwise never
    // register. No-ops in ~1 shared-prefs read once the token is synced.
    unawaited(getIt<NotificationService>().syncTokenIfNeeded());
  }

  void _onTabChanged() {
    if (RootPage.selectedTab.value != 0) return;
    _refreshSchedule();
    _refreshCards();
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
    UserStorage.clinicChangedNotifier.removeListener(_refreshCards);
    UserStorage.patientsChangedNotifier.removeListener(_refreshCards);
    RootPage.selectedTab.removeListener(_onTabChanged);
    super.dispose();
  }

  void _onProfileUpdated() => setState(() {});

  void _refreshCards() {
    if (!mounted) return;
    unawaited(_loadHomeCards());
  }

  /// Fetches the carousel's cards.
  ///
  /// Every failure - a missing clinic header, a clinic the user was removed
  /// from, a 500, no network - resolves to an empty list and therefore to no
  /// carousel. That is the contract's instruction and it is also the right
  /// call: these figures sit on top of a screen that works without them, so
  /// there is nothing here worth an error card, a retry button, or a blocked
  /// home screen. A session failure is not swallowed quietly by this method -
  /// the auth interceptor owns the 401 path and acts on it wherever it fires.
  Future<void> _loadHomeCards() async {
    if (_cardsInFlight) return;
    _cardsInFlight = true;

    final result = await getIt<GetHomeCardsUseCase>()(NoParams());

    if (!mounted) {
      _cardsInFlight = false;
      return;
    }

    setState(() {
      // An empty list on failure, not the previous cards: after a clinic
      // switch the old ones belong to a clinic the user is no longer looking
      // at, and stale figures under a new clinic name are worse than none.
      result.fold((_) => _cards = const [], (cards) => _cards = cards);
      _cardsLoading = false;
    });

    _cardsInFlight = false;
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

  /// Pull-to-refresh. Reloads everything the screen shows and holds the
  /// spinner until both are back, so the gesture reports on the whole page
  /// rather than on whichever request happened to finish first.
  Future<void> _refreshAll() async {
    await Future.wait([_loadTodaysSchedule(), _loadHomeCards()]);
  }

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

    return Scaffold(
      backgroundColor: t.pageBg,
      body: DentaRefresh(
        onRefresh: _refreshAll,
        child: SingleChildScrollView(
          // 14px screen gutters, the style's standard, via the same
          // `dentaGutter` every converted screen uses. 52 top clears the
          // status bar; the floor is whatever the floating tab bar actually
          // occupies on this device, since the page runs full-bleed behind
          // it and a large home indicator makes that taller than a constant.
          padding: EdgeInsets.fromLTRB(
            dentaGutter,
            52.h,
            dentaGutter,
            math.max(110.h, DentaNavBar.reservedHeight(context) + 14.h),
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

              SizedBox(height: 14.h),
              ClinicDateRow(
                clinicName: _clinicName,
                isLoading: _clinicName.isEmpty,
              ),

              // Gone entirely once the load has resolved to nothing, rather
              // than left as an empty band: the roles that get no cards are
              // not meant to know the figures exist.
              if (_cardsLoading || _cards.isNotEmpty) ...[
                SizedBox(height: 12.h),
                HomeStatsCarousel(
                  cards: _cards,
                  isLoading: _cardsLoading,
                  onTap: () => context.pushNamed(AppRoutesNames.statistics),
                ),
              ],

              // Quick Actions sits above the schedule on purpose: the three
              // things the user starts most are then reachable without
              // scrolling past a day that may be long.
              SizedBox(height: 18.h),
              SectionHeading(title: l10n.quickActions),
              SizedBox(height: 10.h),
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

              SizedBox(height: 18.h),
              TodaysSchedule(
                appointments:
                    _todayAppointments.take(_maxScheduleRows).toList(),
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
            ],
          ),
        ),
      ),
    );
  }
}
