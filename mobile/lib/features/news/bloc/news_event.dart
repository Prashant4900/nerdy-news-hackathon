part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class LoadNewsEvent extends NewsEvent {
  const LoadNewsEvent();
}

class NewsLoadMoreEvent extends NewsEvent {
  const NewsLoadMoreEvent();

  @override
  List<Object> get props => [];
}

class GetNewsByPublisherIdEvent extends NewsEvent {
  const GetNewsByPublisherIdEvent({required this.publisherId});
  final int publisherId;

  @override
  List<Object> get props => [publisherId];
}

class GetNewsByMorePublisherIdEvent extends NewsEvent {
  const GetNewsByMorePublisherIdEvent({required this.publisherId});
  final int publisherId;

  @override
  List<Object> get props => [publisherId];
}

class GetNewsByIdEvent extends NewsEvent {
  const GetNewsByIdEvent({required this.newsId});

  final int newsId;
  @override
  List<Object> get props => [newsId];
}

class GetNewsBySearchEvent extends NewsEvent {
  const GetNewsBySearchEvent({required this.search});
  final String search;

  @override
  List<Object> get props => [search];
}
