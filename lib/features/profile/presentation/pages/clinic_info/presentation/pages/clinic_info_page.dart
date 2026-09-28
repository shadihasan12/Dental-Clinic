import 'package:dental_clinic_app/core/utils/bloc_settled.dart';
import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'dart:async';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/location_entity.dart';
import 'package:dental_clinic_app/features/clinic/domain/entities/clinic_type.dart';
import 'package:dental_clinic_app/features/clinic/presentation/widgets/clinic_type_selector.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/entities/clinic_info_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/repositories/clinic_info_repository.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/manager/clinic_info_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Desktop column cap. Two form cards side by side need ~500px each to keep
/// the type options and the address box readable; wider than this and the
/// fields turn into long empty strips again.
const double _desktopMaxWidth = 1040;

/// Below this the two cards stack - a narrow desktop window (the side menu
/// takes ~250px) would otherwise squeeze each card under its fields' width.
const double _desktopTwoUpMinWidth = 820;

class ClinicInfoPage extends StatelessWidget {
  const ClinicInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ClinicInfoBloc>()..add(const ClinicInfoEvent.loadClinicInfo()),
      child: const _ClinicInfoContent(),
    );
  }
}

class _ClinicInfoContent extends StatefulWidget {
  const _ClinicInfoContent();

  @override
  State<_ClinicInfoContent> createState() => _ClinicInfoContentState();
}

class _ClinicInfoContentState extends State<_ClinicInfoContent> {
  late final TextEditingController _clinicNameController;
  late final TextEditingController _addressController;
  late final TextEditingController _locationSearchController;
  String _clinicId = '';
  bool _formPopulated = false;
  ClinicInfoEntity? _originalEntity;
  Timer? _debounce;

  LocationEntity? _selectedLocation;
  ClinicType? _clinicType;
  List<LocationEntity> _searchedLocations = [];
  bool _isSearchingLocations = false;

  @override
  void initState() {
    super.initState();
    _clinicNameController = TextEditingController();
    _addressController = TextEditingController();
    _locationSearchController = TextEditingController();
    // Save is gated on the form actually differing from what was loaded, so
    // every keystroke has to re-evaluate it.
    _clinicNameController.addListener(_onFieldEdited);
    _addressController.addListener(_onFieldEdited);
  }

  @override
  void dispose() {
    _clinicNameController.removeListener(_onFieldEdited);
    _addressController.removeListener(_onFieldEdited);
    _clinicNameController.dispose();
    _addressController.dispose();
    _locationSearchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _populateFromEntity(ClinicInfoEntity entity) {
    _clinicId = entity.id;
    _clinicNameController.text = entity.name;
    _addressController.text = entity.address;
    _clinicType = entity.type;
    _originalEntity = entity;

    if (entity.locationId.isNotEmpty) {
      _selectedLocation = LocationEntity(
        id: entity.locationId,
        name: entity.locationName,
        fullName: entity.locationFullName,
        countryCode: '',
      );
    }

    _formPopulated = true;
  }

  void _onLocationSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.trim().length < 2) {
      setState(() {
        _searchedLocations = [];
        _isSearchingLocations = false;
      });
      return;
    }

