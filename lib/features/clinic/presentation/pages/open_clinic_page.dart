import 'dart:async';

import 'package:dental_clinic_app/core/config/app_config.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/location_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/plan_entity.dart';
import 'package:dental_clinic_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dental_clinic_app/features/billing/domain/entities/plan_features_entity.dart';
import 'package:dental_clinic_app/features/billing/domain/repositories/billing_repository.dart';
import 'package:dental_clinic_app/features/billing/presentation/widgets/plan_option_card.dart';
import 'package:dental_clinic_app/features/clinic/data/own_clinic_service.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_type.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/get_my_clinics_use_case.dart';
import 'package:dental_clinic_app/features/clinic/domain/use_cases/switch_active_clinic_use_case.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/clinic_type_selector.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/permissions/clinic_permissions_bloc.dart';
import 'package:dental_clinic_app/services/subscription_guard/subscription_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Opening a clinic of one's own, signed in: the clinic and plan steps of
/// sign-up, posted to `POST /users/clinics` instead of `/auth/register`.
///
/// Reached from the "no clinic" screen and from the clinic picker - any
/// signed-in account may open one, and an employee keeps their job.
///
/// Whether the clinic starts on a free trial is known before anything is
/// filled in: `trial_eligible && plan.supports_trial`. Whoever gets it sees
/// it on every plan; whoever does not is told once, kindly, at the top, so
/// the bill after the form is no surprise. The server's status after the
/// 201 still decides where the app opens.
class OpenClinicPage extends StatefulWidget {
  const OpenClinicPage({super.key});

  @override
  State<OpenClinicPage> createState() => _OpenClinicPageState();
}

class _OpenClinicPageState extends State<OpenClinicPage> {
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _locationQuery = TextEditingController();

  ClinicType? _type;
  LocationEntity? _location;
  List<LocationEntity> _locationResults = const [];
  bool _searchingLocations = false;
  Timer? _debounce;

  List<PlanEntity> _plans = const [];
  bool _plansLoading = true;
  bool _plansFailed = false;
  String? _planId;
  final Map<String, PlanFeaturesEntity> _features = {};
  final Set<String> _featuresLoading = {};
  final Map<String, Future<void>> _featureRequests = {};

  /// Null until the profile answers; the trial is not promised before then.
  bool? _trialEligible;

  bool _submitting = false;
  bool _submitted = false;
  Map<String, String> _serverErrors = const {};

  static const String _countryCode = 'SY';

  @override
  void initState() {
    super.initState();
    _loadTrial();
    _loadPlans();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _name.dispose();
    _address.dispose();
    _locationQuery.dispose();
    super.dispose();
  }

  Future<void> _loadTrial() async {
    final result = await getIt<OwnClinicService>().trialEligible();
    if (!mounted) return;
    // A failed read promises nothing: the form reads as "no trial", which
    // is never a false promise.
    setState(() => _trialEligible = result.getOrElse(() => false));
  }

  Future<void> _loadPlans() async {
    setState(() {
      _plansLoading = true;
      _plansFailed = false;
    });
    final result = await getIt<AuthRepository>().getPlans();
    if (!mounted) return;
    setState(() {
      _plansLoading = false;
      result.fold((_) => _plansFailed = true, (plans) {
        _plans = [...plans]..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
        if (!_plans.any((p) => p.id == _planId)) {
          _planId = _plans.isEmpty ? null : _plans.first.id;
        }
      });
    });
  }

  Future<void> _loadFeatures(String planId) =>
      _featureRequests[planId] ??= _fetchFeatures(planId);

  Future<void> _fetchFeatures(String planId) async {
    setState(() => _featuresLoading.add(planId));
    final result = await getIt<BillingRepository>().getPlanFeatures(planId);
    if (!mounted) return;
    setState(() {
      _featuresLoading.remove(planId);
      result.fold(
        (_) => _featureRequests.remove(planId),
        (features) => _features[planId] = features,
      );
    });
  }

