import 'package:flutter/material.dart';
import 'package:mobile/features/news/models/news_model.dart';
import 'package:mobile/features/publisher/model/publisher_model.dart';
import 'package:mobile/games/game_launch_screen.dart';
import 'package:mobile/views/publisher_news_screen.dart';
import 'package:mobile/views/saved_news_screen.dart';
import 'package:mobile/views/share_news_image_screen.dart';
import 'package:mobile/views/webview_screen.dart';

class MyRoutes {
  static const String webviewScreenRoute = '/webview';
  static const String publisherNewsRoute = '/publisherNewsRoute';
  static const String shareNewsImageRoute = '/shareNewsImageRoute';
  static const String savedNewsRoute = '/savedNews';
  static const String gameRoute = '/gameRoute';
}

class RoutesManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyRoutes.webviewScreenRoute:
        final args = settings.arguments! as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => MyWebViewScreen(
            news: args['news'] as NewsModel,
          ),
        );
      case MyRoutes.publisherNewsRoute:
        final args = settings.arguments! as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => PublisherNewsScreen(
            publisher: args['publisher'] as PublisherModel,
          ),
        );
      case MyRoutes.shareNewsImageRoute:
        final args = settings.arguments! as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ShareNewsImageScreen(
            news: args['news'] as NewsModel,
          ),
        );
      case MyRoutes.gameRoute:
        final args = settings.arguments! as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => GameLaunchScreen(
            color: args['color'] as Color,
            child: args['child'] as Widget,
          ),
        );
      case MyRoutes.savedNewsRoute:
        return MaterialPageRoute(
          builder: (_) => const SavedNewsScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
