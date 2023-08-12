import 'package:mobile/config/config.dart';
import 'package:mobile/config/env.dart';
import 'package:mobile/extensions/extensions.dart';
import 'package:mobile/features/news/models/news_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class NewsRepo {
  Future<List<NewsModel>> getAllNews({
    required SupabaseClient client,
    int page = 0,
  });
  Future<List<NewsModel>> getNewsByPublisherId({
    required SupabaseClient client,
    required int publisherId,
    int page = 0,
  });
  Future<NewsModel> getNewsById({
    required SupabaseClient client,
    required int newsId,
  });
  // Future<List<NewsModel>> getNewsBySearch({
  //   required SupabaseClient client,
  //   required String search,
  // });
}

class NewsRepoImpl extends NewsRepo {
  @override
  Future<List<NewsModel>> getAllNews({
    required SupabaseClient client,
    int page = 0,
  }) async {
    try {
      final result = await client
          .from(ENV.NEWS_TABLE)
          .select<List<Map<String, dynamic>>>(
            DatabaseConfig.newsTableColumns,
          )
          .order('published_at', ascending: false)
          .range(page + 1, page + AppConfig.pageSize)
          .onError((error, stackTrace) => throw Exception(error));

      if (result.isEmpty) {
        throw Exception('No data found');
      }

      return result.map(NewsModel.fromJson).toList().randomize;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<NewsModel>> getNewsByPublisherId({
    required SupabaseClient client,
    required int publisherId,
    int page = 0,
  }) async {
    try {
      final result = await client
          .from(ENV.NEWS_TABLE)
          .select<List<Map<String, dynamic>>>(
            DatabaseConfig.newsTableColumns,
          )
          .eq('publisher_id', publisherId)
          .order('published_at', ascending: false)
          .range(page + 1, page + AppConfig.pageSize)
          .onError((error, stackTrace) => throw Exception(error));

      if (result.isEmpty) {
        throw Exception('No data found');
      }

      return result.map(NewsModel.fromJson).toList().randomize;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<NewsModel> getNewsById({
    required SupabaseClient client,
    required int newsId,
  }) async {
    try {
      final result = await client
          .from(ENV.NEWS_TABLE)
          .select<Map<String, dynamic>>()
          .eq('news_id', newsId)
          .single()
          .onError((error, stackTrace) => throw Exception(error));
      print('--------------------------------');
      print(result);
      print('--------------------------------');
      if (result.isEmpty) {
        throw Exception('No data found');
      }

      return NewsModel.fromJson(result);
    } catch (e) {
      throw Exception(e);
    }
  }
}
