import 'dart:convert';

import 'package:mobile/extensions/extensions.dart';
import 'package:mobile/features/news/models/news_model.dart';
import 'package:mobile/services/cache_helper.dart';
import 'package:mobile/utils/app_pref.dart';

abstract class BookmarkArticlesRepository {
  Future<List<NewsModel>> getAllArticles();
  Future<bool> saveArticle(NewsModel newsModel);
  Future<bool> removeArticle(NewsModel newsModel);
  Future<bool> removeAllArticles();
  Future<bool> containsArticle(NewsModel newsModel);
}

class BookmarkArticlesRepositoryImpl implements BookmarkArticlesRepository {
  BookmarkArticlesRepositoryImpl();

  @override
  Future<List<NewsModel>> getAllArticles() async {
    print('getAllArticles');
    try {
      final json = await CacheHelper.getBookMarkList();
      json.log('json');
      final newsList = json.map((e) {
        // print('e: ${e.runtimeType}');
        // jsonDecode(e).log('e');
        return NewsModel.fromJson(jsonDecode(e) as Map<String, dynamic>);
      }).toList();
      print('newsList: $newsList');
      return newsList;
    } catch (e) {
      print('error: $e');
      throw Exception(e);
    }
  }

  @override
  Future<bool> saveArticle(NewsModel newsModel) async {
    try {
      final json = newsModel.toJson();
      final bookMarkList = await CacheHelper.getBookMarkList();
      bookMarkList.add(jsonEncode(json));
      return CacheHelper.saveBookMarkList(
        key: PreferenceKey.bookMarkList,
        bookMarkList: bookMarkList,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> removeArticle(NewsModel newsModel) async {
    try {
      final json = newsModel.toJson();
      final bookMarkList = await CacheHelper.getBookMarkList();
      bookMarkList.remove(jsonEncode(json));
      return CacheHelper.saveBookMarkList(
        key: PreferenceKey.bookMarkList,
        bookMarkList: bookMarkList,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> removeAllArticles() async {
    try {
      return await CacheHelper.saveBookMarkList(
        key: PreferenceKey.bookMarkList,
        bookMarkList: [],
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> containsArticle(NewsModel newsModel) async {
    try {
      final json = newsModel.toJson();
      final bookMarkList = await CacheHelper.getBookMarkList();
      final isContain = bookMarkList.contains(jsonEncode(json));

      return isContain;
    } catch (e) {
      throw Exception(e);
    }
  }
}
