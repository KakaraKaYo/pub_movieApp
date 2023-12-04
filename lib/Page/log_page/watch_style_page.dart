import 'package:dup_movielist/components/common/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../components/log_page/screen_select_cotainer.dart';
import '../../components/log_page/seat_select_container.dart';
import '../../components/log_page/style_select_container.dart';
import '../../components/movie_page/logbutton_container.dart';
import 'theater_search_page.dart';

/*
鑑賞記録路するための最初のページ。（鑑賞情報記録ページに次期編集）
初めて鑑賞した映画と複数回目の記録でWidgetが分岐する
 */

class WatchStylePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheater = ref.watch(selectedTheaterProvider);
    final movieId = ref.watch(movieIdProvider);


    return SafeArea(
      child: Scaffold(
        //以下appbarの設定
        appBar: AppBar(
          backgroundColor: Colors.white,
          //記録取消ボタン
          leading:  IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            color: const Color.fromRGBO(34, 34, 34, 1),
            onPressed: () {
              context.pop();
            },
          ),
          // 選択された映画館の名前をタイトルに表示
          title: Text(selectedTheater ?? "映画館選択", style: TextStyle(color: Colors.black, fontSize: 16)),
          //appbarタイトル
          centerTitle: true,
          //次のページに遷移するテキストボタン
          elevation: 0,

          actions: [
            TextButton(onPressed: (){
              context.go('/log-first/$movieId');
            },
                style: TextButton.styleFrom(
                    primary: Colors.black, // テキストの色
                    splashFactory: NoSplash.splashFactory// エフェクトを削除
                ),
                child:const Text("記録",
                    style: TextStyle(decoration:TextDecoration.underline ,)
                )
            )
          ],
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

        body: Column(
            children: [
              ScreenSelectContainer(),
              const CustomDivider(),
              SeatSelectContainer(),
              const CustomDivider(),
              StyleSelectContainer(),
            ]
        ),
      ),
    );
  }
}
