import 'package:dup_movielist/Page/movie_page/popular_page.dart';
import 'package:dup_movielist/Page/movie_page/playing_page.dart';
import 'package:dup_movielist/Page/movie_page/rated_page.dart';
import 'package:dup_movielist/Page/movie_page/upcoming_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              const SliverAppBar(
                title: Text(
                  'ScreenMe',
                  style: TextStyle(color: Colors.black87, fontFamily: 'Marcellus'),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                floating: true, // 修正：floatingをfalseに設定
                pinned: true,
                snap: false, // 修正：snapをfalseに設定
                bottom: TabBar(
                  tabs: [
                    Tab(text: 'Poplar'),
                    Tab(text: 'No Playing'),
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Rated'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              PopularPage(),
              PlayingPage(),
              UpcomingPage(),
              RatedPage(),
            ],
          ),
        ),
      ),
    );
  }
}