    setState(() => _isSearchingLocations = true);

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final result = await getIt<ClinicInfoRepository>().searchLocations(
        query: query,
        countryCode: 'SY',
      );
      if (!mounted) return;
      result.fold(
        (_) => setState(() {
          _searchedLocations = [];
          _isSearchingLocations = false;
        }),
        (locations) => setState(() {
          _searchedLocations = locations;
          _isSearchingLocations = false;
        }),
      );
    });
  }

  void _onFieldEdited() {
    if (mounted) setState(() {});
  }

  /// True when the form differs from what was loaded. Clearing the location
  /// chip without picking another is not a change: [_onSave] falls back to
  /// the original id, so nothing would be written.
  bool get _hasChanges {
    final original = _originalEntity;
    if (original == null) return false;

    final name = _clinicNameController.text.trim();
    // A clinic cannot be saved without a name, so an empty field is never
    // a saveable state even though it differs from what was loaded.
    if (name.isEmpty) return false;

    final locationId = _selectedLocation?.id ?? original.locationId;
    return name != original.name.trim() ||
        _addressController.text.trim() != original.address.trim() ||
        locationId != original.locationId ||
        _clinicType != original.type;
  }

  void _onSave() {
    if (_originalEntity == null || !_hasChanges) return;
    final entity = ClinicInfoEntity(
      id: _clinicId,
      name: _clinicNameController.text.trim(),
      type: _clinicType,
      locationId: _selectedLocation?.id ?? _originalEntity!.locationId,
      locationName: _selectedLocation?.name ?? _originalEntity!.locationName,
      locationFullName:
          _selectedLocation?.fullName ?? _originalEntity!.locationFullName,
      address: _addressController.text.trim(),
      workingDays: _originalEntity!.workingDays,
      holidays: _originalEntity!.holidays,
    );
    context.read<ClinicInfoBloc>().add(
          ClinicInfoEvent.updateClinicInfo(entity),
        );
  }

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<ClinicInfoBloc>();
    bloc.add(const ClinicInfoEvent.loadClinicInfo());
    await bloc.stream.settled(
      (state) => state.maybeMap(loading: (_) => false, orElse: () => true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<ClinicInfoBloc, ClinicInfoState>(
      buildWhen: (prev, curr) => curr.maybeMap(
        loading: (_) => true,
        loaded: (_) => true,
        error: (_) => true,
        orElse: () => false,
      ),
      listenWhen: (prev, curr) => curr.maybeMap(
        saving: (_) => true,
        saved: (_) => true,
        error: (_) => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.maybeWhen(
          saving: (_) {
            AppLoadingDialog.show(context: context, message: l10n.save);
          },
          saved: (entity) {
            AppLoadingDialog.dismiss(context);
            // What was just written becomes the new baseline, otherwise the
            // form stays permanently dirty and Save never re-disables.
            setState(() => _originalEntity = entity);
            AppSnackbar.showSuccess(
              context,
              title: l10n.success,
              message: l10n.saveChanges,
            );
          },
          error: (message) {
            AppLoadingDialog.dismiss(context);
            AppSnackbar.showError(context, title: message);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final c = ColorManager.of(context);
        return AdaptivePageScaffold(
          title: l10n.clinicInformation,
          body: state.maybeWhen(
            loading: () => const _ClinicInfoSkeleton(),
            // Pull-to-refresh is offered on the failure state only. Once
            // the form is populated it may hold unsaved edits, and a
            // refetch would silently throw them away.
            error: (message) => DentaRefresh(
              onRefresh: () => _refresh(context),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 28.h),
                // No-op on mobile; keeps the card from spanning the window.
                child: AdaptiveContentWidth(
                  maxWidth: 640,
                  child: StateCard(
                    icon: Icons.cloud_off_rounded,
                    tone: ColorManager.error,
                    title: l10n.clinicInfoLoadFailed,
                    message: message,
                    actionLabel: l10n.retry,
                    onAction: () => context.read<ClinicInfoBloc>().add(
                      const ClinicInfoEvent.loadClinicInfo(),
                    ),
                  ),
                ),
              ),
            ),
            loaded: (clinicInfo) {
              if (!_formPopulated) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() => _populateFromEntity(clinicInfo));
                });
                return const _ClinicInfoSkeleton();
              }
              return _buildForm(l10n);
            },
            orElse: () {
              if (!_formPopulated) {
                return const SizedBox.shrink();
              }
              return _buildForm(l10n);
            },
          ),
          onBack: () => context.pop(),
          backgroundColor: c.scaffoldBg,
          // Desktop saves from the end of the form instead: a docked bar
          // across a monitor-wide window is a long empty strip.
          bottomNavigationBar:
              _formPopulated && !Responsive.isDesktop(context)
                  ? _buildSaveButton(l10n)
                  : null,
        );
      },
    );
  }

  Widget _buildForm(AppLocalizations l10n) {
    if (Responsive.isDesktop(context)) return _buildDesktopForm(l10n);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInfoCard(l10n),
          SizedBox(height: 8.h),
          _buildLocationCard(l10n),
        ],
      ),
    );
  }

  /// Desktop puts the two cards side by side in a capped column, with Save
  /// closing the form at its end rather than docked across the window.
  Widget _buildDesktopForm(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
      child: AdaptiveContentWidth(
        maxWidth: _desktopMaxWidth,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final twoUp = constraints.maxWidth >= _desktopTwoUpMinWidth;
            final info = _buildInfoCard(l10n);
            final location = _buildLocationCard(l10n);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top-aligned rather than equal height: the location card
                // grows while search results are open, and stretching the
                // other card along with it would make it jump.
                if (twoUp)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: info),
                      const SizedBox(width: 16),
                      Expanded(child: location),
                    ],
                  )
                else ...[
                  info,
                  const SizedBox(height: 12),
                  location,
                ],
                const SizedBox(height: 20),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: DesktopPrimaryButton(
                    label: l10n.save,
                    icon: Icons.check_rounded,
                    onPressed: _hasChanges ? _onSave : null,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard(AppLocalizations l10n) {
    return FormSectionCard(
      title: l10n.clinicInformation,
      children: [
        FormTextField(
          label: l10n.clinicName,
          required: true,
          controller: _clinicNameController,
          textCapitalization: TextCapitalization.words,
        ),
        ClinicTypeSelector(
          value: _clinicType,
          onChanged: (type) => setState(() => _clinicType = type),
        ),
      ],
    );
  }

  Widget _buildLocationCard(AppLocalizations l10n) {
    final fontFamily = FontHelper.fontFamily(context);
    return FormSectionCard(
      title: l10n.location,
      children: [
        if (_selectedLocation != null)
          _buildSelectedLocation(_selectedLocation!, fontFamily)
        else
          _buildLocationSearch(l10n, fontFamily),
        FormTextField(
          label: l10n.detailedAddress,
          controller: _addressController,
          hintText: l10n.detailedAddress,
          maxLines: 2,
        ),
      ],
    );
  }

  /// Docked primary action in the thumb arc, on its own surface so the form
  /// scrolls behind it.
  Widget _buildSaveButton(AppLocalizations l10n) {
    final c = ColorManager.of(context);
    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        border: Border(top: BorderSide(color: c.borderLight)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: scaffoldBottomInset(context)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 10.h),
          child: DentaButton(
            label: l10n.save,
            expand: true,
            onTap: _hasChanges ? _onSave : null,
          ),
        ),
      ),
    );
  }

  /// Search box plus its results. Once a location is picked the search is
  /// replaced by the chip, so the card never shows two ways to answer the
  /// same question at once.
  Widget _buildLocationSearch(AppLocalizations l10n, String fontFamily) {
    final c = ColorManager.of(context);
    final query = _locationSearchController.text.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormTextField(
          label: l10n.location,
          required: true,
          controller: _locationSearchController,
          hintText: l10n.searchForLocation,
          onChanged: () =>
              _onLocationSearchChanged(_locationSearchController.text),
          suffix: _isSearchingLocations
              ? SizedBox(
                  width: 14.w,
                  height: 14.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(ColorManager.primary),
                  ),
                )
              : Icon(Icons.search, size: 18.w, color: c.textTertiary),
        ),
        if (query.length >= 2 && _searchedLocations.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(
              color: c.cardBg,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: c.borderLight),
            ),
            clipBehavior: Clip.antiAlias,
            constraints: BoxConstraints(maxHeight: 200.h),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _searchedLocations.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: c.borderLight),
              itemBuilder: (context, index) {
                final location = _searchedLocations[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedLocation = location;
                      _searchedLocations = [];
                      _locationSearchController.clear();
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w600,
                            color: c.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          location.fullName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: fontFamily,
                            color: c.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
        if (query.length >= 2 &&
            !_isSearchingLocations &&
            _searchedLocations.isEmpty) ...[
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: c.cardBgSecondary,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: c.borderLight),
            ),
            child: Text(
              l10n.noLocationsFound,
              style: TextStyle(
                fontSize: 11.5.sp,
                fontFamily: fontFamily,
                color: c.textTertiary,
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// The answer, once given. Sits in the same shell as the search box it
  /// replaces, so the card keeps one rhythm.
  Widget _buildSelectedLocation(LocationEntity location, String fontFamily) {
    return FormFieldShell(
      label: AppLocalizations.of(context)!.location,
      required: true,
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(12.w, 10.h, 8.w, 10.h),
        decoration: BoxDecoration(
          color: ColorManager.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorManager.primary, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: ColorManager.primaryDarker,
              size: 18.w,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primaryDarker,
                    ),
                  ),
                  if (location.fullName.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      location.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontFamily: fontFamily,
                        color: ColorManager.primaryDarker,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _selectedLocation = null),
              child: Padding(
                padding: EdgeInsets.all(6.w),
                child: Icon(
                  Icons.close,
                  size: 16.w,
                  color: ColorManager.primaryDarker,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Holds the two form cards at full height while the clinic loads.
class _ClinicInfoSkeleton extends StatelessWidget {
  const _ClinicInfoSkeleton();

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return const _DesktopClinicInfoSkeleton();
    }

    final c = ColorManager.of(context);
    Widget block(double height) => Container(
          height: height,
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: c.borderLight),
          ),
        );

    return AppShimmer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 24.h),
        children: [
          block(64.h),
          SizedBox(height: 8.h),
          block(190.h),
        ],
      ),
    );
  }
}

