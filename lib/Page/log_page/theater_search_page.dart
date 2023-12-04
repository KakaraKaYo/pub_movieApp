import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../components/common/custom_divider.dart';
import '../../db/database_helper.dart';

/*
鑑賞記録路するための最初のページ。（鑑賞情報記録ページに次期編集）
初めて鑑賞した映画と複数回目の記録でWidgetが分岐する
 */

final selectedTheaterProvider = StateProvider<String?>((ref) => null);

class TheaterSearchPage extends ConsumerWidget {
  //final int movieId;
  //TheaterSearchPage({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


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
          title: const Text("映画館選択",style: TextStyle(color: Colors.black,fontSize: 16),),
          //appbarタイトル
          centerTitle: true,
          //次のページに遷移するテキストボタン
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

        body: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10), // パディングの追加
                  color: const Color.fromRGBO(231, 231, 231, 1),
                  child: const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Color.fromRGBO(120, 120, 120, 1)),
                      hintText: '映画館検索',
                      hintStyle: TextStyle(color: Color.fromRGBO(120, 120, 120, 1), fontSize: 16),
                      border: InputBorder.none, // ボーダーを非表示にする
                    ),
                    style: TextStyle(fontSize: 16), // テキストフィールドのテキストスタイル
                    // 他のTextFieldのプロパティをここに追加
                  ),
                )
              ),
              const SizedBox(height: 30),
              const CustomDivider(),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                child:Row(
                children: [
                  Text('履歴',style: TextStyle(fontSize: 16),)
                ],
              ),
              ),
              const SizedBox(height: 20,),
               InkWell(
                onTap: (){
                  ref.read(selectedTheaterProvider.notifier).state = 'TOHOシネマズ立川';
                  context.push('/watch-style');
                },
                 child:const Padding(padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                   child: Row(
                     children: [
                       Text('TOHOシネマズ立川'),
                     ],
                   ),
                 ),
              ),
              InkWell(
                onTap: (){
                  ref.read(selectedTheaterProvider.notifier).state = '立川シネマシティ';
                  context.push('/watch-style');
                },
                child:const Padding(padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Text('立川シネマシティ'),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
    );
  }
}
