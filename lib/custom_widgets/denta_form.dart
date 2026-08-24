import 'dart:math' as math;

import 'package:dental_clinic_app/core/utils/system_insets.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/generated_localizations/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' hide TextDirection;

/// The shared pieces every create/edit screen is built from, so Add Patient
/// and Add Appointment cannot drift apart: one card shape, one input shell,
/// one error line, one docked action, one date sheet.

/// Back + title. The identity row on a form screen.
class FormTopBar extends StatelessWidget {
  const FormTopBar({super.key, required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      color: c.surfaceBg,
      padding: EdgeInsetsDirectional.fromSTEB(4.w, 4.h, 14.w, 6.h),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 18.w,
              color: c.textPrimary,
            ),
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontHelper.fontFamily(context),
                color: c.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// One white card with a heading and a stack of fields.
class FormSectionCard extends StatelessWidget {
  const FormSectionCard({
    super.key,
    required this.title,
    required this.children,
    this.trailing,
  });

  final String title;
  final List<Widget> children;

  /// Optional control on the heading row - a "change" link, a count, a switch.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontHelper.fontFamily(context),
                    color: c.textPrimary,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          for (final child in children) ...[SizedBox(height: 12.h), child],
        ],
      ),
    );
  }
}

/// The red icon + message that sits under an invalid control.
class FormErrorLine extends StatelessWidget {
  const FormErrorLine({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 13.w,
            color: ColorManager.error,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 11.sp,
                height: 1.3,
                fontFamily: FontHelper.fontFamily(context),
                color: ColorManager.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Label, control, then the error line. Every field uses it so the three sit
/// at the same rhythm whatever the control is.
class FormFieldShell extends StatelessWidget {
  const FormFieldShell({
    super.key,
    required this.label,
    required this.child,
    this.required = false,
    this.errorText,
  });

  final String label;
  final Widget child;
  final bool required;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label.isNotEmpty) ...[
          Text.rich(
            TextSpan(
              text: label,
              children: [
                if (required)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: ColorManager.error),
                  ),
              ],
            ),
            style: TextStyle(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w500,
              fontFamily: FontHelper.fontFamily(context),
              color: c.textSecondary,
            ),
          ),
          SizedBox(height: 6.h),
        ],
        child,
        if (errorText != null) FormErrorLine(message: errorText!),
      ],
    );
  }
}

/// The input surface: 1px hairline at rest, 1.5px in its own hue when focused
/// or in error - the border rule from the design language, applied to inputs.
BoxDecoration formInputDecoration(
  BuildContext context, {
  required bool focused,
  required bool hasError,
}) {
  final c = ColorManager.of(context);
  final Color border;
  final double width;
  if (hasError) {
    border = ColorManager.error;
    width = 1.5;
  } else if (focused) {
    border = ColorManager.primary;
    width = 1.5;
  } else {
    border = c.borderLight;
    width = 1;
  }
  return BoxDecoration(
    color: c.inputBg,
    borderRadius: BorderRadius.circular(12.r),
    border: Border.all(color: border, width: width),
  );
}

/// The kit look for a [TextField] that has to carry its own borders - a field
/// in a dialog, or one sharing a row with a send button, where wrapping it in
/// a decorated container would fight the layout.
///
/// Same 12r radius, hairline, 1.5px focus hue, fill and metrics as
/// [formInputDecoration], so both routes to a field look identical.
InputDecoration formOutlinedInput(
  BuildContext context, {
  String? hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  Color? focusTone,
  Color? fillColor,
}) {
  final c = ColorManager.of(context);
  final family = FontHelper.fontFamily(context);

  OutlineInputBorder side(Color color, double width) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide(color: color, width: width),
  );

  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      fontSize: 13.sp,
      fontFamily: family,
      color: c.textTertiary,
    ),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    isDense: true,
    filled: true,
    fillColor: fillColor ?? c.inputBg,
    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
    border: side(c.borderLight, 1),
    enabledBorder: side(c.borderLight, 1),
    disabledBorder: side(c.borderLight, 1),
    focusedBorder: side(focusTone ?? ColorManager.primary, 1.5),
    errorBorder: side(ColorManager.error, 1.5),
    focusedErrorBorder: side(ColorManager.error, 1.5),
    errorStyle: TextStyle(
      fontSize: 11.sp,
      height: 1.3,
      fontFamily: family,
      color: ColorManager.error,
    ),
  );
}