  void _onLocationQuery() {
    _debounce?.cancel();
    final query = _locationQuery.text.trim();
    if (query.length < 2) {
      setState(() => _locationResults = const []);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      setState(() => _searchingLocations = true);
      final result = await getIt<AuthRepository>().searchLocations(
        query: query,
        countryCode: _countryCode,
      );
      if (!mounted) return;
      setState(() {
        _searchingLocations = false;
        _locationResults = result.getOrElse(() => const []);
      });
    });
  }

  PlanEntity? get _plan =>
      _plans.where((p) => p.id == _planId).firstOrNull;

  bool get _getsTrial =>
      (_trialEligible ?? false) && (_plan?.supportsTrial ?? false);

  // ── Validation: the server's rules, on the device first ──────────────
  // Five sends an hour, a refused one included, so nothing goes out that
  // would only come back as a 400.

  String? _nameError(AppLocalizations l10n) {
    final name = _name.text.trim();
    if (name.isEmpty) {
      return _serverErrors['clinic.name'] ?? (_submitted ? l10n.pleaseEnterClinicName : null);
    }
    if (name.runes.length > OpenClinicParams.maxNameLength) {
      return l10n.maxCharacters(OpenClinicParams.maxNameLength);
    }
    return _serverErrors['clinic.name'];
  }

  /// Optional, as on sign-up. The server requires the field, so an empty
  /// one is sent as the location's name - the same fallback sign-up uses.
  String? _addressError(AppLocalizations l10n) {
    final address = _address.text.trim();
    if (address.runes.length > OpenClinicParams.maxAddressLength) {
      return l10n.maxCharacters(OpenClinicParams.maxAddressLength);
    }
    return _serverErrors['clinic.detailed_address'];
  }

  String? _typeError(AppLocalizations l10n) => _type != null
      ? null
      : _serverErrors['clinic.type'] ??
          (_submitted ? l10n.clinicTypeRequired : null);

  String? _locationError(AppLocalizations l10n) => _location != null
      ? null
      : _serverErrors['clinic.location_id'] ??
          (_submitted ? l10n.pleaseSelectLocation : null);

  bool _isValid(AppLocalizations l10n) =>
      _nameError(l10n) == null &&
      _addressError(l10n) == null &&
      _typeError(l10n) == null &&
      _locationError(l10n) == null &&
      _plan != null;

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _submitted = true;
      _serverErrors = const {};
    });
    if (_submitting) return;
    if (!_isValid(l10n)) {
      if (_plan == null) {
        AppSnackbar.showError(context, title: l10n.pleaseSelectPlan);
      }
      return;
    }

    // Each successful call is a clinic: a double tap must not make two.
    setState(() => _submitting = true);
    final result = await getIt<OwnClinicService>().openClinic(
      OpenClinicParams(
        name: _name.text.trim(),
        type: _type!.apiValue,
        locationId: _location!.id,
        detailedAddress: _address.text.trim().isEmpty
            ? _location!.name
            : _address.text.trim(),
        planVersionId: _plan!.versionId,
      ),
    );
    if (!mounted) return;

    final failure = result.fold((e) => e, (_) => null);
    if (failure != null) {
      setState(() => _submitting = false);
      _onRefused(failure, l10n);
      return;
    }
    await _openCreated(result.getOrElse(() => ''));
  }

  void _onRefused(NetworkExceptions failure, AppLocalizations l10n) {
    final fields = failure.maybeWhen(
      badRequest: (_, fieldErrors) => fieldErrors,
      orElse: () => null,
    );
    if (fields != null && fields.isNotEmpty) {
      // A plan withdrawn since the list was loaded: reload it and let the
      // user pick again.
      if (fields.containsKey('plan_version_id')) {
        AppSnackbar.showError(context, title: l10n.planNoLongerOffered);
        _loadPlans();
      }
      setState(() => _serverErrors = fields);
      return;
    }
    // 429 (five an hour), 422 (inactive account, unverified email), and the
    // rest: the server's own sentence.
    AppSnackbar.showError(
      context,
      title: l10n.error,
      message: NetworkExceptions.getErrorMessage(failure),
    );
  }

  /// Selects the new clinic and opens on what its subscription allows - the
  /// same way sign-up does after creating one.
  Future<void> _openCreated(String clinicId) async {
    final router = GoRouter.of(context);
    final clinics = (await getIt<GetMyClinicsUseCase>()())
        .getOrElse(() => const []);
    final created = clinics.where((m) => m.clinicId == clinicId).firstOrNull;
    if (created != null) {
      await getIt<SwitchActiveClinicUseCase>().activate(created);
    }

    // The status decides: a trial opens the clinic; billing only opens on
    // the subscription screen, where the plan picker and payment work.
    final permissions = getIt<ClinicPermissionsBloc>();
    permissions.add(const ClinicPermissionsEvent.load());
    await permissions.stream.settled(
      (state) => state.maybeWhen(
        loaded: (_) => true,
        error: (_) => true,
        orElse: () => false,
      ),
      timeout: const Duration(seconds: 10),
    );

    if (AppConfig.billingEnabled && getIt<SubscriptionGuard>().isLocked) {
      router.goNamed(AppRoutesNames.root);
      return;
    }
    // A brand-new clinic has no hours, and without them no appointment can
    // be booked - the same gate sign-up ends on.
    router.goNamed(AppRoutesNames.setupWorkingHours);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDesktop = Responsive.isDesktop(context);
    final c = ColorManager.of(context);

    final actionLabel = !(_trialEligible ?? false)
        ? l10n.createClinicAndPay
        : _getsTrial
            ? l10n.startFreeTrial
            : l10n.createClinicAction;

    final body = SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: isDesktop
          ? const EdgeInsets.fromLTRB(24, 20, 24, 28)
          : EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
      child: AdaptiveContentWidth(
        maxWidth: 640,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.openClinicSubtitle,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 12.sp,
                height: 1.5,
                color: c.textSecondary,
              ),
            ),
            SizedBox(height: 10.h),
            _clinicCard(l10n),
            SizedBox(height: 8.h),
            _plansCard(l10n),
            if (isDesktop) ...[
              const SizedBox(height: 16),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: DentaButton(
                  label: actionLabel,
                  busy: _submitting,
                  onTap: _submit,
                ),
              ),
            ],
          ],
        ),
      ),
    );

    return AdaptivePageScaffold(
      title: l10n.openClinicTitle,
      onBack: () => context.pop(),
      backgroundColor: c.scaffoldBg,
      bottomNavigationBar: isDesktop
          ? null
          : FormActionBar(
              label: actionLabel,
              busy: _submitting,
              onPressed: _submit,
            ),
      body: body,
    );
  }

  Widget _clinicCard(AppLocalizations l10n) {
    return FormSectionCard(
      title: l10n.clinicDetailsSection,
      children: [
        FormTextField(
          label: l10n.clinicNameRequired.replaceAll('*', '').trim(),
          required: true,
          controller: _name,
          textCapitalization: TextCapitalization.words,
          errorText: _nameError(l10n),
          onChanged: () => setState(() => _serverErrors = const {}),
        ),
        ClinicTypeSelector(
          value: _type,
          errorText: _typeError(l10n),
          onChanged: (type) => setState(() => _type = type),
        ),
        _locationField(l10n),
        FormTextField(
          label: l10n.detailedAddress,
          controller: _address,
          maxLines: 2,
          errorText: _addressError(l10n),
          onChanged: () => setState(() => _serverErrors = const {}),
        ),
      ],
    );
  }

  Widget _locationField(AppLocalizations l10n) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final selected = _location;

    if (selected != null) {
      return FormPickerField(
        label: l10n.locationRequired.replaceAll('*', '').trim(),
        required: true,
        value: selected.fullName.isNotEmpty ? selected.fullName : selected.name,
        action: FormInlineAction(
          label: l10n.edit,
          onTap: () => setState(() {
            _location = null;
            _locationQuery.clear();
            _locationResults = const [];
          }),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormTextField(
          label: l10n.locationRequired.replaceAll('*', '').trim(),
          required: true,
          controller: _locationQuery,
          hintText: l10n.searchForLocation,
          errorText: _locationError(l10n),
          onChanged: _onLocationQuery,
          suffix: _searchingLocations
              ? SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
              : null,
        ),
        if (_locationResults.isNotEmpty)
          Container(
            margin: EdgeInsets.only(top: 6.h),
            decoration: BoxDecoration(
              color: c.cardBg,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: c.borderLight),
            ),
            child: Column(
              children: [
                for (final loc in _locationResults.take(8))
                  ListTile(
                    dense: true,
                    title: Text(
                      loc.name,
                      style: TextStyle(fontFamily: family, fontSize: 13.sp),
                    ),
                    subtitle: loc.fullName.isEmpty
                        ? null
                        : Text(
                            loc.fullName,
                            style: TextStyle(
                              fontFamily: family,
                              fontSize: 11.sp,
                              color: c.textSecondary,
                            ),
                          ),
                    onTap: () => setState(() {
                      _location = loc;
                      _locationResults = const [];
                      _serverErrors = const {};
                    }),
                  ),
              ],
            ),
          )
        else if (!_searchingLocations &&
            _locationQuery.text.trim().length >= 2 &&
            (_debounce == null || !_debounce!.isActive))
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              l10n.noLocationsFound,
              style: TextStyle(
                fontFamily: family,
                fontSize: 11.5.sp,
                color: c.textTertiary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _plansCard(AppLocalizations l10n) {
    final eligible = _trialEligible;
    final children = <Widget>[
      // Said once, kindly - not a warning: this account had its trial.
      if (eligible == false) _NoTrialBanner(text: l10n.noTrialBanner),
    ];

    if (_plansLoading || eligible == null) {
      children.addAll([
        for (var i = 0; i < 2; i++)
          ShimmerBox(
            width: double.infinity,
            height: 120.h,
            radius: BorderRadius.circular(16.r),
          ),
      ]);
    } else if (_plansFailed || _plans.isEmpty) {
      children.add(StateCard(
        icon: Icons.cloud_off_rounded,
        tone: ColorManager.error,
        title: l10n.noPlansAvailable,
        actionLabel: l10n.retry,
        onAction: _loadPlans,
      ));
    } else {
      for (final plan in _plans) {
        children.add(PlanOptionCard(
          plan: plan,
          selected: plan.id == _planId,
          // The trial, its days and the price after it - only to an account
          // that will get it.
          showTrial: eligible,
          features: _features[plan.id],
          featuresLoading: _featuresLoading.contains(plan.id),
          onTap: () => setState(() {
            _planId = plan.id;
            _serverErrors = const {};
          }),
          onShowFeatures: () => _loadFeatures(plan.id),
        ));
      }
      final planError = _serverErrors['plan_version_id'];
      if (planError != null) children.add(FormErrorLine(message: planError));
    }

    return FormSectionCard(title: l10n.chooseYourPlan, children: children);
  }
}

class _NoTrialBanner extends StatelessWidget {
  const _NoTrialBanner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.info.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.info.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, size: 18.w, color: ColorManager.info),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: FontHelper.fontFamily(context),
                fontSize: 12.sp,
                height: 1.5,
                color: c.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
