part of 'publisher_bloc.dart';

abstract class PublisherState extends Equatable {
  const PublisherState();

  @override
  List<Object> get props => [];
}

class PublisherInitialState extends PublisherState {}

class PublisherLoadingState extends PublisherState {}

class AllPublisherLoadedState extends PublisherState {
  const AllPublisherLoadedState({
    required this.publishers,
  });
  final List<PublisherModel> publishers;

  @override
  List<Object> get props => [publishers];
}

class PublisherByIdLoadedState extends PublisherState {
  const PublisherByIdLoadedState({
    required this.publisher,
  });
  final PublisherModel publisher;

  @override
  List<Object> get props => [publisher];
}

class PublisherErrorState extends PublisherState {
  const PublisherErrorState({
    required this.message,
  });
  final String message;

  @override
  List<Object> get props => [message];
}
