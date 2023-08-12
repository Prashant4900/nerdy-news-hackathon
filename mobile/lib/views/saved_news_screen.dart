import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/bookmark/bloc/bookmark_bloc.dart';
import 'package:mobile/utils/routes_manager.dart';

class SavedNewsScreen extends StatelessWidget {
  const SavedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved News'),
      ),
      body: BlocBuilder<BookmarkBloc, BookmarkState>(
        bloc: context.read<BookmarkBloc>()..add(GetAllArticles()),
        builder: (context, state) {
          if (state is BookmarkLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BookmarkLoaded) {
            if (state.articles.isEmpty) {
              return const Center(
                child: Text('No data'),
              );
            }

            return ListView.separated(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];
                return Column(
                  children: [
                    CachedNetworkImage(imageUrl: article.thumbnail!),
                    ListTile(
                      title: Text(article.title!),
                      subtitle: Text(article.description!),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MyRoutes.webviewScreenRoute,
                          arguments: {
                            'news': article,
                          },
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<BookmarkBloc>()
                              .add(RemoveArticle(article));
                        },
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Divider(),
              ),
            );
          } else if (state is BookmarkError) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: Text('No data'),
            );
          }
        },
      ),
    );
  }
}
