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
          child: SheetDialogScope(child: sheet),
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

/// [showModalBottomSheet] on a phone, a centred dialog on desktop.
///
/// Takes the same arguments as [showModalBottomSheet] and, off desktop,
/// hands every one of them straight through - so swapping a call over
/// changes nothing on mobile.
///
/// On desktop the sheet's own widget goes into a [Dialog] unchanged: its
/// background, its padding and its contents are all its own. The dialog only
/// rounds the bottom corners the sheet left square, caps the width at
/// [dialogMaxWidth], and marks the subtree with [SheetDialogScope] so the
/// grab handle - meaningless without a bottom edge to drag from - can step
/// aside (see [HideInDialog]).
Future<T?> showAppSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  BoxConstraints? constraints,
  Color? barrierColor,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  bool? showDragHandle,
  bool useSafeArea = false,
  RouteSettings? routeSettings,
  double dialogMaxWidth = 520,
}) {
  if (!Responsive.isDesktop(context)) {
    return showModalBottomSheet<T>(
      context: context,
      builder: builder,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
    );
  }

  // Most sheets pass transparent and paint their own card; the rest rely on
  // the sheet's colour, which the dialog then has to supply instead.
  final dialogColor = backgroundColor ?? ColorManager.of(context).cardBg;

  return showDialog<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    barrierDismissible: isDismissible,
    barrierColor: barrierColor ?? Colors.black.withValues(alpha: 0.35),
    routeSettings: routeSettings,
    builder: (dialogContext) {
      final screen = MediaQuery.sizeOf(dialogContext);
      return Dialog(
        backgroundColor: dialogColor,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        // 22 is the sheets' own top radius (FormSheetShell and most of the
        // hand-built ones), so the corners the sheet already rounds and the
        // ones the dialog adds come out the same.
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: dialogMaxWidth,
            maxHeight: screen.height * 0.88,
          ),
          child: SheetDialogScope(child: Builder(builder: builder)),
        ),
      );
    },
  );
}

/// Marks a subtree as a sheet being shown as a desktop dialog.
class SheetDialogScope extends InheritedWidget {
  const SheetDialogScope({super.key, required super.child});

  /// True inside a sheet that [showAppSheet] or [showAdaptiveSheet] put in a
  /// dialog.
  static bool isDialog(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SheetDialogScope>() != null;

  @override
  bool updateShouldNotify(SheetDialogScope oldWidget) => false;
}

/// Draws [child] in a bottom sheet and nothing in a dialog - for the grab
/// handle, which only means something when there is an edge to drag from.
class HideInDialog extends StatelessWidget {
  const HideInDialog({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      SheetDialogScope.isDialog(context) ? const SizedBox.shrink() : child;
}
