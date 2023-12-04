import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// テキスト内容を保持するプロバイダー
final textReviewProvider = StateProvider<String>((ref) => '');

class TextReviewPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = TextEditingController(text: ref.watch(textReviewProvider));


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("コメント",style: TextStyle(color: Colors.black,fontSize: 16),),
        centerTitle: true,
        leading:  IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          color: Color.fromRGBO(34, 34, 34, 1),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [

          TextButton(onPressed:(){
            context.push('/check-page');
          },
              style: TextButton.styleFrom(
                  primary: Colors.black, // テキストの色
                  splashFactory: NoSplash.splashFactory// エフェクトを削除
              ),
              child:const Text("次へ",
                style: TextStyle(
                  decoration:TextDecoration.underline ,
                ),))
        ],
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0), // 線の高さを設定
          child: Divider(
            height: 1.0,
            thickness: 1.0,
            color: Color.fromRGBO(210, 210, 210, 1), // 線の色を設定
          ),
        ),
      ),

      body: Column(
          children:[
            Padding(
              padding: EdgeInsets.all(16.0), // テキストフィールドの周りの余白
              child: TextField(
                controller: textEditingController, // TextEditingControllerを割り当てる
                maxLines: null, // マルチラインを許可
                keyboardType: TextInputType.multiline, // キーボードタイプをマルチラインに
                decoration: InputDecoration(
                  hintText: textEditingController.text.isEmpty ? 'これが俺の感想だああ！！' : null,
                  border: OutlineInputBorder( // 境界線
                    borderRadius: BorderRadius.circular(8.0), // 境界線の角の丸み
                  ),
                ),
                onChanged: (value) {
                  // 入力されたテキストをプロバイダーに保存
                  ref.read(textReviewProvider.notifier).state = value;
                  },
              ),

            ),
            Text(ref.watch(textReviewProvider)), // プロバイダーの値を表示
          ]
      ),
    );
  }
}
