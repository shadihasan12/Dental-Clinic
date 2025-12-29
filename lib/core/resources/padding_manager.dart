import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Spacing values used throughout the application
/// Based on a 4-point spacing system for consistency
class SpacingManager {
  SpacingManager._();

  // ============================================
  // BASE SPACING VALUES
  // ============================================

  /// 0px
  static const double s0 = 0;

  /// 2px - Extra tight spacing
  static const double s2 = 2;

  /// 4px - Very tight spacing
  static const double s4 = 4;

  /// 6px - Tight spacing
  static const double s6 = 6;

  /// 8px - Small spacing (gap-2 in Tailwind)
  static const double s8 = 8;

  /// 10px
  static const double s10 = 10;

  /// 12px - Normal spacing (gap-3 in Tailwind)
  static const double s12 = 12;

  /// 14px
  static const double s14 = 14;

  /// 16px - Relaxed spacing (gap-4 in Tailwind)
  static const double s16 = 16;

  /// 20px - Screen padding horizontal
  static const double s20 = 20;

  /// 24px - Loose spacing (gap-6 in Tailwind)
  static const double s24 = 24;

  /// 28px
  static const double s28 = 28;

  /// 32px - Extra loose spacing (gap-8 in Tailwind)
  static const double s32 = 32;

  /// 40px
  static const double s40 = 40;

  /// 48px
  static const double s48 = 48;

  /// 56px - Large section spacing
  static const double s56 = 56;

  /// 64px
  static const double s64 = 64;

  /// 72px
  static const double s72 = 72;

  /// 80px
  static const double s80 = 80;

  /// 96px
  static const double s96 = 96;
}

/// Padding management class
class PaddingManager {
  PaddingManager._();

  // ============================================
  // PADDING VALUES (Aliases for SpacingManager)
  // ============================================

  static const double p4 = SpacingManager.s4;
  static const double p8 = SpacingManager.s8;
  static const double p12 = SpacingManager.s12;
  static const double p14 = SpacingManager.s14;
  static const double p16 = SpacingManager.s16;
  static const double p20 = SpacingManager.s20;
  static const double p24 = SpacingManager.s24;
  static const double p30 = 30;
  static const double p32 = SpacingManager.s32;
  static const double p40 = SpacingManager.s40;

  // ============================================
  // SCREEN PADDING CONSTANTS
  // ============================================

  /// Horizontal screen padding
  static const double horizontal = 20;

  /// Vertical screen padding
  static const double vertical = 16;

  /// Top safe area padding
  static const double top = 24;

  /// Bottom safe area padding
  static const double bottom = 24;

  // ============================================
  // EDGE INSETS - ALL SIDES
  // ============================================

  /// No padding
  static EdgeInsets get zero => EdgeInsets.zero;

  /// 4px all sides
  static EdgeInsets get all4 => EdgeInsets.all(4.w);

  /// 8px all sides
  static EdgeInsets get all8 => EdgeInsets.all(8.w);

  /// 12px all sides
  static EdgeInsets get all12 => EdgeInsets.all(12.w);

  /// 16px all sides
  static EdgeInsets get all16 => EdgeInsets.all(16.w);

  /// 20px all sides
  static EdgeInsets get all20 => EdgeInsets.all(20.w);

  /// 24px all sides
  static EdgeInsets get all24 => EdgeInsets.all(24.w);

  /// 32px all sides
  static EdgeInsets get all32 => EdgeInsets.all(32.w);

  // ============================================
  // EDGE INSETS - HORIZONTAL
  // ============================================

  /// 4px horizontal
  static EdgeInsets get horizontal4 => EdgeInsets.symmetric(horizontal: 4.w);

  /// 8px horizontal
  static EdgeInsets get horizontal8 => EdgeInsets.symmetric(horizontal: 8.w);

  /// 12px horizontal
  static EdgeInsets get horizontal12 => EdgeInsets.symmetric(horizontal: 12.w);

  /// 16px horizontal
  static EdgeInsets get horizontal16 => EdgeInsets.symmetric(horizontal: 16.w);

