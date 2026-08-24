import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'dart:async';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/location_entity.dart';

class FinishProfilePage extends StatefulWidget {
  const FinishProfilePage({super.key});

  @override
  State<FinishProfilePage> createState() => _FinishProfilePageState();
}

class _FinishProfilePageState extends State<FinishProfilePage> {
  final _clinicNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _locationSearchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showValidationErrors = false;
  Timer? _debounce;
  final String _selectedCountryCode = 'SY';

  @override
  void initState() {
    super.initState();
    _clinicNameController.addListener(() {
      context.read<AuthBloc>().add(
        AuthEvent.signupClinicNameChanged(_clinicNameController.text),
      );
    });
    _addressController.addListener(() {
      context.read<AuthBloc>().add(
        AuthEvent.signupClinicAddressChanged(_addressController.text),
      );
    });
  }

  @override
  void dispose() {
    _clinicNameController.dispose();
    _addressController.dispose();
    _locationSearchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  String? _validateClinicName(String? value) {
    if (!_showValidationErrors) return null;
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return l10n.pleaseEnterClinicName;
    }
    if (value.trim().length < 3) {
      return l10n.clinicNameMinChars;
    }
    if (value.trim().length > 100) {
      return l10n.clinicNameMaxChars;
    }
    return null;
  }

