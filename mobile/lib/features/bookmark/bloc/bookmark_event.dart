part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class GetAllArticles extends BookmarkEvent {}

class SaveArticle extends BookmarkEvent {
  const SaveArticle(this.newsModel);
  final NewsModel newsModel;

  @override
  List<Object> get props => [newsModel];
}

class RemoveArticle extends BookmarkEvent {
  const RemoveArticle(this.newsModel);
  final NewsModel newsModel;

  @override
  List<Object> get props => [newsModel];
}

class RemoveAllArticles extends BookmarkEvent {}

class ContainArticles extends BookmarkEvent {
  const ContainArticles(this.newsModel);
  final NewsModel newsModel;

  @override
  List<Object> get props => [newsModel];
}
