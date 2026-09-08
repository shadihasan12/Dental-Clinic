import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/home/presentation/theme/home_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The label above each group on the home screen.
///
/// One heading widget for every section, so a heading means the same thing
/// wherever it appears and the trailing action is laid out once. Handoff
/// type: 16/w700, with the action baseline-aligned beside it.
class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.title, this.trailing});

  final String title;

  /// Pushed to the far edge. An action such as "See all".
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Flexible(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.sp,
              height: 1.2,
              fontWeight: FontWeight.w700,
              fontFamily: FontHelper.fontFamily(context),
              color: t.ink,
            ),
          ),
        ),
        const Spacer(),
        if (trailing != null) trailing!,
      ],
    );
  }
}
