import 'package:dup_movielist/components/log_page/watched_day_container.dart';
import 'package:dup_movielist/components/log_page/watchstyle_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../components/common/custom_divider.dart';
import '../../components/movie_page/logbutton_container.dart';
import '../movie_page/moviedetails_page.dart';

/*
鑑賞記録路するための最初のページ。（鑑賞情報記録ページに次期編集）
初めて鑑賞した映画と複数回目の記録でWidgetが分岐する
 */

class DateStyleLogPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final movieId = ref.watch(movieIdProvider);

    // watchCountProviderを使って鑑賞回数を非同期で取得
    final watchCountFuture = ref.watch(watchCountProvider(movieId!));



    return SafeArea(
      child: Scaffold(
          //以下appbarの設定
        appBar: AppBar(
          backgroundColor: Colors.white,
            //記録取消ボタン
            leading: TextButton(
              onPressed: () {
                context.pop();
              },
              style: TextButton.styleFrom(
                primary: Colors.black,
                splashFactory: NoSplash.splashFactory,
              ),
              child: const Text(
                '取消',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),


            //appbarタイトル
            title: const Text("鑑賞情報", style: TextStyle(color: Colors.black, fontSize: 16)),
            centerTitle: true,


            //次のページに遷移するテキストボタン
            //初めて鑑賞した映画と複数回目の記録でWidgetが分岐
          actions: [
            FutureBuilder<int>(
              future: fetchWatchCount(movieId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(); // ローディング中は何も表示しない
                } else if (snapshot.hasData) {
                  final watchCount = snapshot.data ?? 0;

                  if (watchCount == 0) {
                    // 初回鑑賞の場合の遷移先
                    return TextButton(
                      onPressed: () => context.push('/review-log'),
                      // ボタンのスタイル...
                      child: const Text("次へ"),
                    );
                  } else {
                    // 複数回鑑賞の場合の遷移先
                    return TextButton(
                      onPressed: () => context.push('/check-page'),
                      // ボタンのスタイル...
                      child: const Text("次へ"),
                    );
                  }
                } else {
                  return Container(); // データがない場合は何も表示しない
                }
              },
            ),
          ],
            elevation: 0,
            //appbarの下線
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: Divider(
                height: 1.0,
                thickness: 1.0,
                color: Color.fromRGBO(210, 210, 210, 1),
              ),
            ),
          ),
          //appbar終わり

          body: watchCountFuture.when(
            data: (watchCount) {
              if (watchCount == 0) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        WatchedDayContainer(),
                        const CustomDivider(),
                        WatchStyleContainer(),
                      ],
                    ),
                  ),
                );
              } else {
                return SafeArea(
                    child: SingleChildScrollView(
                  child:Column(
                  children: [

                    Row(children: [Text('鑑賞回数：$watchCount')]),
                    WatchedDayContainer(),
                    const CustomDivider(),
                    WatchStyleContainer(),

                  ],
              ),
                    ),
        );
      }
    },
            loading: () => CircularProgressIndicator(),
            error: (e, _) => Text('エラー: $e'),
          ),
      ),
    );
  }
}