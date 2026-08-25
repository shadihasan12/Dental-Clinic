import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/custom_widgets/custom_text_field.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The compose card at the top of Report an Issue.
///
/// Both fields are required. The submit button stays disabled until each
/// holds something, so the common case never reaches a validation error;
/// the validators are the backstop for whitespace-only input.
class NewIssueForm extends StatefulWidget {
  const NewIssueForm({
    super.key,
    required this.isSubmitting,
    required this.errorMessage,
    required this.onSubmit,
  });

  final bool isSubmitting;

  /// A rejected create, shown against the form rather than the list — this
  /// is the part the user has to act on.
  final String? errorMessage;

  final void Function(String title, String description) onSubmit;

  @override
  State<NewIssueForm> createState() => NewIssueFormState();
}

class NewIssueFormState extends State<NewIssueForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Drives the button's enabled state as the user types.
    _titleController.addListener(_onChanged);
    _descriptionController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
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
    FocusScope.of(context).unfocus();
  }

  bool get _canSubmit =>
      _titleController.text.trim().isNotEmpty &&
      _descriptionController.text.trim().isNotEmpty &&
      !widget.isSubmitting;

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    widget.onSubmit(
      _titleController.text.trim(),
      _descriptionController.text.trim(),
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
            _FieldLabel(text: l10n.issueTitleLabel),
            SizedBox(height: 6.h),
            CustomTextField(
              controller: _titleController,
              hintText: l10n.issueTitleHint,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
              enabled: !widget.isSubmitting,
              validator: (value) => (value?.trim().isEmpty ?? true)
                  ? l10n.issueTitleRequired
                  : null,
            ),
            SizedBox(height: 12.h),
            _FieldLabel(text: l10n.description),
            SizedBox(height: 6.h),
            CustomTextField(
              controller: _descriptionController,
              hintText: l10n.issueDescriptionHint,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              enabled: !widget.isSubmitting,
              validator: (value) => (value?.trim().isEmpty ?? true)
                  ? l10n.issueDescriptionRequired
                  : null,
            ),
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
                  disabledBackgroundColor: ColorManager.primary
                      .withValues(alpha: 0.35),
                  disabledForegroundColor: ColorManager.white
                      .withValues(alpha: 0.85),
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
