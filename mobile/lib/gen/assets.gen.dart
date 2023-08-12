/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsEnvGen {
  const $AssetsEnvGen();

  /// File path: assets/env/development.env
  String get development => 'assets/env/development.env';

  /// File path: assets/env/table.env
  String get table => 'assets/env/table.env';

  /// List of all assets
  List<String> get values => [development, table];
}

class $AssetsGamesGen {
  const $AssetsGamesGen();

  /// File path: assets/games/FlappyBirdLogo.webp
  AssetGenImage get flappyBirdLogo =>
      const AssetGenImage('assets/games/FlappyBirdLogo.webp');

  /// File path: assets/games/dino.jpeg
  AssetGenImage get dino => const AssetGenImage('assets/games/dino.jpeg');

  /// File path: assets/games/snake.png
  AssetGenImage get snake => const AssetGenImage('assets/games/snake.png');

  /// File path: assets/games/tetris.png
  AssetGenImage get tetris => const AssetGenImage('assets/games/tetris.png');

  /// File path: assets/games/tic-tac-toe.jpg
  AssetGenImage get ticTacToeJpg =>
      const AssetGenImage('assets/games/tic-tac-toe.jpg');

  /// File path: assets/games/tic-tac-toe.png
  AssetGenImage get ticTacToePng =>
      const AssetGenImage('assets/games/tic-tac-toe.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [flappyBirdLogo, dino, snake, tetris, ticTacToeJpg, ticTacToePng];
}

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/icon/logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo];
}

class Assets {
  Assets._();

  static const $AssetsEnvGen env = $AssetsEnvGen();
  static const $AssetsGamesGen games = $AssetsGamesGen();
  static const $AssetsIconGen icon = $AssetsIconGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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
