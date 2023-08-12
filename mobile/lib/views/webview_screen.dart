import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/news/models/news_model.dart';
import 'package:mobile/features/reader_mode/cubit/reader_mode_cubit.dart';
import 'package:mobile/utils/routes_manager.dart';
import 'package:mobile/utils/utils.dart';
import 'package:mobile/views/reader_mode_screen.dart';
import 'package:mobile/widgets/button.dart';
import 'package:mobile/widgets/theme_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> _launchUrl({required String url}) async {
  final url0 = Uri.parse(url);
  if (!await launchUrl(url0)) {
    throw Exception('Could not launch $url0');
  }
}

class MyWebViewScreen extends StatefulWidget {
  const MyWebViewScreen({
    required this.news,
    super.key,
  });

  final NewsModel news;

  @override
  State<MyWebViewScreen> createState() => _MyWebViewScreenState();
}

class _MyWebViewScreenState extends State<MyWebViewScreen> {
  late final WebViewController controller;
  int loadingPercentage = 100;

  // font size
  double fontSizeFactor = 0;

  @override
  void initState() {
    super.initState();
    webViewInit();
  }

  Future<void> webViewInit() async {
    // Webview Controller
    controller = WebViewController();
    await controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ),
    );
    await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    await controller.loadRequest(
      Uri.parse(widget.news.source!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BookmarkButton(newsModel: widget.news, iconOnly: true),
          IconButton(
            onPressed: () {
              showModalBottomSheet<dynamic>(
                context: context,
                useSafeArea: true,
                builder: (context) => moreBottomSheet(
                  context,
                  news: widget.news,
                ),
              );
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: BlocBuilder<ReaderModeCubit, ReaderModeState>(
        builder: (context, state) {
          if (state is ReaderModeChangeState) {
            if (state.readerMode) {
              return ReaderModeScreen(
                news: widget.news,
                fontSizeFactor: fontSizeFactor,
              );
            }
            return loadingPercentage < 90
                ? LinearProgressIndicator(
                    value: loadingPercentage / 100,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  )
                : WebViewWidget(controller: controller);
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder<ReaderModeCubit, ReaderModeState>(
              builder: (context, state) {
                if (state is ReaderModeChangeState) {
                  return IconButton(
                    icon: state.readerMode
                        ? const Icon(CupertinoIcons.book_fill)
                        : const Icon(AkarIcons.book_open),
                    tooltip: 'Reader Mode',
                    onPressed: () {
                      context.read<ReaderModeCubit>().changeReaderMode(
                            readerMode: !state.readerMode,
                          );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            IconButton(
              icon: const Icon(AkarIcons.link_chain),
              tooltip: 'Copy Link',
              onPressed: () async {
                await copyToClipboard(context, text: widget.news.source!);
              },
            ),
            IconButton(
              icon: const Icon(AkarIcons.share_box),
              tooltip: 'Open in Browser',
              onPressed: () async => _launchUrl(url: widget.news.source!),
            ),
            IconButton(
              icon: const Icon(AkarIcons.image),
              tooltip: 'Share Image',
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  MyRoutes.shareNewsImageRoute,
                  arguments: {
                    'news': widget.news,
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget moreBottomSheet(BuildContext context, {required NewsModel news}) {
    return ListView(
      shrinkWrap: true,
      children: [
        BookmarkButton(newsModel: news),
        ListTile(
          leading: const Icon(AkarIcons.network),
          title: const Text('Share'),
          onTap: () async {
            await shareNews(news: news)
                .whenComplete(() => Navigator.pop(context));
          },
        ),
        ListTile(
          leading: const Icon(AkarIcons.link_chain),
          title: const Text('Copy Link'),
          onTap: () async {
            await copyToClipboard(context, text: news.source!)
                .whenComplete(() => Navigator.pop(context));
          },
        ),
        const ThemeButton(),
        ListTile(
          leading: const Icon(Icons.text_increase),
          title: const Text('Increase Font Size'),
          onTap: () async {
            setState(() {
              fontSizeFactor += 0.5;
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.text_decrease),
          title: const Text('Decrease Font Size'),
          onTap: () async {
            setState(() {
              fontSizeFactor -= 0.5;
            });
          },
        ),
        ListTile(
          leading: const Icon(AkarIcons.share_box),
          title: const Text('Open in Browser'),
          onTap: () async {
            await _launchUrl(url: news.source!)
                .whenComplete(() => Navigator.pop(context));
          },
        ),
      ],
    );
  }
}
