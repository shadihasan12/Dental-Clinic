import 'package:dental_clinic_app/core/resources/color_manager.dart';
import 'package:dental_clinic_app/core/resources/font_manager.dart';
import 'package:dental_clinic_app/features/home/presentation/manager/unread_count_cubit.dart';
import 'package:dental_clinic_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The live unread count, drawn as a pill to sit on the corner of a bell icon.
///
/// Reads [UnreadCountCubit], which is a singleton fed from every response that
/// carries `unread_count` — the list, mark-read, mark-all — plus an FCM push on
/// mobile and each `/unseen` poll on Windows. So it updates the moment a
/// notification arrives, on either delivery path, without the host widget
/// having to know which one it is.
///
/// Renders nothing at all when there is no unread mail, so a quiet inbox
/// leaves the icon clean rather than showing a "0".
class UnreadBadge extends StatelessWidget {
  const UnreadBadge({
    super.key,
    required this.borderColor,
    this.size = 16,
    this.fontSize = 9,
  });

  /// Painted as a ring around the pill so it reads as lifted off whatever it
  /// overlaps — pass the surface colour behind the icon.
  final Color borderColor;
  final double size;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnreadCountCubit, int>(
      bloc: getIt<UnreadCountCubit>(),
      builder: (context, unreadCount) {
        if (unreadCount == 0) return const SizedBox.shrink();
        return Container(
          constraints: BoxConstraints(minWidth: size),
          height: size,
          padding: EdgeInsets.symmetric(horizontal: size * 0.25),
          decoration: BoxDecoration(
            color: ColorManager.error,
            borderRadius: BorderRadius.circular(size),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          alignment: Alignment.center,
          child: Text(
            // Past 99 the pill would outgrow the icon it sits on.
            unreadCount > 99 ? '99+' : '$unreadCount',
            style: TextStyle(
              fontFamily: FontHelper.fontFamily(context),
              fontSize: fontSize,
              height: 1,
              fontWeight: FontWeight.w700,
              color: ColorManager.white,
            ),
          ),
        );
      },
    );
  }
}
