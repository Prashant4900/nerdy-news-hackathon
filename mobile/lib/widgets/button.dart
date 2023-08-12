import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/app_colors.dart';
import 'package:mobile/features/bookmark/bloc/bookmark_bloc.dart';
import 'package:mobile/features/news/models/news_model.dart';

class CustomElevateButton extends StatelessWidget {
  const CustomElevateButton({
    required this.label,
    required this.onPressed,
    this.icon,
    super.key,
  });

  final String label;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            if (icon != null) const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({
    required this.newsModel,
    super.key,
    this.iconOnly = false,
  });

  final NewsModel newsModel;
  final bool iconOnly;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      bloc: context.read<BookmarkBloc>()..add(ContainArticles(newsModel)),
      builder: (context, state) {
        if (state is BookmarkRemoved) {
          return iconOnly
              ? IconButton(
                  onPressed: () {
                    context.read<BookmarkBloc>().add(SaveArticle(newsModel));
                  },
                  icon: const Icon(Icons.favorite_border),
                )
              : ListTile(
                  leading: const Icon(Icons.favorite_border),
                  title: const Text('Save'),
                  onTap: () async {
                    context.read<BookmarkBloc>().add(SaveArticle(newsModel));
                    Navigator.pop(context);
                  },
                );
        }
        if (state is BookmarkSaved) {
          return iconOnly
              ? IconButton(
                  onPressed: () {
                    context.read<BookmarkBloc>().add(RemoveArticle(newsModel));
                  },
                  icon: const Icon(Icons.favorite),
                )
              : ListTile(
                  leading: const Icon(Icons.favorite),
                  title: const Text('Remove'),
                  onTap: () async {
                    context.read<BookmarkBloc>().add(RemoveArticle(newsModel));
                    Navigator.pop(context);
                  },
                );
        }
        if (state is BookmarkError) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(state.errorMessage),
          //   ),
          // );
          return IconButton(
            onPressed: () {
              context.read<BookmarkBloc>().add(SaveArticle(newsModel));
            },
            icon: const Icon(Icons.abc),
          );
        }
        return iconOnly
            ? IconButton(
                onPressed: () {
                  context.read<BookmarkBloc>().add(SaveArticle(newsModel));
                },
                icon: const Icon(Icons.favorite_border),
              )
            : ListTile(
                leading: const Icon(Icons.favorite_border),
                title: const Text('Save'),
                onTap: () async {
                  context.read<BookmarkBloc>().add(SaveArticle(newsModel));
                  Navigator.pop(context);
                },
              );
      },
    );
  }
}
