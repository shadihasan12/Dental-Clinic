import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:flutter/material.dart';

/// Presents [sheet] the way the current form factor expects.
///
/// Mobile keeps the modal bottom sheet. Desktop shows the same widget in a
/// centred, size-capped [Dialog] — a sheet pinned to the bottom edge of a
/// 1080p window is a mobile port, and the content ends up a thin strip
/// across the full width.
///
/// The sheet widget itself does not change between the two, so callers stay
/// a single code path.
Future<T?> showAdaptiveSheet<T>({
  required BuildContext context,
  required Widget sheet,
  double maxWidth = 560,
  double maxHeight = 720,
  bool isScrollControlled = true,
  bool useSafeArea = true,
  Color? backgroundColor,
}) {
  if (Responsive.isDesktop(context)) {
    return showDialog<T>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      builder: (_) => Dialog(
        backgroundColor: backgroundColor ?? ColorManager.of(context).cardBg,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
          child: sheet,
        ),
      ),
    );
  }

  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    useSafeArea: useSafeArea,
    backgroundColor: backgroundColor ?? Colors.transparent,
    builder: (_) => sheet,
  );
}
