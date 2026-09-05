import 'dart:async';

import 'package:dental_clinic_app/core/errors/network_exceptions.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/storage/user_storage.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/custom_widgets/custom_text_field.dart';
import 'package:dental_clinic_app/custom_widgets/denta_form.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/issues/domain/entities/issue_entity.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:dental_clinic_app/services/file_picker/file_picker_service.dart';
import 'package:dental_clinic_app/services/file_picker/picked_file_model.dart';
import 'package:dental_clinic_app/services/media/media_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The compose card at the top of Report an Issue.
///
/// Category, title and description are all required by the API, so the
/// submit button stays disabled until each is answered and the common case
/// never reaches a validation error. Screenshots are optional and are
/// uploaded as they are picked, so submitting only has to send their ids.
class NewIssueForm extends StatefulWidget {
  const NewIssueForm({
    super.key,
    required this.isSubmitting,
    required this.errorMessage,
    required this.categories,
    required this.isLoadingCategories,
    required this.categoriesError,
    required this.onRetryCategories,
    required this.onSubmit,
  });

  final bool isSubmitting;

  /// A rejected create, shown against the form rather than the list — this
  /// is the part the user has to act on.
  final String? errorMessage;

  /// From `GET /tickets/categories`: wire values with translated labels.
  final List<IssueOptionEntity> categories;
  final bool isLoadingCategories;

  /// Set when that call failed. There is no valid category to send without
  /// it, so the field turns into a retry rather than a dropdown.
  final String? categoriesError;
  final VoidCallback onRetryCategories;

  final void Function(
    String category,
    String title,
    String description,
    List<String> mediaItemIds,
  )
  onSubmit;

  @override
  State<NewIssueForm> createState() => NewIssueFormState();
}

