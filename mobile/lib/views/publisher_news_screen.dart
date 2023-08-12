import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/text_style.dart';
import 'package:mobile/features/news/bloc/news_bloc.dart';
import 'package:mobile/features/publisher/model/publisher_model.dart';
import 'package:mobile/utils/datetime_format.dart';
import 'package:mobile/utils/routes_manager.dart';

class PublisherNewsScreen extends StatelessWidget {
  const PublisherNewsScreen({required this.publisher, super.key});

  final PublisherModel publisher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          publisher.name!,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        bloc: context.read<NewsBloc>()
          ..add(
            GetNewsByPublisherIdEvent(publisherId: publisher.id!),
          ),
        builder: (context, state) {
          if (state is NewsInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NewsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NewsLoadedState) {
            final newsList = state.newsList;
            return ListView.separated(
              controller: context.read<NewsBloc>().newsScrollController,
              itemCount: newsList.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.all(8),
                  child: Divider(
                    color: Colors.grey,
                  ),
                );
              },
              itemBuilder: (context, index) {
                final news = newsList[index];
                if (index == 0) {
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
                        CachedNetworkImage(imageUrl: news.thumbnail!),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            news.title!,
                            style: getTitleStyle(context, fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  );
                }
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
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                news.title!,
                                style: getTitleStyle(context),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                getTimeAgo(news.publishedAt!),
                                style: getDescriptionStyle(context),
                              ),
                            ],
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
                  ),
                );
              },
            );
          } else if (state is NewsErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
