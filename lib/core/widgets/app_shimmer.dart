import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:dental_clinic_app/core/resources/color_manager.dart';

/// Base shimmer wrapper that uses the app's surface tones and respects RTL.
class AppShimmer extends StatelessWidget {
  const AppShimmer({
    super.key,
    required this.child,
    this.enabled = true,
  });

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = ColorManager.of(context);
    final direction = Directionality.of(context) == TextDirection.rtl
        ? ShimmerDirection.rtl
        : ShimmerDirection.ltr;

    return Shimmer.fromColors(
      baseColor: colors.shimmerBase,
      highlightColor: colors.shimmerHighlight,
      direction: direction,
      enabled: enabled,
      child: child,
    );
  }
}

/// A single rounded rectangle skeleton, wrapped in [AppShimmer].
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.radius,
  });

  final double? width;
  final double? height;
  final BorderRadius? radius;

  @override
  Widget build(BuildContext context) {
    final colors = ColorManager.of(context);
    return AppShimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: colors.shimmerBase,
          borderRadius: radius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}