class NewIssueFormState extends State<NewIssueForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _category;
  final List<_Screenshot> _screenshots = [];

  /// Why the last pick or upload did not stick — too large, wrong type, or a
  /// role that may not upload at all. Sits under the attach row.
  String? _attachmentNotice;

  /// API caps, enforced here so the user finds out while typing rather than
  /// from a rejected submission.
  static const int _titleMaxLength = 255;
  static const int _descriptionMaxLength = 5000;

  @override
  void initState() {
    super.initState();
    // Drives the button's enabled state as the user types.
    _titleController.addListener(_onChanged);
    _descriptionController.addListener(_onChanged);
    UserStorage.clinicChangedNotifier.addListener(_onClinicChanged);
  }

  void _onChanged() => setState(() {});

  /// An uploaded file belongs to the clinic that was selected at the time,
  /// and the create call refuses ids from another one. Switching clinic
  /// mid-form therefore throws the pending screenshots away rather than
  /// letting the user submit into a guaranteed rejection.
  void _onClinicChanged() {
    if (!mounted || _screenshots.isEmpty) return;
    setState(() {
      _screenshots.clear();
      _attachmentNotice = null;
    });
  }

  @override
  void dispose() {
    UserStorage.clinicChangedNotifier.removeListener(_onClinicChanged);
    _titleController
      ..removeListener(_onChanged)
      ..dispose();
    _descriptionController
      ..removeListener(_onChanged)
      ..dispose();
    super.dispose();
  }

  /// Called by the page once the bloc confirms the report was filed.
  void reset() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _category = null;
      _screenshots.clear();
      _attachmentNotice = null;
    });
    FocusScope.of(context).unfocus();
  }

  bool get _isUploading => _screenshots.any((s) => s.isUploading);

  bool get _canSubmit =>
      _category != null &&
      _titleController.text.trim().isNotEmpty &&
      _descriptionController.text.trim().isNotEmpty &&
      !_isUploading &&
      !widget.isSubmitting;

  Future<void> _pickScreenshots() async {
    final l10n = AppLocalizations.of(context)!;
    final pick = await getIt<FilePickerService>().pickScreenshots();
    if (!mounted) return;

    if (pick.outcome == DocumentPickOutcome.unsupportedType) {
      setState(() => _attachmentNotice = l10n.screenshotsOnly);
      return;
    }
    if (pick.outcome != DocumentPickOutcome.picked) return;

    // A file manager can hand back something huge; the server refuses it
    // after the whole upload has gone over the wire, so it is checked here.
    final tooLarge = <String>[];
    final accepted = <PickedFileResult>[];
    for (final file in pick.files) {
      if (file.file.lengthSync() > FilePickerService.maxUploadBytes) {
        tooLarge.add(file.name);
      } else {
        accepted.add(file);
      }
    }

    setState(() {
      _attachmentNotice = tooLarge.isEmpty
          ? (pick.rejectedName == null ? null : l10n.screenshotsOnly)
          : l10n.fileTooLarge;
      _screenshots.addAll(accepted.map(_Screenshot.new));
    });

    // Uploaded as they are picked, so submitting only has to send the ids.
    // An abandoned form leaves the files orphaned server-side, which is
    // harmless — they are simply never referenced by a report.
    for (final file in accepted) {
      unawaited(_upload(file));
    }
  }

  /// Uploads one screenshot and stores the id the create call will send.
  ///
  /// A role without `manage-media-files` gets a 403 here. That is not a
  /// broken upload — it means this user may not attach anything — so the
  /// file is dropped, the reason is shown, and the report can still be sent
  /// without it.
  Future<void> _upload(PickedFileResult file) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final result = await getIt<MediaService>().uploadFile(file.file);
      if (!mounted) return;
      setState(() {
        final entry = _entryFor(file);
        entry?.mediaItemId = result.id;
        entry?.isUploading = false;
      });
    } catch (error) {
      if (!mounted) return;
      final isForbidden = error is Forbidden;
      setState(() {
        _screenshots.removeWhere((s) => identical(s.file, file));
        _attachmentNotice = isForbidden
            ? l10n.attachmentsNotAllowed
            : l10n.uploadFailed;
      });
    }
  }

  _Screenshot? _entryFor(PickedFileResult file) {
    for (final entry in _screenshots) {
      if (identical(entry.file, file)) return entry;
    }
    return null;
  }

  void _removeScreenshot(_Screenshot entry) {
    setState(() {
      _screenshots.remove(entry);
      _attachmentNotice = null;
    });
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_category == null) return;
    FocusScope.of(context).unfocus();
    widget.onSubmit(
      _category!,
      _titleController.text.trim(),
      _descriptionController.text.trim(),
      [
        for (final entry in _screenshots)
          if (entry.mediaItemId != null) entry.mediaItemId!,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final l10n = AppLocalizations.of(context)!;
    final fontFamily = FontHelper.fontFamily(context);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.newReport,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontFamily: fontFamily,
                color: c.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            _FieldLabel(text: l10n.issueCategoryLabel),
            SizedBox(height: 6.h),
            _buildCategoryField(l10n),
            SizedBox(height: 12.h),
            _FieldLabel(text: l10n.issueTitleLabel),
            SizedBox(height: 6.h),
            CustomTextField(
              controller: _titleController,
              hintText: l10n.issueTitleHint,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
              enabled: !widget.isSubmitting,
              maxLength: _titleMaxLength,
              validator: (value) => (value?.trim().isEmpty ?? true)
                  ? l10n.issueTitleRequired
                  : null,
            ),
            SizedBox(height: 4.h),
            _FieldLabel(text: l10n.description),
            SizedBox(height: 6.h),
            CustomTextField(
              controller: _descriptionController,
              hintText: l10n.issueDescriptionHint,
              maxLines: 4,
              maxLength: _descriptionMaxLength,
              textCapitalization: TextCapitalization.sentences,
              enabled: !widget.isSubmitting,
              validator: (value) => (value?.trim().isEmpty ?? true)
                  ? l10n.issueDescriptionRequired
                  : null,
            ),
            SizedBox(height: 4.h),
            _buildScreenshots(l10n),
            if (widget.errorMessage != null) ...[
              SizedBox(height: 12.h),
              _SubmitError(message: widget.errorMessage!),
            ],
            SizedBox(height: 14.h),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _canSubmit ? _submit : null,
                // The button sizes itself from minimumSize + padding rather
                // than being pinned by an outer SizedBox, so a large system
                // font scale grows it instead of clipping the label away.
                style: FilledButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  foregroundColor: ColorManager.white,
                  disabledBackgroundColor: ColorManager.primary.withValues(
                    alpha: 0.35,
                  ),
                  disabledForegroundColor: ColorManager.white.withValues(
                    alpha: 0.85,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  minimumSize: Size(double.infinity, 44.h),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: widget.isSubmitting
                    ? SizedBox(
                        width: 18.w,
                        height: 18.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ColorManager.white,
                        ),
                      )
                    : Text(
                        l10n.sendReport,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: fontFamily,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryField(AppLocalizations l10n) {
    final c = ColorManager.of(context);

    if (widget.isLoadingCategories && widget.categories.isEmpty) {
      return ShimmerBox(
        width: double.infinity,
        height: 46.h,
        radius: BorderRadius.circular(12.r),
      );
    }

    // Nothing valid can be submitted without this list, so a failure offers
    // the retry here rather than letting the user fill the form and be
    // refused on send.
    if (widget.categories.isEmpty) {
      return _InlineNotice(
        message: widget.categoriesError ?? l10n.couldNotLoadCategories,
        actionLabel: l10n.retry,
        onAction: widget.onRetryCategories,
      );
    }

    return DropdownButtonFormField<String>(
      initialValue: _category,
      isExpanded: true,
      decoration: formOutlinedInput(context, hintText: l10n.issueCategoryHint),
      icon: Icon(Icons.expand_more_rounded, size: 20.w, color: c.textTertiary),
      style: TextStyle(
        fontSize: 13.sp,
        fontFamily: FontHelper.fontFamily(context),
        color: c.textPrimary,
      ),
      dropdownColor: c.cardBg,
      borderRadius: BorderRadius.circular(12.r),
      items: [
        for (final option in widget.categories)
          DropdownMenuItem(
            value: option.value,
            child: Text(
              option.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textPrimary,
              ),
            ),
          ),
      ],
      onChanged: widget.isSubmitting
          ? null
          : (value) => setState(() => _category = value),
      validator: (value) =>
          value == null ? l10n.issueCategoryRequired : null,
    );
  }

  Widget _buildScreenshots(AppLocalizations l10n) {
    final c = ColorManager.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_screenshots.isNotEmpty) ...[
          SizedBox(height: 4.h),
          SizedBox(
            height: 64.w,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _screenshots.length,
              separatorBuilder: (_, _) => SizedBox(width: 8.w),
              itemBuilder: (_, i) => _ScreenshotThumb(
                entry: _screenshots[i],
                onRemove: () => _removeScreenshot(_screenshots[i]),
              ),
            ),
          ),
          SizedBox(height: 8.h),
        ],

        // "Add a screenshot", not "attach a file": an attachment on a report
        // is a picture of the problem, and the wording is half of what keeps
        // PDFs and logs out of a picker the server would refuse anyway.
        GestureDetector(
          onTap: widget.isSubmitting ? null : _pickScreenshots,
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: c.borderLight),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 16.w,
                  color: c.textTertiary,
                ),
                SizedBox(width: 6.w),
                Text(
                  l10n.addScreenshot,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontHelper.fontFamily(context),
                    color: c.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_attachmentNotice != null) ...[
          SizedBox(height: 6.h),
          Text(
            _attachmentNotice!,
            style: TextStyle(
              fontSize: 10.5.sp,
              height: 1.35,
              fontFamily: FontHelper.fontFamily(context),
              color: ColorManager.warning,
            ),
          ),
        ],
      ],
    );
  }
}

