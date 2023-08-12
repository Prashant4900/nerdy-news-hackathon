class AppConfig {
  static const int pageSize = 40;
}

class DatabaseConfig {
  static const String newsTableColumns = '''
    news_id,
    title,
    description,
    source,
    thumbnail,
    published_at,
    publisher_id,
    publisher_id(name, icon, domain)
  ''';

  static const String newsByPublishTableColumns = '''
    title,
    source,
    thumbnail,
    published_at,
  ''';
}
