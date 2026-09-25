import 'package:dental_clinic_app/core/resources/responsive.dart';
import 'package:flutter/material.dart';

/// Caps a page's content column on wide windows and centres it.
///
/// A list or form stretched across a 1080p window leaves each row mostly
/// empty space and pushes the eye across the whole display to read one line.
/// Below the desktop breakpoint this is a no-op, so mobile layout is
/// untouched and there is no second code path to keep in sync.
class AdaptiveContentWidth extends StatelessWidget {
  const AdaptiveContentWidth({
    super.key,
    required this.child,
    this.maxWidth = 900,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isDesktop(context)) return child;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
