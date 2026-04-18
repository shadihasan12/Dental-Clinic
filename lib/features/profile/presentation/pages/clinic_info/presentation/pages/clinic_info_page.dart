import 'dart:async';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/desktop_shell.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/custom_widgets/permission_gate.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/location_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/entities/clinic_info_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/domain/repositories/clinic_info_repository.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/presentation/manager/clinic_info_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/permissions/permission_slugs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
  List<LocationEntity> _searchedLocations = [];
  bool _isSearchingLocations = false;

  @override
  void initState() {
    super.initState();
    _clinicNameController = TextEditingController();
    _addressController = TextEditingController();
    _locationSearchController = TextEditingController();
  }

  @override
  void dispose() {
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

  void _onSave() {
    if (_originalEntity == null) return;
    final entity = ClinicInfoEntity(
      id: _clinicId,
      name: _clinicNameController.text.trim(),
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
            AppLoadingDialog.show(
              context: context,
              message: l10n.save,
            );
          },
          saved: (_) {
            AppLoadingDialog.dismiss(context);
            AppSnackbar.showSuccess(
              context,
              title: l10n.success,
              message: l10n.saveChanges,
            );
          },
          error: (message) {
            AppLoadingDialog.dismiss(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final c = ColorManager.of(context);
        final isDesktop = Responsive.isDesktop(context);

        final content = state.maybeWhen(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (message) => Center(child: Text(message)),
          loaded: (clinicInfo) {
            if (!_formPopulated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() => _populateFromEntity(clinicInfo));
              });
              return const Center(child: CircularProgressIndicator());
            }
            return _buildForm(l10n, isDesktop);
          },
          orElse: () {
            if (!_formPopulated) {
              return const SizedBox.shrink();
            }
            return _buildForm(l10n, isDesktop);
          },
        );

        if (isDesktop) {
          return DesktopShell(
            title: l10n.clinicInformation,
            body: Scaffold(
              backgroundColor: c.scaffoldBg,
              bottomNavigationBar:
                  _formPopulated ? _buildSaveButton(l10n, isDesktop) : null,
              body: content,
            ),
          );
        }

        return Scaffold(
          backgroundColor: c.scaffoldBg,
          bottomNavigationBar:
              _formPopulated ? _buildSaveButton(l10n, isDesktop) : null,
          body: Column(
            children: [
              PageHeader(
                title: l10n.clinicInformation,
                onBack: () => context.pop(),
              ),
              Expanded(child: content),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForm(AppLocalizations l10n, bool isDesktop) {
    final fontFamily = FontHelper.fontFamily(context);
    final form = Column(
      children: [
        CustomCard(child: _buildClinicNameField()),
        SizedBox(height: isDesktop ? 16 : 16.h),
        CustomCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLocationSearch(l10n, fontFamily),
              if (_selectedLocation != null) ...[
                SizedBox(height: 12.h),
                _buildSelectedLocation(_selectedLocation!, fontFamily),
              ],
              SizedBox(height: 16.h),
              _buildAddressField(l10n, fontFamily),
            ],
          ),
        ),
        SizedBox(height: isDesktop ? 24 : 24.h),
      ],
    );

    if (isDesktop) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: form,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: form,
    );
  }

  Widget _buildSaveButton(AppLocalizations l10n, bool isDesktop) {
    final button = GestureDetector(
      onTap: _onSave,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: isDesktop ? 14 : 14.h),
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadiusManager.lg,
        ),
        child: Text(
          l10n.save,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isDesktop ? 15 : 15.sp,
            fontFamily: FontHelper.fontFamily(context),
            fontWeight: FontWeight.w600,
            color: ColorManager.white,
          ),
        ),
      ),
    );

    if (isDesktop) {
      return Container(
        padding: const EdgeInsets.fromLTRB(28, 14, 28, 20),
        decoration: BoxDecoration(
          color: ColorManager.of(context).cardBg,
          border: Border(
            top: BorderSide(color: ColorManager.of(context).borderLight),
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: button,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: button,
    );
  }

  Widget _buildClinicNameField() {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    return Row(
      children: [
        Icon(
          Icons.business_outlined,
          size: 18.w,
          color: c.textTertiary,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.clinicName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: c.textTertiary,
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: _clinicNameController,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: FontHelper.fontFamily(context),
                  color: c.textPrimary,
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSearch(AppLocalizations l10n, String fontFamily) {
    final c = ColorManager.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.location,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: fontFamily,
            color: c.textTertiary,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _locationSearchController,
          onChanged: _onLocationSearchChanged,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: fontFamily,
            color: c.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: l10n.searchForLocation,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: fontFamily,
              color: c.textTertiary,
            ),
            prefixIcon: Icon(Icons.search, size: 20.w, color: c.textTertiary),
            suffixIcon: _isSearchingLocations
                ? Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorManager.primary,
                      ),
                    ),
                  )
                : null,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            filled: true,
            fillColor: c.cardBgSecondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        if (_locationSearchController.text.trim().length >= 2 &&
            _searchedLocations.isNotEmpty &&
            _selectedLocation == null)
          Container(
            margin: EdgeInsets.only(top: 8.h),
            decoration: BoxDecoration(
              color: c.cardBg,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: c.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            constraints: BoxConstraints(maxHeight: 200.h),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _searchedLocations.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: c.border),
              itemBuilder: (context, index) {
                final location = _searchedLocations[index];
                return ListTile(
                  dense: true,
                  title: Text(
                    location.name,
                    style: TextStyle(
                      fontSize: FontSizesManager.s14,
                      fontFamily: fontFamily,
                      fontWeight: FontWeightManager.medium,
                    ),
                  ),
                  subtitle: Text(
                    location.fullName,
                    style: TextStyle(
                      fontSize: FontSizesManager.s12,
                      fontFamily: fontFamily,
                      color: c.textSecondary,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedLocation = location;
                      _searchedLocations = [];
                      _locationSearchController.clear();
                    });
                  },
                );
              },
            ),
          ),
        if (_locationSearchController.text.trim().length >= 2 &&
            !_isSearchingLocations &&
            _searchedLocations.isEmpty &&
            _selectedLocation == null)
          Container(
            margin: EdgeInsets.only(top: 8.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: c.cardBgSecondary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              l10n.noLocationsFound,
              style: TextStyle(
                fontSize: FontSizesManager.s14,
                fontFamily: fontFamily,
                color: c.textSecondary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSelectedLocation(LocationEntity location, String fontFamily) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.primary10,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.primary),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on, color: ColorManager.primary, size: 20.w),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.name,
                  style: TextStyle(
                    fontSize: FontSizesManager.s14,
                    fontFamily: fontFamily,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.primary,
                  ),
                ),
                Text(
                  location.fullName,
                  style: TextStyle(
                    fontSize: FontSizesManager.s12,
                    fontFamily: fontFamily,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _selectedLocation = null),
            child: Icon(Icons.close, size: 18.w, color: ColorManager.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressField(AppLocalizations l10n, String fontFamily) {
    final c = ColorManager.of(context);
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 18.w,
          color: c.textTertiary,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.detailedAddress,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: fontFamily,
                  color: c.textTertiary,
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: _addressController,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: fontFamily,
                  color: c.textPrimary,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: l10n.detailedAddressHint,
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: fontFamily,
                    color: c.textTertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