/// One picked screenshot on its way to `POST /media-items`.
class _Screenshot {
  _Screenshot(this.file);

  final PickedFileResult file;

  /// Set once the upload lands; this is what the create call sends.
  String? mediaItemId;
  bool isUploading = true;
}

class _ScreenshotThumb extends StatelessWidget {
  const _ScreenshotThumb({required this.entry, required this.onRemove});

  final _Screenshot entry;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            width: 64.w,
            height: 64.w,
            color: c.cardBgSecondary,
            child: Image.file(entry.file.file, fit: BoxFit.cover),
          ),
        ),
        if (entry.isUploading)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ColorManager.black.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ),
          )
        else
          PositionedDirectional(
            top: 2,
            end: 2,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, size: 12.w, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 9.5.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
        fontFamily: FontHelper.fontFamily(context),
        color: c.textTertiary,
      ),
    );
  }
}

/// A failed side-call the user can retry without losing what they typed.
class _InlineNotice extends StatelessWidget {
  const _InlineNotice({
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 11.5.sp,
                height: 1.35,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textSecondary,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel,
              style: TextStyle(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.primaryDarker,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmitError extends StatelessWidget {
  const _SubmitError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.error.withValues(alpha: isDark ? 0.18 : 0.10),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 16.w,
            color: ColorManager.error,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 11.5.sp,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.error,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
