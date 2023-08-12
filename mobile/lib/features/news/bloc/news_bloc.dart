import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/config/config.dart';
import 'package:mobile/features/news/models/news_model.dart';
import 'package:mobile/features/news/repo/news_repo.dart';
import 'package:mobile/get_it.dart';

import 'package:mobile/services/supabase_config.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsInitialState(newsList: [])) {
    newsScrollController.addListener(() {
      add(const NewsLoadMoreEvent());
    });
    on<LoadNewsEvent>(_getAllNews);
    on<NewsLoadMoreEvent>(_loadMoreNews);
    on<GetNewsByPublisherIdEvent>(_loadNewsByPublisherId);
    on<GetNewsByMorePublisherIdEvent>(_loadMoreNewsByPublisherId);
    on<GetNewsByIdEvent>(_loadNewsById);
  }

  final newsRepo = getIt.get<NewsRepoImpl>();
  final supabaseConfig = getIt.get<SupabaseConfig>();

  int newsPage = 0;
  int publisherPage = 0;
  ScrollController newsScrollController = ScrollController();
  ScrollController publisherScrollController = ScrollController();
  bool isLoadingMore = false;

  FutureOr<void> _getAllNews(
    LoadNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(const NewsLoadingState(newsList: []));
    try {
      final result = await newsRepo.getAllNews(
        client: supabaseConfig.client,
        page: newsPage,
      );
      emit(NewsLoadedState(newsList: result));
    } catch (e) {
      final message = e.toString();
      isLoadingMore = false;
      emit(NewsErrorState(message: message, newsList: state.newsList));
    }
  }

  FutureOr<void> _loadMoreNews(
    NewsLoadMoreEvent event,
    Emitter<NewsState> emit,
  ) async {
    try {
      if (newsScrollController.position.pixels ==
          newsScrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        newsPage += AppConfig.pageSize;
        final result = await newsRepo.getAllNews(
          client: supabaseConfig.client,
          page: newsPage,
        );
        emit(NewsLoadedState(newsList: [...state.newsList, ...result]));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  FutureOr<void> _loadNewsByPublisherId(
    GetNewsByPublisherIdEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(const NewsLoadingState(newsList: []));
    try {
      final result = await newsRepo.getNewsByPublisherId(
        client: supabaseConfig.client,
        publisherId: event.publisherId,
        page: publisherPage,
      );
      emit(NewsLoadedState(newsList: result));
    } catch (e) {
      final message = e.toString();
      isLoadingMore = false;
      emit(NewsErrorState(message: message, newsList: state.newsList));
    }
  }

  FutureOr<void> _loadMoreNewsByPublisherId(
    GetNewsByMorePublisherIdEvent event,
    Emitter<NewsState> emit,
  ) async {
    publisherScrollController.addListener(() {
      add(GetNewsByMorePublisherIdEvent(publisherId: event.publisherId));
    });
    try {
      if (publisherScrollController.position.pixels ==
          publisherScrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        publisherPage += AppConfig.pageSize;
        final result = await newsRepo.getNewsByPublisherId(
          client: supabaseConfig.client,
          publisherId: event.publisherId,
          page: publisherPage,
        );
        emit(NewsLoadedState(newsList: [...state.newsList, ...result]));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  FutureOr<void> _loadNewsById(
    GetNewsByIdEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(const NewsLoadingState(newsList: []));
    try {
      final result = await newsRepo.getNewsById(
        client: supabaseConfig.client,
        newsId: event.newsId,
      );

      emit(NewsLoadedState(newsList: [result]));
    } catch (e) {
      final message = e.toString();
      isLoadingMore = false;
      emit(NewsErrorState(message: message, newsList: state.newsList));
    }
  }
}
