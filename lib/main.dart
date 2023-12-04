import 'package:dup_movielist/Page/log_page/check_page.dart';
import 'package:dup_movielist/Page/movie_page/moviedetails_page.dart';
import 'package:dup_movielist/Page/my_page/mylog_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Page/TitlePage.dart';
import 'Page/log_page/date_style_log_page.dart';
import 'Page/log_page/score_tag_log_page.dart';
import 'Page/log_page/text_review_page.dart';
import 'Page/log_page/theater_search_page.dart';
import 'Page/log_page/watch_style_page.dart';
import 'Page/movie_page/popular_page.dart';
import 'Page/my_page/my_page.dart';
import 'Page/search_page/search_page.dart';
import 'Page/movie_page/playing_page.dart';
import 'Page/movie_page/movie_page.dart';
import 'Page/movie_page/upcoming_page.dart';
import 'Page/movie_page/rated_page.dart';
import 'Page/movie_page/popular_page.dart';
import 'Page/search_page/searching_page.dart';
import 'components/common/bottombar.dart';
import 'components/common/statusbar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



void main() {
  runApp(ProviderScope(child: MyApp()));
}

final currentIndexProvider = StateProvider<int>((ref) => 0);

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => NavigationHolder(),
          routes: [
            GoRoute(
              path: 'movie',
              builder: (context, state) => PopularPage(),
            ),
            GoRoute(
              path: 'test2',
              builder: (context, state) => PlayingPage(),
            ),
            GoRoute(
              path: 'test3',
              builder: (context, state) => UpcomingPage(),
            ),
            GoRoute(
              path: 'test4',
              builder: (context, state) => RatedPage(),
            ),
            GoRoute(
              path: 'movie-details/:movieId', // パスパラメータを使用
              builder: (context, state) {
                // パスパラメータからmovieIdを抽出
                final movieId = state.pathParameters['movieId']!;
                // MovieDetailsPageに渡す前に整数に変換
                return MovieDetailsPage(movieId: int.parse(movieId));
              },
            ),
            GoRoute(
              path: 'log-first/:movieId', // パスパラメータを使用
              builder: (context, state) => DateStyleLogPage(),
            ),
            GoRoute(
              path: 'review-log',
              builder: (context, state) => ScoreTagLogPage(),
            ),
            GoRoute(
              path: 'check-page',
              builder: (context, state) => CheckPage(),
            ),


            GoRoute(
              path: 'movie-log',
              builder: (context, state) => DateStyleLogPage(),
            ),
            GoRoute(
              path: 'my-page',
              builder: (context, state) => MyPage(),
            ),


            GoRoute(
              path: 'mylog/:movieId', // パスパラメータを使用
              builder: (context, state) {
                // パスパラメータからmovieIdを抽出
                final movieId = state.pathParameters['movieId']!;
                // MovieDetailsPageに渡す前に整数に変換
                return MyLogPage(movieId: int.parse(movieId));
              },
            ),


            GoRoute(
              path: 'searching',
              builder: (context, state) => SearchingPage(),
            ),
            GoRoute(
              path: 'theater-searching', // パスパラメータを含むように修正
              builder: (context, state) => TheaterSearchPage(),
            ),
            GoRoute(
              path: 'watch-style',
              builder: (context, state) => WatchStylePage(),
            ),
            GoRoute(
              path: 'text-review',
              builder: (context, state) => TextReviewPage(),
            ),

          ],
        ),
      ],
    );

    return CustomStatusBar(
        child: MaterialApp.router(
          title: 'Screen Me',
          theme: ThemeData(
          primarySwatch: Colors.grey,
          hintColor: Colors.amber,
          canvasColor: Colors.white, // アプリ全体の背景色
          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('ja', ''), // 日本語をサポート
          ],
          routeInformationProvider: goRouter.routeInformationProvider,
          routeInformationParser: goRouter.routeInformationParser,
          routerDelegate: goRouter.routerDelegate,
        ),

    );
  }
}

class NavigationHolder extends ConsumerWidget {
  NavigationHolder({Key? key}) : super(key: key);
  final pages = [
    MoviePage(),
    //TitlePage(),
    SearchPage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(currentIndexProvider.state).state = index;
        },
      ),
    );
  }
}
