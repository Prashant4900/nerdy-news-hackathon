import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile/constants/app_colors.dart';
import 'package:mobile/constants/app_strings.dart';
import 'package:mobile/constants/text_style.dart';
import 'package:mobile/features/news/models/news_model.dart';
import 'package:mobile/gen/assets.gen.dart';
import 'package:mobile/utils/datetime_format.dart';
import 'package:mobile/widgets/button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareNewsImageScreen extends StatefulWidget {
  const ShareNewsImageScreen({required this.news, super.key});

  final NewsModel news;

  @override
  State<ShareNewsImageScreen> createState() => _ShareNewsImageScreenState();
}

class _ShareNewsImageScreenState extends State<ShareNewsImageScreen> {
  final globalKey = GlobalKey();
  Future<void> shareNews() async {
    final boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 10);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/news_image.png').create();
    await file.writeAsBytes(pngBytes);

    await Share.shareXFiles([XFile(file.path)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Share News',
          style: TextStyle(fontSize: 20),
        ),
        leadingWidth: 80,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Done',
            style: TextStyle(fontSize: 18, color: AppColors.grey),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .03,
            ),
            child: RepaintBoundary(
              key: globalKey,
              child: Card(
                color: AppColors.pureBlack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 10,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.news.thumbnail!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.news.publisher!.icon!,
                            width: 15,
                            height: 15,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.news.publisher!.name!,
                          style: getNewsSourceStyle(context).copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•',
                          style: getNewsSourceStyle(context).copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          getTimeAgo(widget.news.publishedAt!),
                          style: getNewsSourceStyle(context).copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.news.title!,
                      style: getTitleStyle(context).copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.news.description!,
                      style: getDescriptionStyle(context).copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        Assets.icon.logo.image(
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppString.appName,
                          style: getTitleStyle(context).copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomElevateButton(
            label: 'Share',
            onPressed: shareNews,
            icon: Icons.image,
          )
        ],
      ),
    );
  }
}
