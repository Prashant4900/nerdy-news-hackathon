import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/text_style.dart';
import 'package:mobile/extensions/extensions.dart';
import 'package:mobile/features/news/models/news_model.dart';
import 'package:mobile/utils/datetime_format.dart';
import 'package:mobile/utils/routes_manager.dart';

class MyLargeNewsCardWidget extends StatelessWidget {
  const MyLargeNewsCardWidget({required this.news, super.key});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          MyRoutes.webviewScreenRoute,
          arguments: {
            'news': news,
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(imageUrl: news.thumbnail!),
          ),
          const SizedBox(height: 10),
          NewsMetaDataWidget(news: news),
          const SizedBox(height: 10),
          Text(
            news.title!,
            style: getTitleStyle(context),
          ),
          const SizedBox(height: 10),
          Text(
            news.description!.getFirstFewWords,
            style: getDescriptionStyle(context),
          ),
        ],
      ),
    );
  }
}

class MySmallNewsCardWidget extends StatelessWidget {
  const MySmallNewsCardWidget({required this.news, super.key});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          MyRoutes.webviewScreenRoute,
          arguments: {
            'news': news,
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NewsMetaDataWidget(news: news),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  news.title!,
                  style: getTitleStyle(context),
                ),
              ),
              const SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: news.thumbnail!,
                  width: 100,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NewsMetaDataWidget extends StatelessWidget {
  const NewsMetaDataWidget({required this.news, super.key});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: news.publisher!.icon!,
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 10),
        Text(
          news.publisher!.name!,
          style: getNewsSourceStyle(context),
        ),
        const Spacer(),
        Text(
          getTimeAgo(news.publishedAt!),
          style: getNewsSourceStyle(context),
        ),
      ],
    );
  }
}
