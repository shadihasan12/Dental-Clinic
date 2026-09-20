import 'package:dental_clinic_app/core/resources/app_routes_names.dart';
import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/core/utils/date_time_helper.dart';
import 'package:dental_clinic_app/core/widgets/app_shimmer.dart';
import 'package:dental_clinic_app/core/widgets/directional_chevron.dart';
import 'package:dental_clinic_app/features/home/presentation/theme/home_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Where the user is working, and when.
///
/// Handoff section 2: the clinic as a tappable pill on the leading side, the
/// date plain on the trailing side. The date is laid out first at its
/// natural width so a long clinic name ellipsises into the pill instead of
/// pushing the date off the row.
class ClinicDateRow extends StatelessWidget {
  const ClinicDateRow({
    super.key,
    required this.clinicName,
    this.isLoading = false,
  });

  final String clinicName;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);
    final now = DateTime.now();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsetsDirectional.only(end: 10.w),
            child: isLoading
                ? ShimmerBox(
                    width: 120.w,
                    height: 30.h,
                    radius: BorderRadius.circular(20.r),
                  )
                : _ClinicPill(clinicName: clinicName),
          ),
        ),
        Text(
          // ' · ' rather than a comma: the separator then needs no Arabic
          // variant of its own.
          '${AppDate.weekdayAbbr(context, now)} · '
          '${AppDate.dayMonth(context, now)}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: FontHelper.fontFamily(context),
            fontSize: 11.sp,
            height: 1.3,
            fontWeight: FontWeight.w400,
            color: t.secondary,
          ),
        ),
      ],
    );
  }
}

class _ClinicPill extends StatefulWidget {
  const _ClinicPill({required this.clinicName});

  final String clinicName;

  @override
  State<_ClinicPill> createState() => _ClinicPillState();
}

class _ClinicPillState extends State<_ClinicPill> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final t = HomeTokens.of(context);

    return GestureDetector(
      onTap: () => context.pushNamed(AppRoutesNames.myClinics),
      onTapDown: (_) => setState(() => _down = true),
      onTapCancel: () => setState(() => _down = false),
      onTapUp: (_) => setState(() => _down = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: t.card,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: _down ? t.focusBorder : t.hairline,
            width: _down ? 1.5 : 1,
          ),
        ),
        // The pill keeps one physical arrangement in both languages - dot,
        // name, chevron - so the arrow never jumps from one side of the name
        // to the other. Only the glyph mirrors. The clinic name itself still
        // shapes right-to-left in Arabic.
        child: DirectionalChevron.pinLtr(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7.w,
                height: 7.w,
                decoration: const BoxDecoration(
                  color: ColorManager.success,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  widget.clinicName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: FontHelper.fontFamily(context),
                    fontSize: 12.5.sp,
                    height: 1.2,
                    color: t.ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              DirectionalChevron(size: 14.w, color: t.secondary),
            ],
          ),
        ),
      ),
    );
  }
}
