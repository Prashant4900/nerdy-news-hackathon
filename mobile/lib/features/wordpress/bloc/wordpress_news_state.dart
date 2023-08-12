part of 'wordpress_news_bloc.dart';

abstract class WordpressNewsState extends Equatable {
  const WordpressNewsState({required this.newsList});
  final List<WordpressNewsModel?> newsList;

  @override
  List<Object> get props => [newsList];
}

class WordpressNewsInitialState extends WordpressNewsState {
  const WordpressNewsInitialState({required super.newsList});

  @override
  List<Object> get props => [newsList];
}

class WordpressNewsLoadingState extends WordpressNewsState {
  const WordpressNewsLoadingState({required super.newsList});

  @override
  List<Object> get props => [newsList];
}

class WordpressNewsLoadedState extends WordpressNewsState {
  const WordpressNewsLoadedState({required this.news, required super.newsList});

  final WordpressNewsModel news;

  @override
  List<Object> get props => [news, newsList];
}

class WordpressNewsListLoadedState extends WordpressNewsState {
  const WordpressNewsListLoadedState({required super.newsList});

  @override
  List<Object> get props => [newsList];
}

class WordpressNewsErrorState extends WordpressNewsState {
  const WordpressNewsErrorState({
    required this.message,
    required super.newsList,
  });

  final String message;

  @override
  List<Object> get props => [message, newsList];
}
