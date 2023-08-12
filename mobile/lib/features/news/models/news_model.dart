import 'dart:convert';

import 'package:mobile/features/publisher/model/publisher_model.dart';

class NewsModel {
  NewsModel({
    this.id,
    this.newsId,
    this.title,
    this.description,
    this.source,
    this.thumbnail,
    this.publishedAt,
    this.publisher,
  });

  factory NewsModel.fromRawJson(String str) => NewsModel.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json['id'] as int?,
        newsId: json['news_id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        source: json['source'] as String?,
        thumbnail: json['thumbnail'] as String?,
        publishedAt: DateTime.parse(json['published_at'] as String? ?? ''),
        publisher: PublisherModel.fromJson(
          json['publisher_id'] as Map<String, dynamic>,
        ),
      );
  final int? id;
  final int? newsId;
  final String? title;
  final String? description;
  final String? source;
  final String? thumbnail;
  final DateTime? publishedAt;
  final PublisherModel? publisher;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'news_id': newsId,
        'title': title,
        'description': description,
        'source': source,
        'thumbnail': thumbnail,
        'published_at': publishedAt?.toIso8601String(),
        'publisher_id': publisher?.toJson(),
      };

  @override
  String toString() {
    return 'NewsModel(id: $id, newsId: $newsId, title: $title, ...)';
  }
}
