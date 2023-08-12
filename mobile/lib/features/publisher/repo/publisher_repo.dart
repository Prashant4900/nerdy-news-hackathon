import 'package:mobile/config/env.dart';
import 'package:mobile/features/publisher/model/publisher_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PublisherRepo {
  Future<List<PublisherModel>> getAllPublishers({
    required SupabaseClient client,
  });
  Future<PublisherModel> getPublisherById({
    required SupabaseClient client,
    required int publisherId,
  });
  Future<List<PublisherModel>> getPublisherBySearch({
    required SupabaseClient client,
    required String search,
  });
}

class PublisherRepoImpl extends PublisherRepo {
  @override
  Future<List<PublisherModel>> getAllPublishers({
    required SupabaseClient client,
  }) async {
    try {
      final result = await client
          .from(ENV.PUBLISHER_TABLE)
          .select<List<Map<String, dynamic>>>()
          .onError((error, stackTrace) => throw Exception(error));

      if (result.isEmpty) {
        throw Exception('No data found');
      }

      return result.map(PublisherModel.fromJson).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PublisherModel>> getPublisherBySearch({
    required SupabaseClient client,
    required String search,
  }) async {
    try {
      final result = await client
          .from(ENV.PUBLISHER_TABLE)
          .select<List<Map<String, dynamic>>>()
          .ilike('name', '%$search%')
          // .or('domain', 'eq', '%$search%')
          .onError((error, stackTrace) => throw Exception(error));

      if (result.isEmpty) {
        throw Exception('No data found');
      }

      return result.map(PublisherModel.fromJson).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<PublisherModel> getPublisherById({
    required SupabaseClient client,
    required int publisherId,
  }) async {
    try {
      final result = await client
          .from(ENV.PUBLISHER_TABLE)
          .select<Map<String, dynamic>>()
          .eq('id', publisherId)
          .single()
          .onError((error, stackTrace) => throw Exception(error));

      if (result.isEmpty) {
        throw Exception('No data found');
      }

      return PublisherModel.fromJson(result);
    } catch (e) {
      throw Exception(e);
    }
  }
}
