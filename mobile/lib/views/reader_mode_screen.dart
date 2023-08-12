import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mobile/constants/text_style.dart';
import 'package:mobile/features/news/models/news_model.dart';
import 'package:mobile/features/wordpress/bloc/wordpress_news_bloc.dart';

class ReaderModeScreen extends StatelessWidget {
  const ReaderModeScreen({
    required this.news,
    required this.fontSizeFactor,
    super.key,
  });

  final NewsModel news;
  final double fontSizeFactor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordpressNewsBloc, WordpressNewsState>(
      bloc: context.read<WordpressNewsBloc>()
        ..add(
          FetchWordpressNewsByIDEvent(
            domain: news.publisher!.domain!,
            newsID: news.newsId!,
          ),
        ),
      buildWhen: (previous, current) {
        if (current is WordpressNewsLoadedState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is WordpressNewsErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is WordpressNewsLoadedState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    news.title!,
                    style:
                        getTitleStyle(context, fontSize: 24 + fontSizeFactor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'by ${news.publisher!.name!}',
                    style: getNewsSourceStyle(context, fontSize: 14),
                  ),
                ),
                Html(
                  data: state.news.content!.rendered,
                  shrinkWrap: true,
                  style: {
                    'body': Style(
                      fontSize: FontSize(16 + fontSizeFactor),
                      lineHeight: const LineHeight(1.5),
                    ),
                    'img': Style(
                      width: Width(
                        MediaQuery.of(context).size.width / 1.05,
                        Unit.percent,
                      ),
                      height: Height(
                        MediaQuery.of(context).size.height / 2.5,
                        Unit.percent,
                      ),
                    ),
                  },
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
