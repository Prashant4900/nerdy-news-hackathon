part of 'publisher_bloc.dart';

abstract class PublisherEvent extends Equatable {
  const PublisherEvent();

  @override
  List<Object> get props => [];
}

class GetAllPublishersEvent extends PublisherEvent {
  const GetAllPublishersEvent();

  @override
  List<Object> get props => [];
}

class GetPublisherByIdEvent extends PublisherEvent {
  const GetPublisherByIdEvent({
    required this.publisherId,
  });
  final int publisherId;

  @override
  List<Object> get props => [publisherId];
}

class GetPublisherBySearchEvent extends PublisherEvent {
  const GetPublisherBySearchEvent({
    required this.search,
  });
  final String search;

  @override
  List<Object> get props => [search];
}
