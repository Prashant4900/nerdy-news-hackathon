part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState({required this.newsList});
  final List<NewsModel> newsList;

  @override
  List<Object> get props => [newsList];
}

class NewsInitialState extends NewsState {
  const NewsInitialState({required super.newsList});

  @override
  List<Object> get props => [newsList];
}

class NewsLoadingState extends NewsState {
  const NewsLoadingState({required super.newsList});

  @override
  List<Object> get props => [newsList];
}

class NewsLoadedState extends NewsState {
  const NewsLoadedState({required super.newsList});

  @override
  List<Object> get props => [newsList];
}

class NewsErrorState extends NewsState {
  const NewsErrorState({required this.message, required super.newsList});
  final String message;
  @override
  List<Object> get props => [message, newsList];
}
