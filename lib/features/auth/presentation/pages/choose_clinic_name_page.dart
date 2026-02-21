import 'dart:async';
import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/gen/fonts.gen.dart';
import 'package:dental_clinic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_clinic_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/padding_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/location_entity.dart';

class ChooseClinicNamePage extends StatefulWidget {
  const ChooseClinicNamePage({super.key});

  @override
  State<ChooseClinicNamePage> createState() => _ChooseClinicNamePageState();
}

class _ChooseClinicNamePageState extends State<ChooseClinicNamePage> {
  final _clinicNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _locationSearchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showValidationErrors = false;
  Timer? _debounce;
  final String _selectedCountryCode = 'SY'; // Default to Syria

  @override
  void initState() {
    super.initState();
    // Add clinic name change listener
    _clinicNameController.addListener(() {
      context.read<AuthBloc>().add(
            AuthEvent.signupClinicNameChanged(_clinicNameController.text),
          );
    });
    // Add address change listener
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
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your clinic name';
    }
    if (value.trim().length < 3) {
      return 'Clinic name must be at least 3 characters';
    }
    if (value.trim().length > 100) {
      return 'Clinic name must be less than 100 characters';
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

    final state = context.read<AuthBloc>().state;

    // Validate form
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    // Validate required fields from state
    if (state.selectedLocation == null) {
      AppSnackbar.showError(
        context,
        title: 'Validation Error',
        message: 'Please select a location',
      );
      return;
    }

    if (state.selectedPlan == null) {
      AppSnackbar.showError(
        context,
        title: 'Validation Error',
        message: 'Please select a subscription plan',
      );
      return;
    }

    if (state.selectedSpecialty == null) {
      AppSnackbar.showError(
        context,
        title: 'Validation Error',
        message: 'Please select a specialization',
      );
      return;
    }

    // Check if we have session_id from OTP verification
    if (state.sessionId == null || state.sessionId!.isEmpty) {
      AppSnackbar.showError(
        context,
        title: 'Session Expired',
        message: 'Please verify your email again',
      );
      return;
    }

    // Submit registration with session_id
    context.read<AuthBloc>().add(const AuthEvent.signupSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // Handle successful registration
          if (state.status == AuthStatus.authenticated) {
            AppSnackbar.showSuccess(
              context,
              title: 'Welcome!',
              message: 'Your account has been created successfully',
            );
            context.goNamed(AppRoutesNames.root);
          }

          // Handle registration errors
          if (state.signupError != null) {
            AppSnackbar.showError(
              context,
              title: 'Registration Failed',
              message: state.signupError,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            top: false,
            child: Column(
              children: [
                // Gradient Header
                GradientHeader(
                  title: 'Complete Your Profile',
                  subtitle: 'Set up your clinic details',
                  height: 200.h,
                  showBackButton: true,
                  onBackPressed: () => context.pop(),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: PaddingManager.horizontalPadding,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),

                          // Info box
                          _buildInfoBox(),

                          SizedBox(height: 20.h),

                        // Clinic Name Field
                        AuthTextField(
                          label: 'Clinic Name *',
                          hint: 'e.g., Bright Smile Dental Clinic',
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

                        // Location Search Section
                        _buildLocationSearch(state),

                        // Selected Location Display
                        if (state.selectedLocation != null) ...[
                          SizedBox(height: 12.h),
                          _buildSelectedLocation(state.selectedLocation!),
                        ],

                        SizedBox(height: 20.h),

                        // Detailed Address Field
                        AuthTextField(
                          label: 'Detailed Address',
                          hint: 'Street, building number, etc.',
                          controller: _addressController,
                          prefixIcon: Icons.location_on_outlined,
                          keyboardType: TextInputType.streetAddress,
                        ),

                        SizedBox(height: 100.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildInfoBox() {
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
              'Enter your clinic details to complete registration. You can update these later in settings.',
              style: TextStyle(
                color: ColorManager.infoExtraLight,
                fontFamily: FontFamily.geist,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSearch(AuthState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          'Location *',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            fontFamily: FontFamily.geist,
            color: ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),

        // Search Field
        AuthTextField(
          label: '',
          hint: 'Search for location...',
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

        // Search Results
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
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: ColorManager.gray300,
              ),
              itemBuilder: (context, index) {
                final location = state.searchedLocations[index];
                return ListTile(
                  dense: true,
                  title: Text(
                    location.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: FontFamily.geist,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    location.fullName,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: FontFamily.geist,
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

        // Empty state for search
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
              'No locations found. Try a different search term.',
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontFamily.geist,
                color: ColorManager.textSecondary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSelectedLocation(LocationEntity location) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.primary10,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.primary),
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: ColorManager.primary,
            size: 20.w,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontFamily.geist,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.primary,
                  ),
                ),
                Text(
                  location.fullName,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: FontFamily.geist,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
          ),
          // Remove button removed - user should search again to change location
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
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
              text: 'Complete Registration',
              isEnabled: _clinicNameController.text.trim().isNotEmpty &&
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
