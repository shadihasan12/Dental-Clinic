// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class Assets {
  const Assets._();

  /// File path: assets/icons/case/teeth/canine.svg
  static const String iconsCaseTeethCanine =
      'assets/icons/case/teeth/canine.svg';

  /// File path: assets/icons/case/teeth/central_inc.svg
  static const String iconsCaseTeethCentralInc =
      'assets/icons/case/teeth/central_inc.svg';

  /// File path: assets/icons/case/teeth/first_molar.svg
  static const String iconsCaseTeethFirstMolar =
      'assets/icons/case/teeth/first_molar.svg';

  /// File path: assets/icons/case/teeth/first_pre_molar.svg
  static const String iconsCaseTeethFirstPreMolar =
      'assets/icons/case/teeth/first_pre_molar.svg';

  /// File path: assets/icons/case/teeth/lateral_inc.svg
  static const String iconsCaseTeethLateralInc =
      'assets/icons/case/teeth/lateral_inc.svg';

  /// File path: assets/icons/case/teeth/second_molar.svg
  static const String iconsCaseTeethSecondMolar =
      'assets/icons/case/teeth/second_molar.svg';

  /// File path: assets/icons/case/teeth/second_pre_molar.svg
  static const String iconsCaseTeethSecondPreMolar =
      'assets/icons/case/teeth/second_pre_molar.svg';

  /// File path: assets/icons/case/teeth/wisdom.svg
  static const String iconsCaseTeethWisdom =
      'assets/icons/case/teeth/wisdom.svg';

  /// File path: assets/icons/root/appointment.svg
  static const String iconsRootAppointment =
      'assets/icons/root/appointment.svg';

  /// File path: assets/icons/root/home.svg
  static const String iconsRootHome = 'assets/icons/root/home.svg';

  /// File path: assets/icons/root/menu.svg
  static const String iconsRootMenu = 'assets/icons/root/menu.svg';

  /// File path: assets/icons/root/money.svg
  static const String iconsRootMoney = 'assets/icons/root/money.svg';

  /// File path: assets/icons/root/patient.svg
  static const String iconsRootPatient = 'assets/icons/root/patient.svg';

  /// File path: assets/icons/root/statistics.svg
  static const String iconsRootStatistics = 'assets/icons/root/statistics.svg';

  /// File path: assets/images/logo/denta_logo.png
  static const AssetGenImage imagesLogoDentaLogo = AssetGenImage(
    'assets/images/logo/denta_logo.png',
  );

  /// File path: assets/images/logo/denta_mark.png
  static const AssetGenImage imagesLogoDentaMark = AssetGenImage(
    'assets/images/logo/denta_mark.png',
  );

  /// File path: assets/images/onboarding/1.jpg
  static const AssetGenImage imagesOnboarding1 = AssetGenImage(
    'assets/images/onboarding/1.jpg',
  );

  /// File path: assets/images/onboarding/2.jpg
  static const AssetGenImage imagesOnboarding2 = AssetGenImage(
    'assets/images/onboarding/2.jpg',
  );

  /// File path: assets/images/onboarding/3.jpg
  static const AssetGenImage imagesOnboarding3 = AssetGenImage(
    'assets/images/onboarding/3.jpg',
  );

  /// List of all assets
  static List<dynamic> get values => [
    iconsCaseTeethCanine,
    iconsCaseTeethCentralInc,
    iconsCaseTeethFirstMolar,
    iconsCaseTeethFirstPreMolar,
    iconsCaseTeethLateralInc,
    iconsCaseTeethSecondMolar,
    iconsCaseTeethSecondPreMolar,
    iconsCaseTeethWisdom,
    iconsRootAppointment,
    iconsRootHome,
    iconsRootMenu,
    iconsRootMoney,
    iconsRootPatient,
    iconsRootStatistics,
    imagesLogoDentaLogo,
    imagesLogoDentaMark,
    imagesOnboarding1,
    imagesOnboarding2,
    imagesOnboarding3,
  ];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
