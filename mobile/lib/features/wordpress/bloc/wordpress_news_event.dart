part of 'wordpress_news_bloc.dart';

abstract class WordpressNewsEvent extends Equatable {
  const WordpressNewsEvent();

  @override
  List<Object> get props => [];
}

class FetchWordpressNewsByIDEvent extends WordpressNewsEvent {
  const FetchWordpressNewsByIDEvent({
    required this.domain,
    required this.newsID,
  });

  final String domain;
  final int newsID;

  @override
  List<Object> get props => [domain, newsID];
}

class FetchWordpressNewsListEvent extends WordpressNewsEvent {
  const FetchWordpressNewsListEvent({
    required this.domain,
  });

  final String domain;

  @override
  List<Object> get props => [domain];
}

class FetchWordpressNewsListMoreEvent extends WordpressNewsEvent {
  const FetchWordpressNewsListMoreEvent({
    required this.domain,
    required this.page,
  });

  final String domain;
  final int page;

  @override
  List<Object> get props => [domain, page];
}
