part of 'bookmark_bloc.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState({required this.articles});

  final List<NewsModel> articles;

  @override
  List<Object> get props => [articles];
}

class BookmarkInitial extends BookmarkState {
  const BookmarkInitial({required super.articles});

  @override
  List<Object> get props => [articles];
}

class BookmarkLoading extends BookmarkState {
  const BookmarkLoading({required super.articles});

  @override
  List<Object> get props => [articles];
}

class BookmarkLoaded extends BookmarkState {
  const BookmarkLoaded({required super.articles});

  @override
  List<Object> get props => [articles];
}

class BookmarkSaved extends BookmarkState {
  const BookmarkSaved({required super.articles});

  @override
  List<Object> get props => [articles];
}

class BookmarkRemoved extends BookmarkState {
  const BookmarkRemoved({required super.articles});

  @override
  List<Object> get props => [articles];
}

class BookmarkError extends BookmarkState {
  const BookmarkError(this.errorMessage, {required super.articles});
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage, articles];
}
