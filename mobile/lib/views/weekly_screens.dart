import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/app_strings.dart';
import 'package:mobile/constants/text_style.dart';
import 'package:mobile/extensions/extensions.dart';
import 'package:mobile/features/news/bloc/news_bloc.dart';
import 'package:mobile/features/news/models/news_model.dart';

class MyWeeklySegmentScreen extends StatelessWidget {
  const MyWeeklySegmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.weeklySegment),
        centerTitle: true,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadedState) {
            return ListView.separated(
              itemCount: 15,
              itemBuilder: (context, index) {
                final newsList = state.newsList.randomize;
                final news = newsList[index];

                if (index == 0) {
                  return NewsHeaderWidget(news: news);
                }
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: NewsWidget(news: news),
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class NewsHeaderWidget extends StatelessWidget {
  const NewsHeaderWidget({required this.news, super.key});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(imageUrl: news.thumbnail!),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            news.title!,
            style: getTitleStyle(context, fontSize: 18),
          ),
        ),
      ],
    );
  }
}

class NewsWidget extends StatelessWidget {
  const NewsWidget({required this.news, super.key});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        const SizedBox(height: 10),
        Row(
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
          ],
        ),
      ],
    );
  }
}
