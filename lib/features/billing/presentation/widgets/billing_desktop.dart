import 'package:flutter/material.dart';

// Desktop-only arrangement for the billing screens. Every piece here only
// places the same cards the mobile layout shows; nothing is drawn that the
// phone does not draw. Callers reach these from their desktop branch only.

/// The cap for a billing page laid out in columns or a grid.
const double kBillingWideWidth = 1200;

/// The cap for a two-pane detail page: wide enough for both panes, narrow
/// enough that a summary row's label and value still read as a pair.
const double kBillingDetailWidth = 1040;

/// The cap for a single billing column - a short form, an empty state, or a
/// wide page falling back on a narrow window. The width the pages had before
/// they went multi-column.
const double kBillingNarrowWidth = 760;

/// Page padding for the desktop branch: the phone's 14px gutter reads as
/// cramped against a side nav.
const EdgeInsets kBillingDesktopPadding = EdgeInsets.fromLTRB(24, 20, 24, 32);

const double kBillingGap = 16;

/// Centres [child] in a column no wider than [kBillingNarrowWidth], for the
/// states and fallbacks that have one column's worth to show.
class BillingNarrowColumn extends StatelessWidget {
  const BillingNarrowColumn({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kBillingNarrowWidth),
        child: child,
      ),
    );
  }
}

/// Two columns side by side once there is room for both, else [start] over
/// [end] in one centred column - a 900-1150px window has the desktop chrome
/// but not the width for two readable panes.
class BillingTwoPane extends StatelessWidget {
  const BillingTwoPane({
    super.key,
    required this.start,
    required this.end,
    this.startFlex = 1,
    this.endFlex = 1,
    this.minWidth = 900,
  });

  final Widget start;
  final Widget end;
  final int startFlex;
  final int endFlex;

  /// Below this the panes stack.
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < minWidth) {
          return BillingNarrowColumn(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [start, const SizedBox(height: kBillingGap), end],
            ),
          );
        }
        // Top-aligned: each pane grows with its own content (an expanded
        // list, a longer history) without stretching the other.
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: startFlex, child: start),
            const SizedBox(width: 20),
            Expanded(flex: endFlex, child: end),
          ],
        );
      },
    );
  }
}

/// Cards in equal-width columns, as many as fit at [minTileWidth] up to
/// [maxColumns]. Rows are built by hand rather than with a Wrap so the
/// columns line up and follow the text direction; each card keeps its own
/// height, so one that expands does not stretch its neighbours.
class BillingGrid extends StatelessWidget {
  const BillingGrid({
    super.key,
    required this.children,
    this.minTileWidth = 320,
    this.maxColumns = 3,
    this.spacing = 14,
    this.runSpacing = 14,
    this.balanced = false,
  });

  final List<Widget> children;
  final double minTileWidth;
  final int maxColumns;
  final double spacing;
  final double runSpacing;

  /// Spreads the cards evenly over the rows they need - four as two by two
  /// rather than three and an orphan, two side by side at half width rather
  /// than a third each - for a set meant to be compared, like plans. Never
  /// fewer than two columns, so a lone card does not span the page.
  final bool balanced;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fit =
            ((constraints.maxWidth + spacing) / (minTileWidth + spacing))
                .floor();
        var columns = fit.clamp(1, maxColumns < 1 ? 1 : maxColumns);
        if (balanced && children.isNotEmpty) {
          final rows = (children.length / columns).ceil();
          final even = (children.length / rows).ceil();
          columns = even < 2 ? (columns < 2 ? columns : 2) : even;
        }
        final rows = (children.length / columns).ceil();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var r = 0; r < rows; r++) ...[
              if (r > 0) SizedBox(height: runSpacing),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < columns; i++) ...[
                    if (i > 0) SizedBox(width: spacing),
                    Expanded(
                      child: r * columns + i < children.length
                          ? children[r * columns + i]
                          : const SizedBox.shrink(),
                    ),
                  ],
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
