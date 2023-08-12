import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/publisher/model/publisher_model.dart';
import 'package:mobile/features/publisher/repo/publisher_repo.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/services/supabase_config.dart';

part 'publisher_event.dart';
part 'publisher_state.dart';

class PublisherBloc extends Bloc<PublisherEvent, PublisherState> {
  PublisherBloc() : super(PublisherInitialState()) {
    on<GetAllPublishersEvent>(_getAllPublishers);
    on<GetPublisherByIdEvent>(_getPublisherById);
    on<GetPublisherBySearchEvent>(_getPublisherBySearch);
  }

  final publisherRepo = getIt.get<PublisherRepoImpl>();
  final supabaseConfig = getIt.get<SupabaseConfig>();

  FutureOr<void> _getAllPublishers(
    GetAllPublishersEvent event,
    Emitter<PublisherState> emit,
  ) async {
    emit(PublisherLoadingState());
    try {
      final result = await publisherRepo.getAllPublishers(
        client: supabaseConfig.client,
      );
      emit(AllPublisherLoadedState(publishers: result));
    } catch (e) {
      emit(PublisherErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _getPublisherBySearch(
    GetPublisherBySearchEvent event,
    Emitter<PublisherState> emit,
  ) async {
    emit(PublisherLoadingState());
    try {
      final result = await publisherRepo.getPublisherBySearch(
        client: supabaseConfig.client,
        search: event.search,
      );
      emit(AllPublisherLoadedState(publishers: result));
    } catch (e) {
      emit(PublisherErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _getPublisherById(
    GetPublisherByIdEvent event,
    Emitter<PublisherState> emit,
  ) async {
    emit(PublisherLoadingState());
    try {
      final result = await publisherRepo.getPublisherById(
        client: supabaseConfig.client,
        publisherId: event.publisherId,
      );
      emit(PublisherByIdLoadedState(publisher: result));
    } catch (e) {
      emit(PublisherErrorState(message: e.toString()));
    }
  }
}