/// The starting point for a [TextField] that sits inside a surface painted by
/// [formInputDecoration].
///
/// The app's [InputDecorationTheme] injects a 2px primary `focusedBorder` and
/// a fill into every bare field, and clearing `border` alone does not stop it:
/// each state falls back to the *theme*, not to `border`. Without this the
/// focused field draws a second blue outline inside the one its container
/// already draws. Call `.copyWith(...)` for hint, icons and padding.
InputDecoration bareInputDecoration() => const InputDecoration(
  isDense: true,
  filled: false,
  border: InputBorder.none,
  enabledBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  focusedErrorBorder: InputBorder.none,
);

class FormTextField extends StatefulWidget {
  const FormTextField({
    super.key,
    required this.label,
    required this.controller,
    this.required = false,
    this.hintText,
    this.keyboardType,
    this.maxLines = 1,
    this.errorText,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.obscureText = false,
    this.suffix,
    this.textInputAction,
    this.onSubmitted,
    this.textDirection,
  });

  final String label;
  final TextEditingController controller;
  final bool required;
  final String? hintText;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? errorText;
  final TextCapitalization textCapitalization;
  final VoidCallback? onChanged;

  /// Passwords. Forces a single line, whatever [maxLines] says.
  final bool obscureText;

  /// A control on the trailing side of the surface - a reveal toggle, a unit.
  final Widget? suffix;

  final TextInputAction? textInputAction;
  final VoidCallback? onSubmitted;

  /// Pin to ltr for values that are never Arabic text, such as an address.
  final TextDirection? textDirection;

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);

    return FormFieldShell(
      label: widget.label,
      required: widget.required,
      errorText: widget.errorText,
      child: Container(
        decoration: formInputDecoration(
          context,
          focused: _focusNode.hasFocus,
          hasError: widget.errorText != null,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                keyboardType: widget.keyboardType,
                maxLines: widget.obscureText ? 1 : widget.maxLines,
                obscureText: widget.obscureText,
                textCapitalization: widget.textCapitalization,
                textInputAction: widget.textInputAction,
                textDirection: widget.textDirection,
                onChanged: (_) => widget.onChanged?.call(),
                onSubmitted: (_) => widget.onSubmitted?.call(),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: family,
                  color: c.textPrimary,
                ),
                decoration: bareInputDecoration().copyWith(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: family,
                    color: c.textTertiary,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
            if (widget.suffix != null)
              Padding(
                padding: EdgeInsetsDirectional.only(end: 10.w),
                child: widget.suffix!,
              ),
          ],
        ),
      ),
    );
  }
}

/// A read-only field that opens [DatePickerSheet].
class FormDateField extends StatelessWidget {
  const FormDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
    this.placeholder,
    this.required = false,
    this.errorText,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  final String? placeholder;
  final bool required;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final locale = Localizations.localeOf(context).toString();
    final date = value;

