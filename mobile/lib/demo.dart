import 'package:flutter/material.dart';

final newsShareKey = GlobalKey();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Share News'),
      ),
    );
  }
}

class ShareNewsCard extends StatelessWidget {
  const ShareNewsCard({required this.news, super.key});

  final News news;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: newsShareKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            news.thumbnail,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              news.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              news.source,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class News {
  const News({
    required this.title,
    required this.thumbnail,
    required this.source,
  });

  final String title;
  final String source;
  final String thumbnail;
}
