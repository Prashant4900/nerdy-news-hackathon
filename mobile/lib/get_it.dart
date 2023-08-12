import 'package:get_it/get_it.dart';
import 'package:mobile/features/auth/repo/auth_repo.dart';
import 'package:mobile/features/bookmark/repository/bookmark_repository.dart';
import 'package:mobile/features/news/repo/news_repo.dart';
import 'package:mobile/features/publisher/repo/publisher_repo.dart';
import 'package:mobile/features/wordpress/repo/wordpress_news_repo.dart';
import 'package:mobile/services/cache_helper.dart';
import 'package:mobile/services/supabase_config.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt
    ..registerSingleton<CacheHelper>(CacheHelper())
    ..registerSingleton<SupabaseConfig>(SupabaseConfig())
    ..registerSingleton<PublisherRepoImpl>(PublisherRepoImpl())
    ..registerSingleton<NewsRepoImpl>(NewsRepoImpl())
    ..registerSingleton<WordPressNewsRepoImpl>(WordPressNewsRepoImpl())
    ..registerSingleton<BookmarkArticlesRepositoryImpl>(
      BookmarkArticlesRepositoryImpl(),
    )
    ..registerSingleton<AuthRepositoryImpl>(AuthRepositoryImpl());
}
