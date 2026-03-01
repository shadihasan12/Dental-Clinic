import 'dart:async';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
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
      backgroundColor: ColorManager.white,
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
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: ColorManager.gray100,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: ColorManager.textPrimary,
                          size: 18.w,
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Title
                    Text(
                      l10n.completeYourProfile,
                      style: TextStyle(
                        fontSize: FontSizesManager.s28,
                        fontWeight: FontWeightManager.bold,
                        fontFamily: fontFamily,
                        color: ColorManager.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      l10n.setupClinicDetails,
                      style: TextStyle(
                        fontSize: FontSizesManager.s14,
                        fontFamily: fontFamily,
                        color: ColorManager.textSecondary,
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.infoLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorManager.infoLight.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 20.w,
            color: ColorManager.infoExtraLight,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              l10n.clinicDetailsInfo,
              style: TextStyle(
                color: ColorManager.infoExtraLight,
                fontFamily: fontFamily,
                fontSize: FontSizesManager.s12,
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
          onChanged: _onLocationSearchChanged,
        ),

        if (_locationSearchController.text.trim().length >= 2 &&
            state.searchedLocations.isNotEmpty &&
            state.selectedLocation == null)
          Container(
            margin: EdgeInsets.only(top: 8.h),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: ColorManager.gray300),
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
              itemCount: state.searchedLocations.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: ColorManager.gray300),
              itemBuilder: (context, index) {
                final location = state.searchedLocations[index];
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
                      color: ColorManager.textSecondary,
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
          Container(
            margin: EdgeInsets.only(top: 8.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: ColorManager.gray100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              l10n.noLocationsFound,
              style: TextStyle(
                fontSize: FontSizesManager.s14,
                fontFamily: fontFamily,
                color: ColorManager.textSecondary,
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
        ],
      ),
    );
  }

  Widget _buildBottomButton(AppLocalizations l10n) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: ColorManager.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
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
