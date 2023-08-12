import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mobile/features/news/models/news_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareNews({required NewsModel news}) async {
  await Share.share('${news.title} ${news.source!}', subject: news.title);
}

Future<void> shareImage({required GlobalKey globalKey}) async {
  final boundary =
      globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final image = await boundary.toImage();
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final pngBytes = byteData!.buffer.asUint8List();

  final tempDir = await getTemporaryDirectory();
  final file = await File('${tempDir.path}/image.png').create();
  await file.writeAsBytes(pngBytes);

  await Share.shareXFiles([XFile(file.path)]);
}

// Copy to clipboard
Future<void> copyToClipboard(
  BuildContext context, {
  required String text,
}) async {
  await Clipboard.setData(ClipboardData(text: text)).whenComplete(() {
    const snackBar = SnackBar(
      content: Text('Copied to clipboard'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}
