import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/app_strings.dart';
import 'package:mobile/features/news/bloc/news_bloc.dart';
import 'package:mobile/widgets/news_card.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppString.appName,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
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
            return Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: ListView.separated(
                controller: context.read<NewsBloc>().newsScrollController,
                itemCount: state.newsList.length,
                itemBuilder: (context, index) {
                  final news = state.newsList[index];

                  if (index % 5 == 0) {
                    return MyLargeNewsCardWidget(news: news);
                  }

                  return MySmallNewsCardWidget(news: news);
                },
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(8),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  );
                },
              ),
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
