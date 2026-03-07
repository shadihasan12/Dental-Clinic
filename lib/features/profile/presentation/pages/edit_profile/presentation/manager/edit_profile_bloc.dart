import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/use_case/use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/domain/entities/user_profile_entity.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/domain/use_cases/get_user_profile_use_case.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/edit_profile/domain/use_cases/update_user_profile_use_case.dart';
import 'package:dental_clinic_app/services/media/media_service.dart';
import 'package:injectable/injectable.dart';

part 'edit_profile_bloc.freezed.dart';
part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final GetUserProfileUseCase _getUserProfile;
  final UpdateUserProfileUseCase _updateUserProfile;
  final MediaService _mediaService;

  EditProfileBloc({
    required GetUserProfileUseCase getUserProfile,
    required UpdateUserProfileUseCase updateUserProfile,
    required MediaService mediaService,
  })  : _getUserProfile = getUserProfile,
        _updateUserProfile = updateUserProfile,
        _mediaService = mediaService,
        super(const EditProfileState.initial()) {
    on<_LoadProfile>(_onLoad);
    on<_UpdateProfile>(_onUpdate);
    on<_UploadImage>(_onUploadImage);
  }

  Future<void> _onLoad(
    _LoadProfile event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(const EditProfileState.loading());

    final result = await _getUserProfile(NoParams());

    result.fold(
      (error) => emit(
        EditProfileState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (profile) => emit(EditProfileState.loaded(profile)),
    );
  }

  Future<void> _onUpdate(
    _UpdateProfile event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileState.saving(event.profile));

    final result = await _updateUserProfile(event.profile);

    result.fold(
      (error) => emit(
        EditProfileState.error(NetworkExceptions.getErrorMessage(error)),
      ),
      (profile) => emit(EditProfileState.saved(profile)),
    );
  }

  Future<void> _onUploadImage(
    _UploadImage event,
    Emitter<EditProfileState> emit,
  ) async {
    final currentProfile = state.maybeWhen(
      loaded: (p) => p,
      saved: (p) => p,
      imageUploaded: (p, _, _) => p,
      orElse: () => null,
    );
    if (currentProfile == null) return;

    emit(EditProfileState.imageUploading(currentProfile));

    try {
      final response = await _mediaService.uploadFile(event.imageFile);
      emit(EditProfileState.imageUploaded(
        currentProfile,
        response.id,
        response.url,
      ));
    } catch (e) {
      emit(EditProfileState.error(e.toString()));
    }
  }
}
