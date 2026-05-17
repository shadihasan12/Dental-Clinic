import 'dart:io';

import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/resources/border_radius_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/custom_widgets/custom_widgets.dart';
import 'package:dental_clinic_app/custom_widgets/page_header.dart';
import 'package:dental_clinic_app/features/auth/domain/entities/specialty_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/data/data_sources/edit_profile_remote_data_source.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/domain/entities/user_profile_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/presentation/manager/edit_profile_bloc.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/presentation/widgets/profile_dropdown_field.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/presentation/widgets/profile_text_field.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/file_picker/file_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<EditProfileBloc>()..add(const EditProfileEvent.loadProfile()),
      child: const _EditProfileContent(),
    );
  }
}

class _EditProfileContent extends StatefulWidget {
  const _EditProfileContent();

  @override
  State<_EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<_EditProfileContent> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  String? _selectedSpecialtyId;
  String? _selectedSpecialtyName;
  String _profileId = '';
  bool _formPopulated = false;

  // Image state
  String? _uploadedImageId;
  String? _imageUrl;
  File? _pickedImageFile;
  bool _isUploadingImage = false;

  List<SpecialtyEntity>? _specialties;

  // Initial snapshot for dirty-checking
  String _initialFirstName = '';
  String _initialLastName = '';
  String _initialPhone = '';
  String? _initialSpecialtyId;
  String? _initialImageId;
  String? _initialImageUrl;

  bool get _hasChanges {
    if (!_formPopulated) return false;
    return _firstNameController.text.trim() != _initialFirstName ||
        _lastNameController.text.trim() != _initialLastName ||
        _phoneController.text.trim() != _initialPhone ||
        _selectedSpecialtyId != _initialSpecialtyId ||
        _uploadedImageId != _initialImageId ||
        _imageUrl != _initialImageUrl;
  }

  void _onFieldChanged() => setState(() {});

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _firstNameController.addListener(_onFieldChanged);
    _lastNameController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _populateFromEntity(UserProfileEntity profile) {
    _profileId = profile.id;
    _firstNameController.text = profile.firstName;
    _lastNameController.text = profile.lastName;
    _emailController.text = profile.email;
    _phoneController.text = profile.phone;
    _selectedSpecialtyId = profile.specialtyId;
    _selectedSpecialtyName = profile.specialtyName;
    _imageUrl = profile.imageUrl;
    _formPopulated = true;
    _takeSnapshot(profile);
    // Cache profile image from API on first load
    if (profile.imageUrl != null && profile.imageUrl!.isNotEmpty) {
      getIt<UserStorage>().saveProfileImageUrl(profile.imageUrl!);
    }
  }

  void _takeSnapshot(UserProfileEntity profile) {
    _initialFirstName = profile.firstName;
    _initialLastName = profile.lastName;
    _initialPhone = profile.phone;
    _initialSpecialtyId = profile.specialtyId;
    _initialImageId = _uploadedImageId;
    _initialImageUrl = profile.imageUrl;
  }

  UserProfileEntity _buildEntity() {
    return UserProfileEntity(
      id: _profileId,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      specialtyId: _selectedSpecialtyId,
      specialtyName: _selectedSpecialtyName,
      imageId: _uploadedImageId,
      imageUrl: _imageUrl,
    );
  }

  void _onSave() {
    final entity = _buildEntity();
    context.read<EditProfileBloc>().add(EditProfileEvent.updateProfile(entity));
  }

  Future<void> _onPickImage() async {
    final hasPermission = await _requestPhotoPermission();
    if (!hasPermission || !mounted) return;

    final bloc = context.read<EditProfileBloc>();
    final result = await getIt<FilePickerService>().pickImage();
    if (result == null || !mounted) return;

    setState(() {
      _pickedImageFile = result.file;
      _isUploadingImage = true;
    });

    bloc.add(EditProfileEvent.uploadImage(result.file));
  }

