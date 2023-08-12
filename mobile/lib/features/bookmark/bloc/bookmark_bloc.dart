import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/bookmark/repository/bookmark_repository.dart';
import 'package:mobile/features/news/models/news_model.dart';
import 'package:mobile/get_it.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(const BookmarkInitial(articles: [])) {
    on<SaveArticle>(_onSaveArticle);
    on<RemoveArticle>(_onRemoveArticle);
    on<GetAllArticles>(_onGetAllArticles);
    on<RemoveAllArticles>(_onRemoveAllArticles);
    on<ContainArticles>(_onContainArticles);
  }

  final bookmarkRepo = getIt<BookmarkArticlesRepositoryImpl>();

  FutureOr<void> _onSaveArticle(
    SaveArticle event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(BookmarkLoading(articles: state.articles));
    try {
      final isSaved = await bookmarkRepo.saveArticle(event.newsModel);
      if (isSaved) {
        emit(BookmarkSaved(articles: state.articles..add(event.newsModel)));
      } else {
        emit(BookmarkError('Failed to save article', articles: state.articles));
      }
    } catch (e) {
      emit(BookmarkError(e.toString(), articles: state.articles));
    }
  }

  FutureOr<void> _onRemoveArticle(
    RemoveArticle event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(BookmarkLoading(articles: state.articles));
    try {
      final isRemoved = await bookmarkRepo.removeArticle(event.newsModel);
      final newsList = await bookmarkRepo.getAllArticles();
      if (isRemoved) {
        emit(
          BookmarkLoaded(articles: newsList),
        );
      } else {
        emit(
          BookmarkError(
            'Failed to remove article',
            articles: state.articles,
          ),
        );
      }
    } catch (e) {
      emit(BookmarkError(e.toString(), articles: state.articles));
    }
  }

  FutureOr<void> _onGetAllArticles(
    GetAllArticles event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(BookmarkLoading(articles: state.articles));
    try {
      final articles = await bookmarkRepo.getAllArticles();
      emit(BookmarkLoaded(articles: articles));
    } catch (e) {
      emit(BookmarkError(e.toString(), articles: state.articles));
    }
  }

  FutureOr<void> _onRemoveAllArticles(
    RemoveAllArticles event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(BookmarkLoading(articles: state.articles));
    try {
      final isRemoved = await bookmarkRepo.removeAllArticles();
      if (isRemoved) {
        emit(const BookmarkLoaded(articles: []));
      } else {
        emit(
          BookmarkError(
            'Failed to remove all articles',
            articles: state.articles,
          ),
        );
      }
    } catch (e) {
      emit(BookmarkError(e.toString(), articles: state.articles));
    }
  }

  FutureOr<void> _onContainArticles(
    ContainArticles event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(const BookmarkLoading(articles: []));
    try {
      final isContained = await bookmarkRepo.containsArticle(event.newsModel);
      if (isContained) {
        emit(const BookmarkSaved(articles: []));
      } else {
        emit(
          const BookmarkRemoved(articles: []),
        );
      }
    } catch (e) {
      emit(BookmarkError(e.toString(), articles: const []));
    }
  }
}