    return FormFieldShell(
      label: label,
      required: required,
      errorText: errorText,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: formInputDecoration(
            context,
            focused: false,
            hasError: errorText != null,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  date == null
                      ? (placeholder ?? label)
                      : DateFormat('d MMM yyyy', locale).format(date),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: family,
                    color: date == null ? c.textTertiary : c.textPrimary,
                  ),
                ),
              ),
              Icon(
                Icons.calendar_today_outlined,
                size: 16.w,
                color: c.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A read-only field that opens a chooser, or that simply cannot be edited
/// here. Same shell and surface as [FormTextField], so a form mixing typed
/// and picked values still reads as one column of controls.
class FormPickerField extends StatelessWidget {
  const FormPickerField({
    super.key,
    required this.label,
    required this.value,
    this.onTap,
    this.placeholder,
    this.required = false,
    this.errorText,
    this.trailingIcon,
    this.action,
    this.textDirection,
  });

  final String label;
  final String? value;
  final VoidCallback? onTap;
  final String? placeholder;
  final bool required;
  final String? errorText;

  /// Defaults to a chevron when tappable, nothing when not.
  final IconData? trailingIcon;

  /// A labelled control on the trailing side - "Change" on a locked field.
  final Widget? action;

  /// Pin to ltr for values that are never Arabic text, such as an address.
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final shown = value != null && value!.isNotEmpty;
    // A field with no tap and no action is locked: dim its surface so it does
    // not invite an edit that will not happen.
    final locked = onTap == null && action == null;

    return FormFieldShell(
      label: label,
      required: required,
      errorText: errorText,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsetsDirectional.fromSTEB(12.w, 12.h, 8.w, 12.h),
          decoration: formInputDecoration(
            context,
            focused: false,
            hasError: errorText != null,
          ).copyWith(color: locked ? c.cardBgSecondary : null),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  shown ? value! : (placeholder ?? ''),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: textDirection,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: family,
                    color: shown
                        ? (locked ? c.textSecondary : c.textPrimary)
                        : c.textTertiary,
                  ),
                ),
              ),
              if (action != null)
                action!
              else if (onTap != null)
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Icon(
                    trailingIcon ?? Icons.keyboard_arrow_down_rounded,
                    size: 18.w,
                    color: c.textTertiary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A text link sized for the trailing slot of a [FormPickerField].
class FormInlineAction extends StatelessWidget {
  const FormInlineAction({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            fontFamily: FontHelper.fontFamily(context),
            color: ColorManager.primaryDarker,
          ),
        ),
      ),
    );
  }
}

/// A dropdown wearing the form-kit input shell.
class FormDropdownField<T> extends StatelessWidget {
  const FormDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.hint,
    this.required = false,
    this.errorText,
  });

  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;
  final String? hint;
  final bool required;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final textStyle = TextStyle(
      fontSize: 13.sp,
      fontFamily: family,
      color: c.textPrimary,
    );

    return FormFieldShell(
      label: label,
      required: required,
      errorText: errorText,
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(12.w, 0, 8.w, 0),
        decoration: formInputDecoration(
          context,
          focused: false,
          hasError: errorText != null,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            isDense: true,
            padding: EdgeInsets.symmetric(vertical: 11.h),
            borderRadius: BorderRadius.circular(12.r),
            dropdownColor: c.cardBg,
            style: textStyle,
            hint: hint == null
                ? null
                : Text(hint!, style: textStyle.copyWith(color: c.textTertiary)),
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18.w,
              color: c.textTertiary,
            ),
            items: [
              for (final item in items)
                DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    itemLabel(item),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
                  ),
                ),
            ],
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

/// The standard bottom-sheet frame: 22r top corners, grab handle, a title row
/// with a close on the trailing side, a scrollable body that lifts above the
/// keyboard, and an optional pinned footer for the primary action.
class FormSheetShell extends StatelessWidget {
  const FormSheetShell({
    super.key,
    required this.title,
    required this.children,
    this.footer,
    this.onClose,
  });

  final String title;
  final List<Widget> children;
  final Widget? footer;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      child: Padding(
        // The sheet is anchored to the bottom of the screen, so whatever
        // sits down there has to be reserved here or the footer is drawn
        // underneath it. max() rather than a sum: with the keyboard up it
        // already covers the navigation bar, so adding both would leave a
        // navigation bar's worth of dead space above the keyboard.
        padding: EdgeInsets.only(
          bottom: math.max(keyboard, systemBottomInset(context)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: c.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.w, 12.h, 8.w, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontHelper.fontFamily(context),
                        color: c.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onClose ?? () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close_rounded,
                      size: 20.w,
                      color: c.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 6.h, 20.w, 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                ),
              ),
            ),
            if (footer != null)
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
                child: footer!,
              ),
          ],
        ),
      ),
    );
  }
}

