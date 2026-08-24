import 'package:flutter/widgets.dart';

/// Height of the system navigation bar, for anything docked to the bottom of
/// the screen.
///
/// The app runs in [SystemUiMode.edgeToEdge] (see `main.dart`), so a docked
/// bar draws underneath the navigation bar unless it reserves this space
/// itself.
///
/// It reads `viewPadding`, not `padding`, and that is the whole point:
/// Flutter defines `padding` as `viewPadding - viewInsets`, so the moment a
/// keyboard opens, `padding.bottom` collapses to zero and every `SafeArea`
/// silently loses its reservation. On a phone with on-screen navigation
/// buttons that shows up as the action button sliding under the buttons
/// while the keyboard closes. `viewPadding` is stable across keyboard
/// changes, so the reservation holds.
///
/// The keyboard itself is a separate concern: use `viewInsets.bottom` for
/// that, and only where the content should lift above it.
double systemBottomInset(BuildContext context) =>
    MediaQuery.viewPaddingOf(context).bottom;

/// [systemBottomInset] plus [extra], for a bar that wants its own breathing
/// room on top of the reserved space.
double dockedBottomPadding(BuildContext context, double extra) =>
    systemBottomInset(context) + extra;

/// Bottom space a bar docked inside a [Scaffold] must reserve.
///
/// This is the one place the collapsing value is the right one. A Scaffold
/// with `resizeToAvoidBottomInset` (the default) already lifts its body and
/// its `bottomNavigationBar` above an open keyboard, so once the keyboard is
/// up the navigation bar is behind it and there is nothing left to reserve —
/// which is exactly what `MediaQuery.padding` describes.
///
/// A modal bottom sheet gets no such treatment: it stays anchored to the
/// bottom of the screen with the keyboard drawn over it, so a sheet wants
/// [systemBottomInset] (or the larger of it and `viewInsets.bottom`)
/// instead. Reaching for the wrong one of these two is the whole reason this
/// file exists.
double scaffoldBottomInset(BuildContext context) =>
    MediaQuery.paddingOf(context).bottom;

/// [scaffoldBottomInset] plus [extra].
double scaffoldBottomPadding(BuildContext context, double extra) =>
    scaffoldBottomInset(context) + extra;
