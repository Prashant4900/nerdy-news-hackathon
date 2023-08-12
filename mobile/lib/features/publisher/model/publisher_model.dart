import 'dart:convert';

class PublisherModel {
  PublisherModel({
    this.id,
    this.name,
    this.domain,
    this.icon,
    this.createdAt,
    this.updatedAt,
  });

  factory PublisherModel.fromRawJson(String str) =>
      PublisherModel.fromJson(json.decode(str) as Map<String, dynamic>);

  factory PublisherModel.fromJson(Map<String, dynamic> json) => PublisherModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        domain: json['domain'] as String?,
        icon: json['icon'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );
  final int? id;
  final String? name;
  final String? domain;
  final String? icon;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'domain': domain,
        'icon': icon,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
