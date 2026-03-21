import 'package:dental_clinic_app/core/resources/gen/assets.gen.dart';
import 'package:dental_clinic_app/features/patients/data/models/tooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:flutter_svg/svg.dart';

/// Interactive tooth chart for selecting teeth
/// Uses teeth data from the API, mapped by FDI universal codes
class ToothChart extends StatefulWidget {
  final List<Tooth> teeth;
  final List<String> selectedTeeth;
  final ValueChanged<List<String>>? onSelectionChanged;
  final bool enabled;
  final double aspectRatio;

  const ToothChart({
    super.key,
    required this.teeth,
    this.selectedTeeth = const [],
    this.onSelectionChanged,
    this.enabled = true,
    this.aspectRatio = 0.65,
  });

  @override
  State<ToothChart> createState() => _ToothChartState();
}

class _ToothChartState extends State<ToothChart> {
  void _toggleTooth(String toothId) {
    print(toothId);
    if (!widget.enabled || widget.onSelectionChanged == null) return;

    final newSelection = List<String>.from(widget.selectedTeeth);
    if (newSelection.contains(toothId)) {
      newSelection.remove(toothId);
    } else {
      newSelection.add(toothId);
    }
    setState(() {});
    widget.onSelectionChanged!(newSelection);
  }

  /// Get the SVG asset for a tooth based on its type index (last digit of FDI code)
  String _assetForToothType(int typeIndex) {
    switch (typeIndex) {
      case 1:
        return Assets.iconsCaseTeethCentralInc;
      case 2:
        return Assets.iconsCaseTeethLateralInc;
      case 3:
        return Assets.iconsCaseTeethCanine;
      case 4:
        return Assets.iconsCaseTeethFirstPreMolar;
      case 5:
        return Assets.iconsCaseTeethSecondPreMolar;
      case 6:
        return Assets.iconsCaseTeethFirstMolar;
      case 7:
        return Assets.iconsCaseTeethSecondMolar;
      case 8:
        return Assets.iconsCaseTeethWisdom;
      default:
        return Assets.iconsCaseTeethCentralInc;
    }
  }

  /// Get the tooth from API data for a given quadrant and type index.
  /// Returns null if no matching tooth exists.
  Tooth? _findTooth(int quadrant, int typeIndex) {
    final code = '$quadrant$typeIndex';
    try {
      return widget.teeth.firstWhere(
        (t) => t.universalCode == code,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.of(context).cardBgSecondary,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorManager.of(context).borderLight),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: 308,
                child: Column(
                  children: [
                    _buildUpperJaw(),
                    const SizedBox(height: 10),
                    Divider(color: ColorManager.of(context).borderLight, thickness: 2),
                    const SizedBox(height: 10),
                    _buildLowerJaw(),
                  ],
                ),
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
        // Left side (Upper Left, quadrant 2) — drawn first, on the left visually
        _buildHalf(quadrant: 2),
        // Right side (Upper Right, quadrant 1) — mirrored
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
          child: _buildHalf(quadrant: 1),
        ),
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
          // Left side (Lower Left, quadrant 3)
          _buildHalf(quadrant: 3),
          // Right side (Lower Right, quadrant 4) — mirrored
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(-1.0, 1.0, -1.0),
            child: _buildHalf(quadrant: 4),
          ),
        ],
      ),
    );
  }

  /// Builds one half (8 teeth) of a jaw for the given FDI quadrant
  Widget _buildHalf({required int quadrant}) {
    // Tooth type indices 1-8 map to positions in the half
    // Index 1 = Central Incisor (near center), Index 8 = Wisdom (at edge)
    // Position data: [left, bottom, size] — identical to original layout
    const positions = <int, List<double>>{
      8: [1, 1, 50],     // Wisdom tooth
      7: [10, 40, 50],   // Second molar
      6: [20, 82, 50],   // First molar
      5: [35, 122, 40],  // Second premolar
      4: [50, 148, 40],  // First premolar
      3: [68, 175, 35],  // Canine
      2: [88, 195, 35],  // Lateral incisor
      1: [115, 200, 40], // Central incisor
    };

    return SizedBox(
      width: 154,
      height: 280,
      child: Stack(
        children: positions.entries.map((entry) {
          final typeIndex = entry.key;
          final pos = entry.value;
          final tooth = _findTooth(quadrant, typeIndex);

          return _buildTooth(
            tooth: tooth,
            typeIndex: typeIndex,
            left: pos[0],
            bottom: pos[1],
            size: pos[2],
          );
        }).toList(),
      ),
    );
  }

  /// Builds a single tooth with selection capability
  Widget _buildTooth({
    required Tooth? tooth,
    required int typeIndex,
    required double left,
    required double bottom,
    required double size,
  }) {
    final isSelected = tooth != null && widget.selectedTeeth.contains(tooth.id);
    final asset = _assetForToothType(typeIndex);

    return Positioned(
      left: left,
      bottom: bottom,
      width: size,
      height: size,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.enabled && tooth != null
            ? () => _toggleTooth(tooth.id)
            : null,
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
            colorFilter: ColorFilter.mode(
                    isSelected
                        ? ColorManager.primary
                        : ColorManager.of(context).textPrimary,
                    BlendMode.srcIn,
                  ),
          ),
        ),
      ),
    );
  }
}
