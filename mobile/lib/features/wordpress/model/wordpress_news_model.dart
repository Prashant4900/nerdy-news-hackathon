// To parse this JSON data, do
//
//     final wordpressNewsModel = wordpressNewsModelFromJson(jsonString);

import 'dart:convert';

class WordpressNewsModel {
  WordpressNewsModel({
    this.id,
    this.date,
    this.modified,
    this.link,
    this.title,
    this.content,
    this.excerpt,
    this.featuredMedia,
  });

  factory WordpressNewsModel.fromRawJson(String str) =>
      WordpressNewsModel.fromJson(json.decode(str) as Map<String, dynamic>);

  factory WordpressNewsModel.fromJson(Map<String, dynamic> json) =>
      WordpressNewsModel(
        id: json['id'] as int?,
        date: DateTime.parse(json['date'] as String),
        modified: DateTime.parse(json['modified'] as String),
        link: json['link'] as String?,
        title: Title.fromJson(json['title'] as Map<String, dynamic>),
        content: Content.fromJson(json['content'] as Map<String, dynamic>),
        excerpt: Content.fromJson(json['excerpt'] as Map<String, dynamic>),
        featuredMedia: json['featured_media'] as int?,
      );
  final int? id;
  final DateTime? date;
  final DateTime? modified;
  final String? link;
  final Title? title;
  final Content? content;
  final Content? excerpt;
  final int? featuredMedia;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date?.toIso8601String(),
        'modified': modified?.toIso8601String(),
        'link': link,
        'title': title?.toJson(),
        'content': content?.toJson(),
        'excerpt': excerpt?.toJson(),
        'featured_media': featuredMedia,
      };
}

class Content {
  Content({
    this.rendered,
    this.protected,
  });

  factory Content.fromRawJson(String str) =>
      Content.fromJson(json.decode(str) as Map<String, dynamic>);

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json['rendered'] as String?,
        protected: json['protected'] as bool?,
      );
  final String? rendered;
  final bool? protected;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'rendered': rendered,
        'protected': protected,
      };
}

class Title {
  Title({
    this.rendered,
  });

  factory Title.fromRawJson(String str) =>
      Title.fromJson(json.decode(str) as Map<String, dynamic>);

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        rendered: json['rendered'] as String?,
      );
  final String? rendered;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'rendered': rendered,
      };
}