  /// 20px horizontal (default screen padding)
  static EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: horizontal.w);

  /// 24px horizontal
  static EdgeInsets get horizontal24 => EdgeInsets.symmetric(horizontal: 24.w);

  /// 32px horizontal
  static EdgeInsets get horizontal32 => EdgeInsets.symmetric(horizontal: 32.w);

  // ============================================
  // EDGE INSETS - VERTICAL
  // ============================================

  /// 4px vertical
  static EdgeInsets get vertical4 => EdgeInsets.symmetric(vertical: 4.h);

  /// 8px vertical
  static EdgeInsets get vertical8 => EdgeInsets.symmetric(vertical: 8.h);

  /// 12px vertical
  static EdgeInsets get vertical12 => EdgeInsets.symmetric(vertical: 12.h);

  /// 16px vertical (default screen padding)
  static EdgeInsets get verticalPadding =>
      EdgeInsets.symmetric(vertical: vertical.h);

  /// 20px vertical
  static EdgeInsets get vertical20 => EdgeInsets.symmetric(vertical: 20.h);

  /// 24px vertical
  static EdgeInsets get vertical24 => EdgeInsets.symmetric(vertical: 24.h);

  /// 32px vertical
  static EdgeInsets get vertical32 => EdgeInsets.symmetric(vertical: 32.h);

  // ============================================
  // COMPONENT-SPECIFIC PADDING
  // ============================================

  /// Screen padding (20px horizontal, 16px vertical)
  static EdgeInsets get screenPadding => EdgeInsets.symmetric(
        horizontal: horizontal.w,
        vertical: vertical.h,
      );

  /// Card padding (16px all)
  static EdgeInsets get cardPadding => EdgeInsets.all(16.w);

  /// Card padding large (20px all)
  static EdgeInsets get cardPaddingLg => EdgeInsets.all(20.w);

  /// List item padding (16px horizontal, 12px vertical)
  static EdgeInsets get listItemPadding => EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      );

  /// List item padding large (20px horizontal, 16px vertical)
  static EdgeInsets get listItemPaddingLg => EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      );

  /// Button padding (24px horizontal, 14px vertical)
  static EdgeInsets get buttonPadding => EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 14.h,
      );

  /// Button padding large (32px horizontal, 16px vertical)
  static EdgeInsets get buttonPaddingLg => EdgeInsets.symmetric(
        horizontal: 32.w,
        vertical: 16.h,
      );

  /// Input padding (16px horizontal, 14px vertical)
  static EdgeInsets get inputPadding => EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 14.h,
      );

  /// Input padding large (20px horizontal, 16px vertical)
  static EdgeInsets get inputPaddingLg => EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      );

  /// Badge/Chip padding (12px horizontal, 6px vertical)
  static EdgeInsets get badgePadding => EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 6.h,
      );

  /// Icon container padding (12px all)
  static EdgeInsets get iconPadding => EdgeInsets.all(12.w);

  /// Dialog padding (24px all)
  static EdgeInsets get dialogPadding => EdgeInsets.all(24.w);

  /// Bottom sheet padding (20px horizontal, 24px vertical)
  static EdgeInsets get bottomSheetPadding => EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 24.h,
      );

  /// Section padding (0 horizontal, 24px vertical)
  static EdgeInsets get sectionPadding => EdgeInsets.symmetric(
        vertical: 24.h,
      );

  // ============================================
  // ONLY PADDING
  // ============================================

  /// Top only 8px
  static EdgeInsets get onlyTop8 => EdgeInsets.only(top: 8.h);

  /// Top only 16px
  static EdgeInsets get onlyTop16 => EdgeInsets.only(top: 16.h);

  /// Top only 24px
  static EdgeInsets get onlyTop24 => EdgeInsets.only(top: 24.h);

  /// Bottom only 8px
  static EdgeInsets get onlyBottom8 => EdgeInsets.only(bottom: 8.h);

  /// Bottom only 16px
  static EdgeInsets get onlyBottom16 => EdgeInsets.only(bottom: 16.h);

  /// Bottom only 24px
  static EdgeInsets get onlyBottom24 => EdgeInsets.only(bottom: 24.h);

  /// Left only 16px
  static EdgeInsets get onlyLeft16 => EdgeInsets.only(left: 16.w);

  /// Right only 16px
  static EdgeInsets get onlyRight16 => EdgeInsets.only(right: 16.w);
}

/// Margin/Gap management class for spacing between elements
class MarginManager {
  MarginManager._();

  // ============================================
  // MARGIN VALUES (Aliases for SpacingManager)
  // ============================================

  static const double m4 = SpacingManager.s4;
  static const double m8 = SpacingManager.s8;
  static const double m12 = SpacingManager.s12;
  static const double m16 = SpacingManager.s16;
  static const double m20 = SpacingManager.s20;
  static const double m24 = SpacingManager.s24;
  static const double m32 = SpacingManager.s32;

  // ============================================
  // VERTICAL SPACERS (SizedBox with height)
  // ============================================

  /// 2px vertical space
  static SizedBox get verticalSpace2 => SizedBox(height: 2.h);

  /// 4px vertical space
  static SizedBox get verticalSpace4 => SizedBox(height: 4.h);

  /// 6px vertical space
  static SizedBox get verticalSpace6 => SizedBox(height: 6.h);

  /// 8px vertical space
  static SizedBox get verticalSpace8 => SizedBox(height: 8.h);

  /// 10px vertical space
  static SizedBox get verticalSpace10 => SizedBox(height: 10.h);

  /// 12px vertical space
  static SizedBox get verticalSpace12 => SizedBox(height: 12.h);

  /// 14px vertical space
  static SizedBox get verticalSpace14 => SizedBox(height: 14.h);

  /// 16px vertical space
  static SizedBox get verticalSpace16 => SizedBox(height: 16.h);