  void _onLocationSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.trim().length < 2) {
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<AuthBloc>().add(
        AuthEvent.locationSearchRequested(
          query: query,
          countryCode: _selectedCountryCode,
        ),
      );
    });
  }

  void _handleCreate() {
    setState(() => _showValidationErrors = true);
    final l10n = AppLocalizations.of(context)!;

    final state = context.read<AuthBloc>().state;

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (state.selectedLocation == null) {
      AppSnackbar.showError(
        context,
        title: l10n.validationError,
        message: l10n.pleaseSelectLocation,
      );
      return;
    }

    if (state.selectedPlan == null) {
      AppSnackbar.showError(
        context,
        title: l10n.validationError,
        message: l10n.pleaseSelectPlan,
      );
      return;
    }

    if (state.selectedSpecialty == null) {
      AppSnackbar.showError(
        context,
        title: l10n.validationError,
        message: l10n.pleaseSelectSpecialization,
      );
      return;
    }

    if (state.sessionId == null || state.sessionId!.isEmpty) {
      AppSnackbar.showError(
        context,
        title: l10n.sessionExpired,
        message: l10n.pleaseVerifyEmailAgain,
      );
      return;
    }

    context.read<AuthBloc>().add(const AuthEvent.signupSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    return Scaffold(
      backgroundColor: ColorManager.of(context).scaffoldBg,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            AppSnackbar.showSuccess(
              context,
              title: l10n.welcome,
              message: l10n.accountCreatedSuccessfully,
            );
            context.goNamed(AppRoutesNames.root);
          }

          if (state.signupError != null) {
            AppSnackbar.showError(
              context,
              title: l10n.registrationFailed,
              message: state.signupError,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),

                    // Back button
                    AuthBackButton(onTap: () => context.pop()),

                    SizedBox(height: 24.h),

                    // Title
                    Text(
                      l10n.completeYourProfile,
                      style: TextStyle(
                        fontSize: FontSizesManager.s28,
                        fontWeight: FontWeightManager.bold,
                        fontFamily: fontFamily,
                        color: ColorManager.of(context).textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      l10n.setupClinicDetails,
                      style: TextStyle(
                        fontSize: FontSizesManager.s14,
                        fontFamily: fontFamily,
                        color: ColorManager.of(context).textSecondary,
                      ),
                    ),

                    SizedBox(height: 24.h),

                    _buildInfoBox(l10n, fontFamily),

                    SizedBox(height: 20.h),

                    AuthTextField(
                      label: l10n.clinicNameRequired,
                      hint: l10n.clinicNameHintExample,
                      controller: _clinicNameController,
                      prefixIcon: Icons.business_outlined,
                      keyboardType: TextInputType.text,
                      validator: _validateClinicName,
                      onChanged: (value) {
                        if (_showValidationErrors) {
                          _formKey.currentState?.validate();
                        }
                      },
                    ),

                    SizedBox(height: 20.h),

                    _buildLocationSearch(state, l10n, fontFamily),

                    if (state.selectedLocation != null) ...[
                      SizedBox(height: 12.h),
                      _buildSelectedLocation(
                        state.selectedLocation!,
                        fontFamily,
                      ),
                    ],

                    SizedBox(height: 20.h),

                    AuthTextField(
                      label: l10n.detailedAddress,
                      hint: l10n.detailedAddressHint,
                      controller: _addressController,
                      prefixIcon: Icons.location_on_outlined,
                      keyboardType: TextInputType.streetAddress,
                    ),

                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomButton(l10n),
    );
  }

  Widget _buildInfoBox(AppLocalizations l10n, String fontFamily) {
    return Container(
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        color: ColorManager.infoLight.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(
          color: ColorManager.infoLight.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 16.w,
            color: ColorManager.infoExtraLight,
          ),
          SizedBox(width: 9.w),
          Expanded(
            child: Text(
              l10n.clinicDetailsInfo,
              style: TextStyle(
                color: ColorManager.infoExtraLight,
                fontFamily: fontFamily,
                fontSize: 11.5.sp,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSearch(
    AuthState state,
    AppLocalizations l10n,
    String fontFamily,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthTextField(
          label: l10n.locationRequired,
          hint: l10n.searchForLocation,
          controller: _locationSearchController,
          prefixIcon: Icons.search,
          suffixIcon: state.isSearchingLocations
              ? Padding(
                  padding: EdgeInsetsDirectional.only(end: 12.w),
                  child: Center(
                    widthFactor: 1,
                    child: SizedBox(
                      width: 15.w,
                      height: 15.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                )
              : null,
          onChanged: _onLocationSearchChanged,
        ),

        if (_locationSearchController.text.trim().length >= 2 &&
            state.searchedLocations.isNotEmpty &&
            state.selectedLocation == null)
          Container(
            margin: EdgeInsets.only(top: 6.h),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: ColorManager.of(context).cardBg,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: ColorManager.of(context).borderLight),
            ),
            constraints: BoxConstraints(maxHeight: 200.h),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: state.searchedLocations.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: ColorManager.of(context).borderLight,
              ),
              itemBuilder: (context, index) {
                final location = state.searchedLocations[index];
                return ListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                  title: Text(
                    location.name,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.of(context).textPrimary,
                    ),
                  ),
                  subtitle: Text(
                    location.fullName,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: fontFamily,
                      color: ColorManager.of(context).textSecondary,
                    ),
                  ),
                  onTap: () {
                    context.read<AuthBloc>().add(
                      AuthEvent.signupLocationEntitySelected(location),
                    );
                    _locationSearchController.clear();
                  },
                );
              },
            ),
          ),

        if (_locationSearchController.text.trim().length >= 2 &&
            !state.isSearchingLocations &&
            state.searchedLocations.isEmpty &&
            state.selectedLocation == null)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              l10n.noLocationsFound,
              style: TextStyle(
                fontSize: 11.5.sp,
                fontFamily: fontFamily,
                color: ColorManager.of(context).textTertiary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSelectedLocation(LocationEntity location, String fontFamily) {
    final c = ColorManager.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? ColorManager.primary : ColorManager.primaryDarker;

    // Same tinted-surface treatment the appointment patient picker uses for
    // its chosen value: 8% fill, a 30% hairline, not a full-strength border.
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.30),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, color: accent, size: 17.w),
          SizedBox(width: 9.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                    color: c.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(AppLocalizations l10n) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16.w),
          // Elevation in this design language is a border, not a shadow.
          decoration: BoxDecoration(
            color: ColorManager.of(context).surfaceBg,
            border: Border(
              top: BorderSide(color: ColorManager.of(context).borderLight),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: scaffoldBottomInset(context),
            ),
            child: PrimaryButton(
              text: l10n.completeRegistration,
              isEnabled:
                  _clinicNameController.text.trim().isNotEmpty &&
                  state.selectedLocation != null &&
                  !state.isSignupLoading,
              isLoading: state.isSignupLoading,
              onPressed: _handleCreate,
            ),
          ),
        );
      },
    );
  }
}
