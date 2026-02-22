import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/presentation/widgets/profile_dropdown_field.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/presentation/widgets/profile_text_field.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _locationController;

  String? _selectedSpecialization;

  final List<String> _specializations = [
    'General Dentistry',
    'Endodontics',
    'Orthodontics',
    'Cosmetic Dentistry',
    'Oral Surgery',
  ];

  String _getLocalizedSpecialization(BuildContext context, String spec) {
    final l10n = AppLocalizations.of(context)!;
    switch (spec) {
      case 'General Dentistry':
        return l10n.generalDentistry;
      case 'Endodontics':
        return l10n.endodontics;
      case 'Orthodontics':
        return l10n.orthodontics;
      case 'Cosmetic Dentistry':
        return l10n.cosmeticDentistry;
      case 'Oral Surgery':
        return l10n.oralSurgery;
      default:
        return spec;
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO: Replace with actual user data
    _firstNameController = TextEditingController(text: 'Ahmed');
    _lastNameController = TextEditingController(text: 'Hassan');
    _emailController = TextEditingController(text: 'dr.ahmed@clinic.com');
    _phoneController = TextEditingController(text: '+963 988 026 431');
    _locationController = TextEditingController(text: 'Damascus, Syria');
    _selectedSpecialization = 'Endodontics';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _onSave() {
    // TODO: Implement save logic
  }

  void _showSpecializationPicker() {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 12.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: ColorManager.borderLight,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),

              // Title
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
                child: Text(
                  l10n.specialization,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ),

              // Options
              ..._specializations.map((spec) {
                final isSelected = _selectedSpecialization == spec;
                final localizedSpec = _getLocalizedSpecialization(
                  context,
                  spec,
                );
                return InkWell(
                  onTap: () {
                    setState(() => _selectedSpecialization = spec);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 14.h,
                    ),
                    child: Row(
                      children: [
                        // Radio indicator
                        Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? ColorManager.primary
                                  : ColorManager.borderLight,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: 10.w,
                                    height: 10.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorManager.primary,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          localizedSpec,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: isSelected
                                ? FontWeight.w500
                                : FontWeight.w400,
                            color: isSelected
                                ? ColorManager.primary
                                : ColorManager.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              SizedBox(height: 12.h),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground,
      bottomNavigationBar: saveButton(l10n, context),
      body: Column(
        children: [
          PageHeader(title: l10n.editProfile, onBack: () => context.pop()),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // Form card
                  CustomCard(
                    child: Column(
                      children: [
                        ProfileTextField(
                          icon: Icons.person_outline,
                          label: l10n.firstName,
                          controller: _firstNameController,
                          textInputAction: TextInputAction.next,
                        ),
                        ProfileTextField(
                          icon: Icons.person_outline,
                          label: l10n.lastName,
                          controller: _lastNameController,
                          textInputAction: TextInputAction.next,
                        ),
                        ProfileDropdownField(
                          icon: Icons.medical_services_outlined,
                          label: l10n.specialization,
                          value: _selectedSpecialization,
                          onTap: _showSpecializationPicker,
                        ),
                        ProfileTextField(
                          icon: Icons.email_outlined,
                          label: l10n.email,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        ProfileTextField(
                          icon: Icons.phone_outlined,
                          label: l10n.phone,
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                        ),
                        ProfileTextField(
                          icon: Icons.location_on_outlined,
                          label: l10n.location,
                          controller: _locationController,
                          textInputAction: TextInputAction.done,
                          isLast: true,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget saveButton(AppLocalizations l10n, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: GestureDetector(
        onTap: _onSave,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.h),
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadiusManager.lg,
          ),
          child: Text(
            l10n.saveChanges,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: FontHelper.fontFamily(context),
              fontWeight: FontWeight.w600,
              color: ColorManager.white,
            ),
          ),
        ),
      ),
    );
  }
}
