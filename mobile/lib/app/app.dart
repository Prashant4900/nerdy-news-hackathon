import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/app_strings.dart';
import 'package:mobile/constants/theme_manager.dart';
import 'package:mobile/features/auth/bloc/auth_bloc.dart';
import 'package:mobile/features/bookmark/bloc/bookmark_bloc.dart';
import 'package:mobile/features/news/bloc/news_bloc.dart';
import 'package:mobile/features/publisher/bloc/publisher_bloc.dart';
import 'package:mobile/features/reader_mode/cubit/reader_mode_cubit.dart';
import 'package:mobile/features/theme/cubit/theme_cubit.dart';
import 'package:mobile/features/wordpress/bloc/wordpress_news_bloc.dart';
import 'package:mobile/utils/routes_manager.dart';
import 'package:mobile/views/dashboard.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit()..getTheme(),
        ),
        BlocProvider<ReaderModeCubit>(
          create: (context) => ReaderModeCubit()..getReaderMode(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(IsSignedInEvent()),
        ),
        BlocProvider<PublisherBloc>(
          create: (context) =>
              PublisherBloc()..add(const GetAllPublishersEvent()),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc()..add(const LoadNewsEvent()),
        ),
        BlocProvider<WordpressNewsBloc>(
          create: (context) => WordpressNewsBloc(),
        ),
        BlocProvider<BookmarkBloc>(
          create: (context) => BookmarkBloc()..add(GetAllArticles()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is ThemeChanged) {
            return MyMaterialApp(themeMode: state.themeMode);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({
    required this.themeMode,
    super.key,
  });

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.appName,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      themeMode: themeMode,
      onGenerateRoute: RoutesManager.generateRoute,
      home: const Dashboard(),
    );
  }
}
