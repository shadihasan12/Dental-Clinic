import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/widgets/directional_chevron.dart';
import 'package:flutter/material.dart';

/// Shared stat tiles for the wide-window page layouts.
///
/// The patients list wrote these inline; home needs the same tiles, so they
/// live here rather than being copied and drifting apart. The desktop page
/// The desktop page header and the primary/secondary buttons live here too:
/// they started out beside the patient form fields, but expenses,
/// appointments and home all need the same controls, and three of those are
/// nowhere near the patients feature.
///
/// All of them use raw pixel sizes rather than `.w`/`.sp`: the desktop shells
/// reconfigure ScreenUtil to the 375x812 design size, so the two are 1:1 and
/// raw values keep the intent obvious.

/// A single figure with an icon chip above it — the tile used across the
/// desktop stat rows.
class DesktopStatCard extends StatelessWidget {
  const DesktopStatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    this.iconBg,
  });

  final IconData icon;
  final Color iconColor;

  /// Defaults to [iconColor] at 12% — the tint every existing tile uses.
  final Color? iconBg;

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg ?? iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: c.textPrimary,
              letterSpacing: -0.3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 12.5,
              color: c.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Lays [cards] out edge to edge, wrapping onto a second line when the window
/// is too narrow to give each tile a readable width.
class DesktopStatsRow extends StatelessWidget {
  const DesktopStatsRow({super.key, required this.cards, this.compact = false});

  final List<DesktopStatCard> cards;

  /// Two rows of two instead of a single row of four.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (!compact) {
      return Row(
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            Expanded(child: cards[i]),
            if (i != cards.length - 1) const SizedBox(width: 14),
          ],
        ],
      );
    }

    final rows = <Widget>[];
    for (var i = 0; i < cards.length; i += 2) {
      rows.add(
        Row(
          children: [
            Expanded(child: cards[i]),
            const SizedBox(width: 14),
            if (i + 1 < cards.length)
              Expanded(child: cards[i + 1])
            else
              const Spacer(),
          ],
        ),
      );
    }
    return Column(
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          rows[i],
          if (i != rows.length - 1) const SizedBox(height: 14),
        ],
      ],
    );
  }
}

class DesktopPrimaryButton extends StatefulWidget {
  const DesktopPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.color,
    this.foreground,
    this.fullWidth = false,
    this.isLoading = false,
    this.compact = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;
  final Color? foreground;
  final bool fullWidth;
  final bool isLoading;
  final bool compact;

  @override
  State<DesktopPrimaryButton> createState() => _DesktopPrimaryButtonState();
}

class _DesktopPrimaryButtonState extends State<DesktopPrimaryButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null && !widget.isLoading;
    final base = widget.color ?? ColorManager.primary;
    final fg = widget.foreground ?? Colors.white;
    final fontFamily = FontHelper.fontFamily(context);

    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: enabled ? widget.onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          // One set of metrics for every desktop add/primary button in
          // the app, taken from the expenses header button: 16x11 padding,
          // an 18px icon and a 13px semibold label.
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 13 : 16,
            vertical: widget.compact ? 9 : 11,
          ),
          decoration: BoxDecoration(
            color: enabled
                ? (_hovering ? base.withValues(alpha: 0.9) : base)
                : base.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(10),
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: base.withValues(alpha: _hovering ? 0.35 : 0.18),
                      blurRadius: _hovering ? 14 : 8,
                      offset: Offset(0, _hovering ? 6 : 3),
                    ),
                  ]
                : null,
          ),
          width: widget.fullWidth ? double.infinity : null,
          child: Row(
            mainAxisSize:
                widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading)
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(fg),
                  ),
                )
              else if (widget.icon != null) ...[
                Icon(widget.icon, color: fg, size: widget.compact ? 16 : 18),
                const SizedBox(width: 8),
              ],
              if (!widget.isLoading)
                Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: widget.compact ? 12.5 : 13,
                    fontWeight: FontWeight.w600,
                    color: fg,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DesktopSecondaryButton extends StatefulWidget {
  const DesktopSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.compact = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool fullWidth;
  final bool compact;

  @override
  State<DesktopSecondaryButton> createState() => _DesktopSecondaryButtonState();
}

class _DesktopSecondaryButtonState extends State<DesktopSecondaryButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    final enabled = widget.onPressed != null;

    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: enabled ? widget.onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 14 : 20,
            vertical: widget.compact ? 9 : 12,
          ),
          decoration: BoxDecoration(
            color: _hovering ? c.inputBg : c.cardBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: c.border),
          ),
          width: widget.fullWidth ? double.infinity : null,
          child: Row(
            mainAxisSize:
                widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: c.textSecondary,
                  size: widget.compact ? 16 : 18,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: widget.compact ? 12.5 : 13.5,
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DesktopPageHeader extends StatelessWidget {
  const DesktopPageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onSubtitleTap,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;

  /// Turns the subtitle into a control rather than a caption.
  ///
  /// Set it and the subtitle is drawn as a tinted chip that lights up under
  /// the pointer — the desktop counterpart of the clinic switcher on the
  /// mobile home header. Left null, the subtitle stays plain text.
  final VoidCallback? onSubtitleTap;

  @override
  Widget build(BuildContext context) {
    final c = ColorManager.of(context);
    final fontFamily = FontHelper.fontFamily(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: c.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 6),
                if (onSubtitleTap != null)
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: _HeaderSubtitleButton(
                      label: subtitle!,
                      onTap: onSubtitleTap!,
                      fontFamily: fontFamily,
                    ),
                  )
                else
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 13,
                      color: c.textTertiary,
                    ),
                  ),
              ],
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

/// The clickable form of [DesktopPageHeader.subtitle].
///
/// Mirrors the mobile home header's clinic chip - status dot, name, chevron -
/// so the same destination looks like the same thing on both form factors.
/// Desktop adds what a phone has no way to show: the tint deepens and the
/// cursor turns under the pointer, which is the only cue a mouse user gets
/// that a line of text is a destination.
class _HeaderSubtitleButton extends StatefulWidget {
  const _HeaderSubtitleButton({
    required this.label,
    required this.onTap,
    required this.fontFamily,
  });

  final String label;
  final VoidCallback onTap;
  final String fontFamily;

  @override
  State<_HeaderSubtitleButton> createState() => _HeaderSubtitleButtonState();
}

class _HeaderSubtitleButtonState extends State<_HeaderSubtitleButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.fromLTRB(10, 6, 8, 6),
          decoration: BoxDecoration(
            color: ColorManager.primary.withValues(
              alpha: _hovering ? 0.18 : 0.10,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ColorManager.primary.withValues(
                alpha: _hovering ? 0.45 : 0,
              ),
            ),
          ),
          // One physical arrangement in both languages - dot, name, chevron -
          // so the arrow never jumps sides. Only the glyph mirrors; the clinic
          // name itself still shapes right-to-left in Arabic.
          child: DirectionalChevron.pinLtr(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: ColorManager.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 7),
                Flexible(
                  child: Text(
                    widget.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: widget.fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primaryDarker,
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                DirectionalChevron(
                  size: 16,
                  color: ColorManager.primaryDarker,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
