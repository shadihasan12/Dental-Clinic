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
  final _locationFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _showValidationErrors = false;
  bool _isEditingLocation = false;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AuthBloc>().state;
      if (state.clinicName.isNotEmpty) {
        _clinicNameController.text = state.clinicName;
      }
      if (state.clinicAddress.isNotEmpty) {
        _addressController.text = state.clinicAddress;
      }
    });
  }

  @override
  void dispose() {
    _clinicNameController.dispose();
    _addressController.dispose();
    _locationSearchController.dispose();
    _locationFocusNode.dispose();
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

  void _startEditingLocation() {
    setState(() => _isEditingLocation = true);
    _locationSearchController.clear();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _locationFocusNode.requestFocus(),
    );
  }

  void _onLocationSelected(LocationEntity location) {
    context.read<AuthBloc>().add(
      AuthEvent.signupLocationEntitySelected(location),
    );
    _locationSearchController.clear();
    setState(() => _isEditingLocation = false);
  }

  void _handleCreate() {
    setState(() => _showValidationErrors = true);
    final l10n = AppLocalizations.of(context)!;
    final state = context.read<AuthBloc>().state;

    if (!(_formKey.currentState?.validate() ?? false)) return;

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

                    SizedBox(height: 28.h),

                    // Title
                    Text(
                      l10n.completeYourProfile,
                      style: TextStyle(
                        fontSize: FontSizesManager.s24,
                        fontWeight: FontWeightManager.bold,
                        fontFamily: fontFamily,
                        color: ColorManager.textPrimary,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      l10n.setupClinicDetails,
                      style: TextStyle(
                        fontSize: FontSizesManager.s14,
                        fontFamily: fontFamily,
                        color: ColorManager.textSecondary,
                        height: 1.4,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    _buildInfoBox(l10n, fontFamily),

                    SizedBox(height: 24.h),

                    // Clinic name field
                    _buildSectionLabel(l10n.clinicNameRequired, fontFamily),
                    SizedBox(height: 8.h),
                    AuthTextField(
                      label: '',
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

                    SizedBox(height: 24.h),

                    // Location field
                    _buildSectionLabel(l10n.locationRequired, fontFamily),
                    SizedBox(height: 8.h),
                    _buildLocationSection(state, l10n, fontFamily),

                    SizedBox(height: 24.h),

                    // Detailed address — text area
                    _buildSectionLabel(l10n.detailedAddress, fontFamily),
                    SizedBox(height: 8.h),
                    _buildAddressTextArea(fontFamily),

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

  Widget _buildSectionLabel(String text, String fontFamily) {
    return Text(
      text,
      style: TextStyle(
        fontSize: FontSizesManager.s14,
        fontWeight: FontWeightManager.semiBold,
        fontFamily: fontFamily,
        color: ColorManager.textPrimary,
      ),
    );
  }

  Widget _buildInfoBox(AppLocalizations l10n, String fontFamily) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 18.w,
            color: ColorManager.primaryDark,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              l10n.clinicDetailsInfo,
              style: TextStyle(
                color: ColorManager.primaryDark,
                fontFamily: fontFamily,
                fontSize: FontSizesManager.s13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(
    AuthState state,
    AppLocalizations l10n,
    String fontFamily,
  ) {
    final hasSelection = state.selectedLocation != null;
    final showSearch = !hasSelection || _isEditingLocation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selected location card (only when selected and not actively editing)
        if (hasSelection && !_isEditingLocation)
          _buildSelectedLocationCard(state.selectedLocation!, fontFamily),

        // Search field (when no selection OR when editing)
        if (showSearch) ...[
          TextFormField(
            controller: _locationSearchController,
            focusNode: _locationFocusNode,
            onChanged: _onLocationSearchChanged,
            style: TextStyle(
              color: ColorManager.textPrimary,
              fontFamily: fontFamily,
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText: l10n.searchForLocation,
              hintStyle: TextStyle(
                color: ColorManager.textTertiary,
                fontFamily: fontFamily,
                fontSize: 13.sp,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: ColorManager.textTertiary,
                size: 20.w,
              ),
              suffixIcon: state.isSearchingLocations
                  ? Padding(
                      padding: EdgeInsets.all(12.w),
                      child: SizedBox(
                        width: 18.w,
                        height: 18.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ColorManager.primary,
                        ),
                      ),
                    )
                  : null,
              filled: true,
              fillColor: ColorManager.gray50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: ColorManager.primary,
                  width: 1.5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),

          // Search results dropdown
          if (_locationSearchController.text.trim().length >= 2 &&
              state.searchedLocations.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 6.h),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: ColorManager.gray200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              constraints: BoxConstraints(maxHeight: 220.h),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: state.searchedLocations.length,
                  separatorBuilder: (context, i) =>
                      Divider(height: 1, color: ColorManager.gray100),
                  itemBuilder: (context, index) {
                    final location = state.searchedLocations[index];
                    return InkWell(
                      onTap: () => _onLocationSelected(location),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 18.w,
                              color: ColorManager.primary,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    location.name,
                                    style: TextStyle(
                                      fontSize: FontSizesManager.s14,
                                      fontFamily: fontFamily,
                                      fontWeight: FontWeightManager.medium,
                                      color: ColorManager.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    location.fullName,
                                    style: TextStyle(
                                      fontSize: FontSizesManager.s12,
                                      fontFamily: fontFamily,
                                      color: ColorManager.textSecondary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

          // No results message
          if (_locationSearchController.text.trim().length >= 2 &&
              !state.isSearchingLocations &&
              state.searchedLocations.isEmpty)
            Container(
              margin: EdgeInsets.only(top: 6.h),
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: ColorManager.gray50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: ColorManager.gray200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_off_outlined,
                    size: 16.w,
                    color: ColorManager.textTertiary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    l10n.noLocationsFound,
                    style: TextStyle(
                      fontSize: FontSizesManager.s13,
                      fontFamily: fontFamily,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ],
    );
  }

  Widget _buildSelectedLocationCard(
    LocationEntity location,
    String fontFamily,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.primary10,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 34.w,
            height: 34.w,
            decoration: BoxDecoration(
              color: ColorManager.primary20,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.location_on,
              color: ColorManager.primaryDark,
              size: 18.w,
            ),
          ),
          SizedBox(width: 12.w),
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
                    color: ColorManager.primaryDark,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  location.fullName,
                  style: TextStyle(
                    fontSize: FontSizesManager.s12,
                    fontFamily: fontFamily,
                    color: ColorManager.primaryDarker,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: _startEditingLocation,
            child: Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: ColorManager.primary20,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.edit_outlined,
                size: 14.w,
                color: ColorManager.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressTextArea(String fontFamily) {
    return TextFormField(
      controller: _addressController,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      minLines: 3,
      style: TextStyle(
        color: ColorManager.textPrimary,
        fontFamily: fontFamily,
        fontSize: 14.sp,
        height: 1.5,
      ),
      decoration: InputDecoration(
        hintText: '...',
        hintStyle: TextStyle(
          color: ColorManager.textTertiary,
          fontFamily: fontFamily,
          fontSize: 13.sp,
        ),
        filled: true,
        fillColor: ColorManager.gray50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: ColorManager.primary,
            width: 1.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
        ),
        alignLabelWithHint: true,
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
                  state.clinicName.trim().isNotEmpty &&
                  state.selectedLocation != null &&
                  !_isEditingLocation &&
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
