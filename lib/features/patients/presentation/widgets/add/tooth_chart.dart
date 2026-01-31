import 'package:dental_clinic_app/core/resources/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:flutter_svg/svg.dart';

/// Interactive tooth chart for selecting teeth
/// Uses standard dental numbering (1-32 for adults)
class ToothChart extends StatefulWidget {
  final List<int> selectedTeeth;
  final ValueChanged<List<int>>? onSelectionChanged;
  final bool enabled;
  final double aspectRatio;
  const ToothChart({
    super.key,
    this.selectedTeeth = const [],
    this.onSelectionChanged,
    this.enabled = true,
    this.aspectRatio = 0.65,
  });

  @override
  State<ToothChart> createState() => _ToothChartState();
}

class _ToothChartState extends State<ToothChart> {
  void _toggleTooth(int toothNumber) {
    print('toothNumber: $toothNumber');
    if (!widget.enabled || widget.onSelectionChanged == null) return;

    final newSelection = List<int>.from(widget.selectedTeeth);
    if (newSelection.contains(toothNumber)) {
      newSelection.remove(toothNumber);
    } else {
      newSelection.add(toothNumber);
    }
    setState(() {});
    widget.onSelectionChanged!(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.gray50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.gray200),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          // minHeight: 500.h,
        ),
        child: AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: 308,
              child: Column(
                children: [
                  _buildUpperJaw(),
                  SizedBox(height: 10),
                  Divider(color: ColorManager.gray200, thickness: 2),
                  SizedBox(height: 10),
                  _buildLowerJaw(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds upper jaw from two mirrored halves
  Widget _buildUpperJaw() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHalf(isUpper: true, isRight: false),
        // Right side (teeth 1-8) - mirrored
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
          child: _buildHalf(isUpper: true, isRight: true),
        ),
        // Left side (teeth 9-16)
      ],
    );
  }

  /// Builds lower jaw by flipping the upper jaw vertically
  Widget _buildLowerJaw() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..scale(1.0, -1.0, 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHalf(isUpper: false, isRight: false),
          // Right side (teeth 32-25) - mirrored
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(-1.0, 1.0, -1.0),
            child: _buildHalf(isUpper: false, isRight: true),
          ),
          // Left side (teeth 24-17)
        ],
      ),
    );
  }

  /// Builds one half (8 teeth) of a jaw
  /// This is the reusable component that gets transformed to create the full mouth
  Widget _buildHalf({required bool isUpper, required bool isRight}) {
    // Calculate tooth numbers
    final List<int> toothNumbers;
    if (isUpper && isRight) {
      toothNumbers = [1, 2, 3, 4, 5, 6, 7, 8]; // Upper right
    } else if (isUpper && !isRight) {
      toothNumbers = [9, 10, 11, 12, 13, 14, 15, 16]; // Upper left
    } else if (!isUpper && isRight) {
      toothNumbers = [32, 31, 30, 29, 28, 27, 26, 25]; // Lower right
    } else {
      toothNumbers = [24, 23, 22, 21, 20, 19, 18, 17]; // Lower left
    }

    return SizedBox(
      width: 154,
      height: 280,
      child: Stack(
        children: [
          // Wisdom tooth (8th tooth)
          _buildTooth(
            toothNumber: toothNumbers[7],
            asset: Assets.iconsCaseTeethWisdom,
            left: 1,
            bottom: 1,
            size: 50,
          ),
          // Second molar (7th tooth)
          _buildTooth(
            toothNumber: toothNumbers[6],
            asset: Assets.iconsCaseTeethSecondMolar,
            left: 10,
            bottom: 40,
            size: 50,
          ),
          // First molar (6th tooth)
          _buildTooth(
            toothNumber: toothNumbers[5],
            asset: Assets.iconsCaseTeethFirstMolar,
            left: 20,
            bottom: 82,
            size: 50,
          ),
          // Second premolar (5th tooth)
          _buildTooth(
            toothNumber: toothNumbers[4],
            asset: Assets.iconsCaseTeethSecondPreMolar,
            left: 35,
            bottom: 122,
            size: 40,
          ),
          // First premolar (4th tooth)
          _buildTooth(
            toothNumber: toothNumbers[3],
            asset: Assets.iconsCaseTeethFirstPreMolar,
            left: 50,
            bottom: 148,
            size: 40,
          ),
          // Canine (3rd tooth)
          _buildTooth(
            toothNumber: toothNumbers[2],
            asset: Assets.iconsCaseTeethCanine,
            left: 68,
            bottom: 175,
            size: 35,
          ),
          // Lateral incisor (2nd tooth)
          _buildTooth(
            toothNumber: toothNumbers[1],
            asset: Assets.iconsCaseTeethLateralInc,
            left: 88,
            bottom: 195,
            size: 35,
          ),
          // Central incisor (1st tooth)
          _buildTooth(
            toothNumber: toothNumbers[0],
            asset: Assets.iconsCaseTeethCentralInc,
            left: 115,
            bottom: 200,
            size: 40,
          ),
        ],
      ),
    );
  }

  /// Builds a single tooth with selection capability
  Widget _buildTooth({
    required int toothNumber,
    required String asset,
    required double left,
    required double bottom,
    required double size,
  }) {
    final isSelected = widget.selectedTeeth.contains(toothNumber);

    return Positioned(
      left: left,
      bottom: bottom,
      width: size,
      height: size,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque, // Makes entire area tappable
        onTap: widget.enabled ? () => _toggleTooth(toothNumber) : null,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: isSelected
                ? Border.all(color: ColorManager.primary, width: 2)
                : null,
          ),
          child: SvgPicture.asset(
            asset,
            width: size,
            height: size,
            fit: BoxFit.contain,
            colorFilter: isSelected
                ? ColorFilter.mode(
                    ColorManager.primary,
                    BlendMode.srcIn, // Use srcIn for solid color replacement
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