/// Desktop placeholder in the shape of [_ClinicInfoContentState]'s desktop
/// form: the two cards side by side (stacked on a narrow window) and Save at
/// the end. Static on purpose - a shimmer sweep across a monitor-wide area
/// reads as flicker rather than progress.
class _DesktopClinicInfoSkeleton extends StatelessWidget {
  const _DesktopClinicInfoSkeleton();

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    Widget bar(double width, double height, {double radius = 6}) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: c.shimmerBase,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    // Label above an input, matching FormTextField's desktop metrics.
    Widget field({double labelWidth = 90, double height = 52}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bar(labelWidth, 10),
        const SizedBox(height: 8),
        bar(double.infinity, height, radius: 12),
      ],
    );

    // Label above the two clinic-type options.
    Widget typeOptions() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bar(80, 10),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: bar(double.infinity, 46, radius: 12)),
            const SizedBox(width: 8),
            Expanded(child: bar(double.infinity, 46, radius: 12)),
          ],
        ),
      ],
    );

    Widget card({required double titleWidth, required List<Widget> rows}) =>
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: c.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: bar(titleWidth, 14),
              ),
              for (final row in rows) ...[const SizedBox(height: 18), row],
            ],
          ),
        );

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
      child: AdaptiveContentWidth(
        maxWidth: _desktopMaxWidth,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final twoUp = constraints.maxWidth >= _desktopTwoUpMinWidth;
            final info = card(titleWidth: 150, rows: [field(), typeOptions()]);
            final location = card(
              titleWidth: 90,
              rows: [
                field(labelWidth: 70),
                field(labelWidth: 120, height: 72),
              ],
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (twoUp)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: info),
                      const SizedBox(width: 16),
                      Expanded(child: location),
                    ],
                  )
                else ...[
                  info,
                  const SizedBox(height: 12),
                  location,
                ],
                const SizedBox(height: 20),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: bar(96, 42, radius: 10),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
