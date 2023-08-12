import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/app_strings.dart';
import 'package:mobile/constants/text_style.dart';
import 'package:mobile/features/auth/bloc/auth_bloc.dart';
import 'package:mobile/features/bookmark/bloc/bookmark_bloc.dart';
import 'package:mobile/features/publisher/bloc/publisher_bloc.dart';
import 'package:mobile/games/dino/dino_game.dart';
import 'package:mobile/games/flippy_bird/flippy_bird_screen.dart';
import 'package:mobile/games/snake/snake_game_screen.dart';
import 'package:mobile/games/tictactoe/tic_toc_toe_game_screen.dart';
import 'package:mobile/gen/assets.gen.dart';
import 'package:mobile/utils/routes_manager.dart';
import 'package:mobile/widgets/divider.dart';
import 'package:mobile/widgets/game_list_card.dart';
import 'package:mobile/widgets/section_header.dart';
import 'package:mobile/widgets/theme_tile.dart';
import 'package:share_plus/share_plus.dart';

class MySectionScreen extends StatelessWidget {
  const MySectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.section),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<dynamic>(
                context: context,
                useSafeArea: true,
                builder: (context) => const BottomSheet(),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SectionHeaderWidget(
            title: AppString.savedArticleTitle,
            description: AppString.savedArticleDescription,
          ),
          BlocBuilder<BookmarkBloc, BookmarkState>(
            bloc: context.read<BookmarkBloc>()..add(GetAllArticles()),
            builder: (context, state) {
              if (state is BookmarkLoaded) {
                final newsList = state.articles;
                // final newsList = <NewsModel>[];
                return CarouselSlider.builder(
                  itemCount: newsList.length + 1,
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 0.9,
                    height: 310,
                  ),
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    if (index == newsList.length) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MyRoutes.savedNewsRoute,
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blueGrey,
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'See more articles',
                                style: getTitleStyle(context, fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'All your saved articles will be shown here',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MyRoutes.webviewScreenRoute,
                          arguments: {
                            'news': newsList[index],
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Builder(
                              builder: (BuildContext context) {
                                return CachedNetworkImage(
                                  imageUrl: newsList[index].thumbnail!,
                                );
                              },
                            ),
                            const SizedBox(height: 8),
                            Text(
                              newsList[index].title!,
                              style: getTitleStyle(context, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
          const ThickDivider(),
          const SectionHeaderWidget(
            title: AppString.gameTitle,
            description: AppString.gameDescription,
          ),
          GameListCardWidget(
            image: RotatedBox(
              quarterTurns: 3,
              child: Assets.games.snake.image(
                height: 70,
                width: 70,
              ),
            ),
            title: 'Snake',
            description: 'Play the classic Snake game',
            onTap: () {
              Navigator.pushNamed(
                context,
                MyRoutes.gameRoute,
                arguments: {
                  'child': const MySnakeGameScreen(),
                  'color': Colors.yellow,
                },
              );
            },
          ),
          GameListCardWidget(
            image: Assets.games.ticTacToeJpg.image(
              height: 70,
              width: 70,
            ),
            title: 'Tic Tac Toe',
            description: 'Play the classic Tic Tac Toe game',
            onTap: () {
              Navigator.pushNamed(
                context,
                MyRoutes.gameRoute,
                arguments: {
                  'child': const TicTacToeScreen(),
                  'color': Colors.yellow,
                },
              );
            },
          ),
          GameListCardWidget(
            image: Assets.games.flappyBirdLogo.image(
              height: 70,
              width: 70,
            ),
            title: 'Flappy Bird',
            description: 'Play the classic Flappy Bird game',
            onTap: () {
              Navigator.pushNamed(
                context,
                MyRoutes.gameRoute,
                arguments: {
                  'child': const FlappyBirdApp(),
                  'color': Colors.blue,
                },
              );
            },
          ),
          GameListCardWidget(
            image: Assets.games.dino.image(
              height: 70,
              width: 70,
            ),
            title: 'Dino',
            description: 'Play the classic Dino game',
            onTap: () {
              Navigator.pushNamed(
                context,
                MyRoutes.gameRoute,
                arguments: {
                  'child': const MyDinoApp(),
                  'color': Colors.yellow,
                },
              );
            },
          ),
          const ThickDivider(),
          const SectionHeaderWidget(
            title: AppString.publishedTitle,
            description: '',
          ),
          BlocBuilder<PublisherBloc, PublisherState>(
            builder: (context, state) {
              if (state is PublisherLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AllPublisherLoadedState) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.publishers.length,
                  itemBuilder: (context, index) {
                    final publisher = state.publishers[index];
                    return ListTile(
                      leading: Image.network(
                        publisher.icon!,
                        width: 40,
                        height: 40,
                      ),
                      title: Text(
                        publisher.name!,
                        style: getTitleStyle(context, fontSize: 16),
                      ),
                      subtitle: Text(
                        publisher.domain!,
                        style: getDescriptionStyle(context, fontSize: 12),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MyRoutes.publisherNewsRoute,
                          arguments: {
                            'publisher': publisher,
                          },
                        );
                      },
                    );
                  },
                );
              } else if (state is PublisherErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        LoginRegistrationButton(),
        ThemeButton(),
        SavedArticleWidget(),
        SendFeedbackButton(),
        InviteWidget(),
        LogoutButton(),
      ],
    );
  }
}

class SavedArticleWidget extends StatelessWidget {
  const SavedArticleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(AkarIcons.stack_overflow_fill),
      title: const Text('Saved Articles'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

class InviteWidget extends StatelessWidget {
  const InviteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(AkarIcons.link_chain),
      title: const Text('Invite Friends'),
      onTap: () async {
        await Share.share(
          'check out my website https://example.com',
          subject: 'Look what I made!',
        );
      },
    );
  }
}

class SendFeedbackButton extends StatelessWidget {
  const SendFeedbackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        AkarIcons.airplay_audio,
      ),
      title: const Text(
        'Send Feedback',
      ),
      onTap: () {
        context.read<AuthBloc>().add(SignInWithGoogleEvent());
      },
    );
  }
}

class LoginRegistrationButton extends StatelessWidget {
  const LoginRegistrationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return const SizedBox.shrink();
        } else {
          return ListTile(
            leading: const Icon(
              AkarIcons.person,
            ),
            title: const Text(
              'Sign In',
            ),
            onTap: () {
              context.read<AuthBloc>().add(SignInWithGoogleEvent());
            },
          );
        }
      },
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Column(
            children: [
              ListTile(
                leading: const Icon(
                  AkarIcons.sign_out,
                  color: Colors.redAccent,
                ),
                title: const Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () {
                  context.read<AuthBloc>().add(SignOutEvent());
                },
              ),
            ],
          );
        } else {
          return SizedBox.fromSize();
        }
      },
    );
  }
}