  Future<bool> _requestPhotoPermission() async {
    PermissionStatus status;

    // Android 13+ uses photos permission, older uses storage
    if (Platform.isAndroid) {
      status = await Permission.photos.status;
      if (!status.isGranted) {
        status = await Permission.photos.request();
      }
      // Fallback for older Android versions
      if (status.isDenied) {
        status = await Permission.storage.request();
      }
    } else {
      status = await Permission.photos.status;
      if (!status.isGranted) {
        status = await Permission.photos.request();
      }
    }

    if (status.isPermanentlyDenied && mounted) {
      _showPermissionDeniedBottomSheet();
      return false;
    }

    return status.isGranted || status.isLimited;
  }

  void _showPermissionDeniedBottomSheet() {
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: c.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: c.borderLight,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 20.h),
                Icon(
                  Icons.photo_library_outlined,
                  size: 48.w,
                  color: ColorManager.primary,
                ),
                SizedBox(height: 16.h),
                Text(
                  l10n.photoPermissionRequired,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  l10n.photoPermissionMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w400,
                    color: c.textSecondary,
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(sheetContext);
                    openAppSettings();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.h),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadiusManager.lg,
                    ),
                    child: Text(
                      l10n.openSettings,
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
                SizedBox(height: 12.h),
                GestureDetector(
                  onTap: () => Navigator.pop(sheetContext),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.h),
                    decoration: BoxDecoration(
                      color: c.scaffoldBg,
                      borderRadius: BorderRadiusManager.lg,
                    ),
                    child: Text(
                      l10n.cancel,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: FontHelper.fontFamily(context),
                        fontWeight: FontWeight.w600,
                        color: c.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showSpecializationPicker() async {
    final l10n = AppLocalizations.of(context)!;

    // Load specialties if not cached
    if (_specialties == null) {
      try {
        final dataSource = getIt<EditProfileRemoteDataSource>();
        final specs = await dataSource.getSpecialties();
        _specialties = specs;
      } catch (_) {
        if (mounted) {
          AppSnackbar.showError(
            context,
            title: l10n.error,
            message: l10n.somethingWentWrong,
          );
        }
        return;
      }
    }

    if (!mounted) return;

    final c = ColorManager.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: c.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 12.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: c.borderLight,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
                child: Text(
                  l10n.specialization,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: FontHelper.fontFamily(context),
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
                ),
              ),
              ..._specialties!.map((spec) {
                final isSelected = _selectedSpecialtyId == spec.id;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedSpecialtyId = spec.id;
                      _selectedSpecialtyName = spec.name;
                    });
                    Navigator.pop(sheetContext);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 14.h,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? ColorManager.primary
                                  : c.borderLight,
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
                          spec.name,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: FontHelper.fontFamily(context),
                            fontWeight: isSelected
                                ? FontWeight.w500
                                : FontWeight.w400,
                            color: isSelected
                                ? ColorManager.primary
                                : c.textPrimary,
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

    return BlocConsumer<EditProfileBloc, EditProfileState>(
      buildWhen: (prev, curr) => curr.maybeMap(
        loading: (_) => true,
        loaded: (_) => true,
        error: (_) => true,
        imageUploading: (_) => true,
        imageUploaded: (_, {profile, imageId, imageUrl}) => true,
        orElse: () => false,
      ),
      listenWhen: (prev, curr) => curr.maybeMap(
        saving: (_) => true,
        saved: (_) => true,
        error: (_) => true,
        imageUploaded: (_, {profile, imageId, imageUrl}) => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.maybeWhen(
          saving: (_) {
            AppLoadingDialog.show(context: context, message: l10n.save);
          },
          saved: (profile) {
            AppLoadingDialog.dismiss(context);
            // Re-snapshot so save button disables again
            setState(() {
              _initialFirstName = _firstNameController.text.trim();
              _initialLastName = _lastNameController.text.trim();
              _initialPhone = _phoneController.text.trim();
              _initialSpecialtyId = _selectedSpecialtyId;
              _initialImageId = _uploadedImageId;
              _initialImageUrl = _imageUrl;
            });
            // Cache updated profile data for home & menu pages
            final userStorage = getIt<UserStorage>();
            final firstName = _firstNameController.text.trim();
            final lastName = _lastNameController.text.trim();
            userStorage.saveFirstName(firstName);
            userStorage.saveLastName(lastName);
            userStorage.saveUserName('$firstName $lastName');
            if (_imageUrl != null && _imageUrl!.isNotEmpty) {
              userStorage.saveProfileImageUrl(_imageUrl!);
            }
            UserStorage.notifyProfileUpdated();
            AppSnackbar.showSuccess(
              context,
              title: l10n.success,
              message: l10n.saveChanges,
            );
          },
          imageUploaded: (profile, imageId, imageUrl) {
            setState(() {
              _uploadedImageId = imageId;
              _imageUrl = imageUrl;
              _isUploadingImage = false;
            });
          },
          error: (message) {
            AppLoadingDialog.dismiss(context);
            setState(() => _isUploadingImage = false);
            AppSnackbar.showError(context, title: l10n.error, message: message);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final c = ColorManager.of(context);
        return Scaffold(
          backgroundColor: c.scaffoldBg,
          bottomNavigationBar: _formPopulated ? _buildSaveButton(l10n) : null,
          body: Column(
            children: [
              PageHeader(title: l10n.editProfile, onBack: () => context.pop()),
              Expanded(
                child: state.maybeWhen(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (message) {
                    if (_formPopulated) return _buildForm(l10n);
                    return Center(child: Text(message));
                  },
                  loaded: (profile) {
                    if (!_formPopulated) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() => _populateFromEntity(profile));
                      });
                      return const Center(child: CircularProgressIndicator());
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
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: GestureDetector(
        onTap: _isUploadingImage ? null : _onPickImage,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: ColorManager.primary.withValues(alpha: 0.1),
              backgroundImage: _pickedImageFile != null
                  ? FileImage(_pickedImageFile!)
                  : (_imageUrl != null && _imageUrl!.isNotEmpty
                        ? NetworkImage(_imageUrl!) as ImageProvider
                        : null),
              child:
                  _pickedImageFile == null &&
                      (_imageUrl == null || _imageUrl!.isEmpty)
                  ? Icon(Icons.person, size: 50.w, color: ColorManager.primary)
                  : null,
            ),
            if (_isUploadingImage)
              Positioned.fill(
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundColor: Colors.black38,
                  child: SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 16.w,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildProfileImage(),
          SizedBox(height: 20.h),
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
                  value: _selectedSpecialtyName,
                  onTap: _showSpecializationPicker,
                ),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRoutesNames.changeEmail,
                      extra: {'currentEmail': _emailController.text.trim()},
                    );
                  },
                  child: ProfileTextField(
                    icon: Icons.edit,
                    label: l10n.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    enabled: false,
                    textDirection: TextDirection.ltr,
                    // suffixWidget: GestureDetector(
                    //   onTap: () {
                    //     context.pushNamed(
                    //       AppRoutesNames.changeEmail,
                    //       extra: {'currentEmail': _emailController.text.trim()},
                    //     );
                    //   },
                    //   child: Padding(
                    //     padding: EdgeInsetsDirectional.only(end: 12.w),
                    //     child: Text(
                    //       l10n.edit,
                    //       style: TextStyle(
                    //         fontSize: 13.sp,
                    //         fontFamily: FontHelper.fontFamily(context),
                    //         fontWeight: FontWeight.w600,
                    //         color: ColorManager.primary,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
                ProfileTextField(
                  icon: Icons.phone_outlined,
                  label: l10n.phone,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  isLast: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildSaveButton(AppLocalizations l10n) {
    final enabled = _hasChanges;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: GestureDetector(
          onTap: enabled ? _onSave : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: EdgeInsets.all(14.h),
            decoration: BoxDecoration(
              color: enabled
                  ? ColorManager.primary
                  : ColorManager.primary.withValues(alpha: 0.35),
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
      ),
    );
  }
}
