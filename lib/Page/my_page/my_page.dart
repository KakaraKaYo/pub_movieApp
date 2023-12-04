import 'package:dup_movielist/Page/my_page/want_tab_page.dart';
import 'package:dup_movielist/Page/my_page/watched_tab_page.dart';
import 'package:dup_movielist/components/my_page/mylog_page/flow_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../db/database_helper.dart';
import 'like_tab_page.dart';

/*
my_pageを構成するpage
 */


//3つのtab名を以下で示す
List<String> titles = <String>[
  'Watched',
  'Want',
  'Like',
];

class MyPage extends StatelessWidget {

  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchData()),
      ],
      child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  static Future<List<Map<String, dynamic>>> _loadWatchRecords() async {
    var existingWatch = await DatabaseHelper.instance.getWatch();
    print('鑑賞レコード数： ${existingWatch?.length}');
    return existingWatch ?? [];
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,


        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: false,
                floating: false,
                snap: false,
                backgroundColor: Colors.white,
                leading: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    const Icon(Icons.account_circle, size: 35,
                      color: Color.fromRGBO(22, 22, 22, 1),),
                  ],
                ),
                title: const Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Text('your name', textAlign: TextAlign.center,
                    style: TextStyle(color: Color.fromRGBO(22, 22, 22, 1)),),
                ),
               // bottom:null,
              ),
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: false, // タブバーを上部に固定
                floating: true, // スクロール時にタブバーが浮かび上がらないように
                snap: true, // スクロール停止時にタブバーがスナップしないように
                primary: true, // AppBarが画面の上部に表示されるように
                toolbarHeight: 0, // ツールバーの高さを0に設定して余白をなくす
                bottom: TabBar(
                  labelColor: const Color.fromRGBO(22, 22, 22, 1),
                  indicatorColor: const Color.fromRGBO(22, 22, 22, 1),
                  tabs: [
                    Tab(icon: const Icon(Icons.visibility_outlined, color: Color.fromRGBO(22, 22, 22, 1),), text: titles[0]),
                    Tab(icon: const Icon(Icons.bookmarks_outlined, color: Color.fromRGBO(22, 22, 22, 1),), text: titles[1]),
                    Tab(icon: const Icon(Icons.favorite_border, color: Color.fromRGBO(22, 22, 22, 1),), text: titles[2]),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              WatchedTabPage(),
              WantTabPage(),
              LikeTabPage(),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            final TabController tabController = DefaultTabController.of(context)!;
            return AnimatedBuilder(
              animation: tabController,
              builder: (BuildContext context, Widget? child) {
                if (tabController.index == 0) {
                  return FlowButton();
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }
}