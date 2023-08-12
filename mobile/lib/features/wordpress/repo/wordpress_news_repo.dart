import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/features/wordpress/model/wordpress_news_model.dart';

abstract class WordPressNewsRepo {
  Future<WordpressNewsModel> getNewsByID({
    required String domain,
    required int newsID,
  });

  Future<List<WordpressNewsModel?>> getNewsList({
    required String domain,
    required int page,
    required int perPage,
  });
}

class WordPressNewsRepoImpl implements WordPressNewsRepo {
  WordPressNewsRepoImpl();

  @override
  Future<WordpressNewsModel> getNewsByID({
    required String domain,
    required int newsID,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$domain/wp-json/wp/v2/posts/$newsID',
        ),
      );
      if (response.statusCode == 200) {
        return WordpressNewsModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<WordpressNewsModel?>> getNewsList({
    required String domain,
    required int page,
    required int perPage,
  }) async {
    final url = '$domain/wp-json/wp/v2/posts?page=$page&per_page=$perPage';

    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<Map<String, dynamic>>;

        final wordpressNewsList = data
            .map(
              WordpressNewsModel.fromJson,
            )
            .toList();
        return wordpressNewsList;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