  /// 20px vertical space
  static SizedBox get verticalSpace20 => SizedBox(height: 20.h);

  /// 24px vertical space
  static SizedBox get verticalSpace24 => SizedBox(height: 24.h);

  /// 28px vertical space
  static SizedBox get verticalSpace28 => SizedBox(height: 28.h);

  /// 32px vertical space
  static SizedBox get verticalSpace32 => SizedBox(height: 32.h);

  /// 40px vertical space
  static SizedBox get verticalSpace40 => SizedBox(height: 40.h);

  /// 48px vertical space
  static SizedBox get verticalSpace48 => SizedBox(height: 48.h);

  /// 56px vertical space
  static SizedBox get verticalSpace56 => SizedBox(height: 56.h);

  /// 64px vertical space
  static SizedBox get verticalSpace64 => SizedBox(height: 64.h);

  // ============================================
  // HORIZONTAL SPACERS (SizedBox with width)
  // ============================================

  /// 2px horizontal space
  static SizedBox get horizontalSpace2 => SizedBox(width: 2.w);

  /// 4px horizontal space
  static SizedBox get horizontalSpace4 => SizedBox(width: 4.w);

  /// 6px horizontal space
  static SizedBox get horizontalSpace6 => SizedBox(width: 6.w);

  /// 8px horizontal space
  static SizedBox get horizontalSpace8 => SizedBox(width: 8.w);

  /// 10px horizontal space
  static SizedBox get horizontalSpace10 => SizedBox(width: 10.w);

  /// 12px horizontal space
  static SizedBox get horizontalSpace12 => SizedBox(width: 12.w);

  /// 14px horizontal space
  static SizedBox get horizontalSpace14 => SizedBox(width: 14.w);

  /// 16px horizontal space
  static SizedBox get horizontalSpace16 => SizedBox(width: 16.w);

  /// 20px horizontal space
  static SizedBox get horizontalSpace20 => SizedBox(width: 20.w);

  /// 24px horizontal space
  static SizedBox get horizontalSpace24 => SizedBox(width: 24.w);

  /// 32px horizontal space
  static SizedBox get horizontalSpace32 => SizedBox(width: 32.w);

  // ============================================
  // GAP VALUES (For use with Wrap, Row gap, Column gap)
  // ============================================

  /// Tight gap (8px)
  static const double gapTight = SpacingManager.s8;

  /// Normal gap (12px)
  static const double gapNormal = SpacingManager.s12;

  /// Relaxed gap (16px)
  static const double gapRelaxed = SpacingManager.s16;

  /// Loose gap (24px)
  static const double gapLoose = SpacingManager.s24;
}

/// Size constants for common UI elements
class SizeManager {
  SizeManager._();

  // ============================================
  // ICON SIZES
  // ============================================

  /// Extra small icon - 16px
  static const double iconXs = 16;

  /// Small icon - 20px
  static const double iconSm = 20;

  /// Medium icon - 24px (default)
  static const double iconMd = 24;

  /// Large icon - 28px
  static const double iconLg = 28;

  /// Extra large icon - 32px
  static const double iconXl = 32;

  /// 2X large icon - 40px
  static const double icon2xl = 40;

  /// 3X large icon - 48px
  static const double icon3xl = 48;

  // ============================================
  // AVATAR SIZES
  // ============================================

  /// Extra small avatar - 24px
  static const double avatarXs = 24;

  /// Small avatar - 32px
  static const double avatarSm = 32;

  /// Medium avatar - 40px
  static const double avatarMd = 40;

  /// Large avatar - 48px
  static const double avatarLg = 48;

  /// Extra large avatar - 56px
  static const double avatarXl = 56;

  /// 2X large avatar - 64px
  static const double avatar2xl = 64;

  /// 3X large avatar - 80px
  static const double avatar3xl = 80;

  // ============================================
  // BUTTON HEIGHTS
  // ============================================

  /// Small button height - 36px
  static const double buttonHeightSm = 36;

  /// Medium button height - 44px
  static const double buttonHeightMd = 44;

  /// Large button height - 56px (default)
  static const double buttonHeightLg = 56;

  // ============================================
  // INPUT HEIGHTS
  // ============================================

  /// Small input height - 40px
  static const double inputHeightSm = 40;

  /// Medium input height - 48px
  static const double inputHeightMd = 48;

  /// Large input height - 56px (default)
  static const double inputHeightLg = 56;

  // ============================================
  // TOUCH TARGETS
  // ============================================

  /// Minimum touch target - 44px (iOS/Android guidelines)
  static const double touchTargetMin = 44;

  /// Comfortable touch target - 48px
  static const double touchTarget = 48;

  // ============================================
  // BORDER WIDTHS
  // ============================================

  /// Thin border - 1px
  static const double borderThin = 1;

  /// Medium border - 1.5px
  static const double borderMedium = 1.5;

  /// Thick border - 2px
  static const double borderThick = 2;
}