/// The primary action as it appears inside a sheet footer.
class FormSheetButton extends StatelessWidget {
  const FormSheetButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: busy ? null : onPressed,
      // Sized by its own padding rather than a fixed box, so a tall Cairo
      // line box grows the button instead of being clipped.
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
        disabledBackgroundColor: ColorManager.primary.withValues(alpha: 0.45),
        disabledForegroundColor: ColorManager.white,
        elevation: 0,
        minimumSize: Size(double.infinity, 46.h),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: busy
          ? SizedBox(
              width: 18.w,
              height: 18.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: ColorManager.white,
              ),
            )
          : Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.4,
                fontWeight: FontWeight.w600,
                fontFamily: FontHelper.fontFamily(context),
              ),
            ),
    );
  }
}

/// A selectable chip in the form kit's metrics - the same fill, weight and
/// type size as the segmented pickers, so a card mixing chips and inputs still
/// reads as one column of controls.
class FormChip extends StatelessWidget {
  const FormChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.radius = 20,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  /// 20 for a pill, ~10 for a dense grid of values such as time slots.
  final double radius;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? ColorManager.primary : c.cardBgSecondary,
          borderRadius: BorderRadius.circular(radius.r),
          border: Border.all(
            color: selected ? ColorManager.primary : c.borderLight,
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            fontFamily: FontHelper.fontFamily(context),
            color: selected ? ColorManager.white : c.textSecondary,
          ),
        ),
      ),
    );
  }
}

/// The single primary action, docked in the thumb arc with a hairline above
/// it. It reserves its own space rather than floating, so a long form can be
/// scrolled to its last field without the button covering it.
class FormActionBar extends StatelessWidget {
  const FormActionBar({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
  });

  final String label;

  /// Null disables the button; the bar keeps its space either way.
  final VoidCallback? onPressed;

  /// Swaps the label for a spinner and blocks the tap.
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);

    return Container(
      decoration: BoxDecoration(
        color: c.surfaceBg,
        border: Border(top: BorderSide(color: c.borderLight)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: scaffoldBottomInset(context),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 10.h),
          child: ElevatedButton(
            onPressed: busy ? null : onPressed,
            // Sized by its own padding rather than a fixed box, so a tall
            // Cairo line box grows the button instead of being clipped.
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: ColorManager.white,
              disabledBackgroundColor: ColorManager.primary.withValues(
                alpha: 0.45,
              ),
              disabledForegroundColor: ColorManager.white,
              elevation: 0,
              minimumSize: Size(double.infinity, 46.h),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: busy
                ? SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(ColorManager.white),
                    ),
                  )
                : Text(
                    label,
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontHelper.fontFamily(context),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

/// A date picker as a bottom sheet, so the form stays visible behind it.
///
/// Returns the picked date, or `null` if the sheet was dismissed.
class DatePickerSheet {
  DatePickerSheet._();

  static Future<DateTime?> show(
    BuildContext context, {
    required String title,
    DateTime? initial,
    DateTime? minimum,
    DateTime? maximum,
  }) {
    FocusScope.of(context).unfocus();
    final l10n = AppLocalizations.of(context)!;
    final c = ColorManager.of(context);
    final family = FontHelper.fontFamily(context);
    final start = initial ?? DateTime(1990);
    var temp = start;

    return showModalBottomSheet<DateTime>(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        decoration: BoxDecoration(
          color: c.cardBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: systemBottomInset(context),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: c.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.w, 12.h, 8.w, 4.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: family,
                          color: c.textPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      icon: Icon(
                        Icons.close_rounded,
                        size: 20.w,
                        color: c.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 220.h,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: start,
                  minimumDate: minimum ?? DateTime(1900),
                  maximumDate: maximum ?? DateTime.now(),
                  onDateTimeChanged: (date) => temp = date,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(sheetContext, temp),
                  // Sized by its own padding rather than a fixed box: a tall
                  // Cairo line box in a short box clipped the glyphs.
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    foregroundColor: ColorManager.white,
                    elevation: 0,
                    minimumSize: Size(double.infinity, 44.h),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    l10n.save,
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                      fontFamily: family,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
