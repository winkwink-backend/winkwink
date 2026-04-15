// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/SFONDO_winkwink.png
  AssetGenImage get sFONDOWinkwink =>
      const AssetGenImage('assets/icon/SFONDO_winkwink.png');

  /// File path: assets/icon/countdown.png
  AssetGenImage get countdown =>
      const AssetGenImage('assets/icon/countdown.png');

  /// File path: assets/icon/marchiologo_winkwink1.png
  AssetGenImage get marchiologoWinkwink1 =>
      const AssetGenImage('assets/icon/marchiologo_winkwink1.png');

  /// File path: assets/icon/marchiologo_winkwink11.png
  AssetGenImage get marchiologoWinkwink11 =>
      const AssetGenImage('assets/icon/marchiologo_winkwink11.png');

  /// File path: assets/icon/recordWW.psd
  String get recordWW => 'assets/icon/recordWW.psd';

  /// File path: assets/icon/winkwink_icon.png
  AssetGenImage get winkwinkIcon =>
      const AssetGenImage('assets/icon/winkwink_icon.png');

  /// File path: assets/icon/winkwink_icon1.png
  AssetGenImage get winkwinkIcon1 =>
      const AssetGenImage('assets/icon/winkwink_icon1.png');

  /// File path: assets/icon/winkwink_icon11.png
  AssetGenImage get winkwinkIcon11 =>
      const AssetGenImage('assets/icon/winkwink_icon11.png');

  /// List of all assets
  List<dynamic> get values => [
        sFONDOWinkwink,
        countdown,
        marchiologoWinkwink1,
        marchiologoWinkwink11,
        recordWW,
        winkwinkIcon,
        winkwinkIcon1,
        winkwinkIcon11
      ];
}

class Assets {
  const Assets._();

  static const $AssetsIconGen icon = $AssetsIconGen();
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
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
