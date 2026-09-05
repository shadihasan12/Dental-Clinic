import 'dart:async';

import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/services/notifications/notification_service.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/appointment_entity.dart';
import 'package:dental_clinic_app/features/appointments/domain/entities/get_appointments_params.dart';
import 'package:dental_clinic_app/features/appointments/domain/use_cases/get_all_appointments_use_case.dart';
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

  List<AppointmentEntity> _todayAppointments = const [];

  /// True only until the first load resolves. Drives the skeleton, so a
  /// background revalidation never blanks a schedule that is already on
  /// screen - the whole point of refetching more often is that the user
  /// stops noticing it happen.
  bool _scheduleLoading = true;

  /// A refetch is in flight over data that is already displayed. Used to
  /// avoid stacking duplicate requests, not to show a spinner.
  bool _scheduleInFlight = false;

  String? _scheduleError;

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
    _loadTodaysSchedule();

    // Safety net for the "already signed in" cold start: AuthBloc only fires
    // on a fresh login/register, so a session restored from storage - or one
    // whose registration POST failed while offline - would otherwise never
    // register. No-ops in ~1 shared-prefs read once the token is synced.
    unawaited(getIt<NotificationService>().syncTokenIfNeeded());
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
            _scheduleError = NetworkExceptions.getErrorMessage(e);
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
              TodaysSchedule(
                appointments: _todayAppointments
                    .take(_maxScheduleRows)
                    .toList(),
                totalCount: _todayAppointments.length,
                isLoading: _scheduleLoading,
                error: _scheduleError,
                onViewAllTap: () => RootPage.selectedTab.value = 2,
                onNewAppointment: _openNewAppointment,
                onRetry: () {
                  setState(() => _scheduleLoading = true);
                  _loadTodaysSchedule();
                },
              ),

              SizedBox(height: 20.h),

              _SectionHeading(title: l10n.quickActions),
              SizedBox(height: 10.h),
              // Recording a payment lands on the expenses tab, so it is shown
              // on the same terms the tab itself is: a secretary has neither.
              BlocBuilder<ClinicPermissionsBloc, ClinicPermissionsState>(
                bloc: getIt<ClinicPermissionsBloc>(),
                builder: (context, permissionsState) {
                  final canRecordPayment = visibleRootTabs(
                    permissionsState,
                  ).contains(RootTab.expenses);
                  return QuickActions(
                    onAddPatient: _openAddPatient,
                    onScheduleVisit: _openNewAppointment,
                    onNewCase: () {},
                    onRecordPayment: canRecordPayment
                        ? () {
                            RootPage.selectedTab.value = RootTab.expenses.index;
                            ExpensesPage.openAddExpenseRequest.value++;
                          }
                        : null,
                  );
                },
              ),

              if (!_isSubscriptionCardHidden) ...[
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
