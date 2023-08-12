import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/wordpress/model/wordpress_news_model.dart';
import 'package:mobile/features/wordpress/repo/wordpress_news_repo.dart';
import 'package:mobile/get_it.dart';

part 'wordpress_news_event.dart';
part 'wordpress_news_state.dart';

class WordpressNewsBloc extends Bloc<WordpressNewsEvent, WordpressNewsState> {
  WordpressNewsBloc() : super(const WordpressNewsInitialState(newsList: [])) {
    on<FetchWordpressNewsByIDEvent>(_fetchWordpressNews);
    on<FetchWordpressNewsListEvent>(_fetchWordpressNewsList);
    on<FetchWordpressNewsListMoreEvent>(_fetchWordpressNewsListMore);
  }

  final wordpressNewsRepo = getIt.get<WordPressNewsRepoImpl>();

  int page = 1;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  FutureOr<void> _fetchWordpressNews(
    FetchWordpressNewsByIDEvent event,
    Emitter<WordpressNewsState> emit,
  ) async {
    emit(const WordpressNewsLoadingState(newsList: []));
    try {
      final result = await wordpressNewsRepo.getNewsByID(
        domain: event.domain,
        newsID: event.newsID,
      );
      emit(WordpressNewsLoadedState(news: result, newsList: const []));
    } catch (e) {
      emit(
        WordpressNewsErrorState(message: e.toString(), newsList: const []),
      );
    }
  }

  FutureOr<void> _fetchWordpressNewsList(
    FetchWordpressNewsListEvent event,
    Emitter<WordpressNewsState> emit,
  ) async {
    emit(const WordpressNewsLoadingState(newsList: []));
    try {
      final result = await wordpressNewsRepo.getNewsList(
        domain: event.domain,
        page: 1,
        perPage: 50,
      );
      emit(WordpressNewsListLoadedState(newsList: result));
    } catch (e) {
      emit(WordpressNewsErrorState(message: e.toString(), newsList: const []));
    }
  }

  FutureOr<void> _fetchWordpressNewsListMore(
    FetchWordpressNewsListMoreEvent event,
    Emitter<WordpressNewsState> emit,
  ) async {
    try {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        page += 1;
        final result = await wordpressNewsRepo.getNewsList(
          domain: event.domain,
          page: page,
          perPage: 50,
        );
        emit(
          WordpressNewsListLoadedState(
            newsList: [...state.newsList, ...result],
          ),
        );
      }
    } catch (e) {
      emit(WordpressNewsErrorState(message: e.toString(), newsList: const []));
    }
  }
}
