import 'package:dental_clinic_app/core/widgets/denta_kit.dart';
import 'package:flutter/material.dart';

/// The label above each group on the home screen.
///
/// A thin name over the kit's [SectionLabel] rather than a heading of its
/// own: the style gives section headings one size, 13/600, and Home used to
/// set them at 16/700. The alias stays so the call sites read as Home's own
/// vocabulary, but the type is now the app's.
class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.title, this.trailing});

  final String title;

  /// Pushed to the far edge. An action such as "See all".
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => SectionLabel(title, trailing: trailing);
}
