import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';

/// App-wide toast helper.
///
/// Rendered into the root [Overlay] rather than through [ScaffoldMessenger] so
/// it floats at the *top* of the screen — above dialogs and bottom sheets — and
/// never covers the bottom navigation or a page's primary action button.
class AppSnackbar {
  AppSnackbar._();

  static OverlayEntry? _entry;

  /// Show success toast (teal, appears at the top)
  static void showSuccess(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    _show(context, title: title, message: message, type: _SnackbarType.success);
  }

  /// Show error toast (red, appears at the top)
  static void showError(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    _show(context, title: title, message: message, type: _SnackbarType.error);
  }

  /// Show warning toast (yellow, appears at the top)
  static void showWarning(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    _show(context, title: title, message: message, type: _SnackbarType.warning);
  }

  /// Show info toast (blue, appears at the top)
  static void showInfo(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    _show(context, title: title, message: message, type: _SnackbarType.info);
  }

  /// Removes the toast currently on screen, if any.
  static void dismiss() {
    final entry = _entry;
    _entry = null;
    if (entry != null && entry.mounted) entry.remove();
  }

  static void _show(
    BuildContext context, {
    required String title,
    String? message,
    required _SnackbarType type,
  }) {
    // rootOverlay so the toast also shows over dialogs and modal sheets.
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    // Only one toast at a time — a new one replaces whatever is showing.
    dismiss();

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _ToastCard(
        title: title,
        message: message,
        type: type,
        onDismissed: () {
          if (_entry == entry) _entry = null;
          if (entry.mounted) entry.remove();
        },
      ),
    );
    _entry = entry;
    overlay.insert(entry);
  }
}

enum _SnackbarType { success, error, warning, info }

extension on _SnackbarType {
  Color get backgroundColor {
    switch (this) {
      case _SnackbarType.success:
        return ColorManager.primary;
      case _SnackbarType.error:
        return const Color(0xFFEF4444);
      case _SnackbarType.warning:
        return const Color(0xFFFBBF24);
      case _SnackbarType.info:
        return const Color(0xFF3B82F6);
    }
  }

  /// Text and icon color, picked for contrast against [backgroundColor].
  Color get foregroundColor {
    switch (this) {
      case _SnackbarType.warning:
        return const Color(0xFF5C3D00);
      case _SnackbarType.success:
      case _SnackbarType.error:
      case _SnackbarType.info:
        return ColorManager.white;
    }
  }

  IconData get icon {
    switch (this) {
      case _SnackbarType.success:
        return Icons.check_circle_rounded;
      case _SnackbarType.error:
        return Icons.error_rounded;
      case _SnackbarType.warning:
        return Icons.warning_rounded;
      case _SnackbarType.info:
        return Icons.info_rounded;
    }
  }
}

/// The card itself: drops in from above as it fades in, and lifts back out the
/// same way — so the whole motion reads as a single gesture from the top edge.
///
/// Every dimension here is in logical pixels on purpose: this floats over the
/// root overlay on phone *and* desktop, so ScreenUtil's phone-design scaling
/// would blow it up to full-window size on a wide window.
class _ToastCard extends StatefulWidget {
  const _ToastCard({
    required this.title,
    required this.message,
    required this.type,
    required this.onDismissed,
  });

  final String title;
  final String? message;
  final _SnackbarType type;
  final VoidCallback onDismissed;

  @override
  State<_ToastCard> createState() => _ToastCardState();
}

class _ToastCardState extends State<_ToastCard> {
  static const _enterDuration = Duration(milliseconds: 260);
  static const _exitDuration = Duration(milliseconds: 220);
  static const _visibleDuration = Duration(seconds: 3);

  /// Gap between the status bar / window top and the card.
  static const double _topGap = 12;
  static const double _maxWidth = 420;

  bool _visible = false;
  bool _leaving = false;
  Timer? _autoDismiss;

  @override
  void initState() {
    super.initState();
    // The first frame paints it high and transparent; the next frame animates
    // it down to its resting position.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _visible = true);
    });
    _autoDismiss = Timer(_visibleDuration, _dismiss);
  }

  @override
  void dispose() {
    _autoDismiss?.cancel();
    super.dispose();
  }

  void _dismiss() {
    if (!mounted || _leaving) return;
    _autoDismiss?.cancel();
    setState(() {
      _leaving = true;
      _visible = false;
    });
    Future<void>.delayed(_exitDuration, widget.onDismissed);
  }

  @override
  Widget build(BuildContext context) {
    final type = widget.type;
    final fg = type.foregroundColor;
    final message = widget.message;
    final fontFamily = FontHelper.fontFamily(context);

    final hasMessage = message != null && message.isNotEmpty;
    // Most call sites pass a short title ("Error") plus the real text as the
    // message. When the title carries everything — a raw server message — it
    // gets the extra line the message would have used.
    final titleMaxLines = hasMessage ? 2 : 3;

    final offset = _visible ? Offset.zero : const Offset(0, -0.6);

    return Positioned(
      top: MediaQuery.paddingOf(context).top + _topGap,
      left: 16,
      right: 16,
      child: IgnorePointer(
        ignoring: _leaving,
        child: Align(
          alignment: Alignment.topCenter,
          child: AnimatedSlide(
            offset: offset,
            duration: _leaving ? _exitDuration : _enterDuration,
            curve: Curves.easeOutCubic,
            child: AnimatedOpacity(
              opacity: _visible ? 1 : 0,
              duration: _leaving ? _exitDuration : _enterDuration,
              curve: Curves.easeOut,
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  // Flick it upwards to get rid of it early.
                  onVerticalDragEnd: (details) {
                    if ((details.primaryVelocity ?? 0) < 0) _dismiss();
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: _maxWidth),
                    padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
                    decoration: BoxDecoration(
                      color: type.backgroundColor,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.16),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(type.icon, size: 20, color: fg),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                  color: fg,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  height: 1.3,
                                  fontFamily: fontFamily,
                                ),
                                maxLines: titleMaxLines,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (hasMessage) ...[
                                const SizedBox(height: 2),
                                Text(
                                  message,
                                  style: TextStyle(
                                    color: fg.withValues(alpha: 0.9),
                                    fontSize: 12.5,
                                    height: 1.35,
                                    fontFamily: fontFamily,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _dismiss,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: fg.withValues(alpha: 0.18),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              size: 14,
                              color: fg,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
