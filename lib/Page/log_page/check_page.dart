import 'package:dup_movielist/Page/log_page/score_tag_log_page.dart';
import 'package:dup_movielist/Page/log_page/text_review_page.dart';
import 'package:dup_movielist/Page/log_page/theater_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../components/log_page/review_slider.dart';
import '../../components/log_page/calendar.dart';
import '../../components/log_page/screen_select_cotainer.dart';
import '../../components/log_page/seat_select_container.dart';
import '../../components/log_page/time_drumroll.dart';
import '../../components/log_page/watchstyle_container.dart';
import '../../components/movie_page/logbutton_container.dart';
import '../../db/database_helper.dart';



class CheckPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    // sliderValueProviderからスライダーの値を取得
    final sliderValue = ref.watch(sliderValueProvider);
    // selectedDateProviderから選択された日付を取得
    final selectedDate = ref.watch(selectedDateProvider);
    // selectedDateProviderから選択された日付を取得
    final selectedWatchMethod = ref.watch(radioButtonProvider);

    final textReview = ref.watch(textReviewProvider);

    final selectedTheater = ref.watch(selectedTheaterProvider);
    final selectedScreen = ref.watch(selectedScreenProvider);
    final selectedSeat = ref.watch(selectedSeatProvider);
    final selectedChips = ref.watch(selectedChipsProvider);

    int selectedHourIndex = ref.watch(hourPickerProvider.state).state;
    int selectedMinuteIndex = ref.watch(minutePickerProvider.state).state;

    final movieId = ref.watch(movieIdProvider);


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("感想タグ",style: TextStyle(color: Colors.black,fontSize: 16),),
          centerTitle: true,
          leading:  IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            color: Color.fromRGBO(34, 34, 34, 1),
            onPressed: () {
              context.pop();
            },
          ),
          actions: [
            TextButton(
                onPressed:() async {
              // 現在の鑑賞回数を取得
              int currentWatchCount = await DatabaseHelper.instance.getWatchCountByMovieId(movieId!);

              // 新しい鑑賞記録を作成するための情報をMapにセット
              Map<String, dynamic> newRow = {
                DatabaseHelper.watchColumnTheaterId: 1, // 新しい映画館ID
                DatabaseHelper.watchColumnMovieId: movieId,
                DatabaseHelper.watchColumnWatchCount: currentWatchCount + 1, // 鑑賞回数を1増やす
                // ... その他の鑑賞詳細情報 ...
                DatabaseHelper.watchColumnWatchDateAt: DateTime.now().toString(), // ここで現在の日時をセット
                DatabaseHelper.watchColumnUpdatedAt: DateTime.now().toString(),
                DatabaseHelper.watchColumnCreatedAt: DateTime.now().toString(),
                DatabaseHelper.watchColumnVersionNo: 1,
                DatabaseHelper.watchColumnIsDeleted: 0,
              };


              Map<String, dynamic> newReview = {
                DatabaseHelper.columnMovieId: movieId,
                DatabaseHelper.columnScore: sliderValue, // スライダーの値をここで使用
                DatabaseHelper.columnText: textReview,
                // ... 他のレビュー詳細 ...
                DatabaseHelper.columnUpdatedAt: DateTime.now().toString(),
                DatabaseHelper.columnCreatedAt: DateTime.now().toString(),
                DatabaseHelper.columnVersionNo: 1,
                DatabaseHelper.columnIsDeleted: 0,
              };
              int? newReviewId = await DatabaseHelper.instance.insertReview(newReview);
              if (newReviewId != null) {
                print('新しいレビューが追加されました。ID: $newReviewId');


                // selectedChipsの各タグについて処理
                for (var chipText in selectedChips) {
                  // タグの名前からタグIDを取得
                  int? tagId = await DatabaseHelper.instance.getTagIdByName(chipText);
                  print('デバッグ: タグ "$chipText" のID = $tagId'); // タグIDのデバッグ出力

                  if (tagId != null) {
                    // レビューとタグの関連をreview_tagsテーブルに保存
                    await DatabaseHelper.instance.insertReviewTag(newReviewId, tagId);
                    print('デバッグ: レビューID $newReviewId にタグID $tagId を関連付けました'); // 保存のデバッグ出力
                  } else {
                    print('デバッグ: タグ "$chipText" は見つかりませんでした'); // タグが見つからない場合のデバッグ出力
                  }
                }


                // 新しい鑑賞記録を作成するための情報をMapにセット
                Map<String, dynamic> newRow = {
                  DatabaseHelper.watchColumnTheaterId: 1, // 新しい映画館ID
                  DatabaseHelper.watchColumnMovieId: movieId,
                  //DatabaseHelper.watchColumnWatchCount: currentWatchCount + 1, // 鑑賞回数を1増やす
                  DatabaseHelper.watchColumnMethod: selectedWatchMethod, // selectedMethod に選択された鑑賞方法をセット
                  DatabaseHelper.watchColumnWatchDateAt: selectedDate != null ? DateFormat('yyyy/MM/dd').format(selectedDate) : DateTime.now().toString(), // ここで選択された日付または現在の日時をセット
                  DatabaseHelper.watchColumnStartedAt: selectedHourIndex != -1 && selectedMinuteIndex != -1 ? '$selectedHourIndex:${(selectedMinuteIndex * 5).toString().padLeft(2, '0')}' : null, // 時間のフォーマットに合わせてセット
                  DatabaseHelper.watchColumnScreenTime: null, // 選択された場合はセット
                  DatabaseHelper.watchColumnScreenNumber: selectedScreen ?? null, // 選択された場合はセット
                  DatabaseHelper.watchColumnSeatNumber: selectedSeat ?? null, // 選択された場合はセット
                  DatabaseHelper.watchColumnTicketPrice: null, // 選択された場合はセット
                  //DatabaseHelper.watchColumnWatchType: selectedWatchMethod == '劇場' ? 1 : 2, // '劇場' なら1、それ以外なら2としてセット
                  DatabaseHelper.watchColumnUpdatedAt: DateTime.now().toString(),
                  DatabaseHelper.watchColumnCreatedAt: DateTime.now().toString(),
                  DatabaseHelper.watchColumnVersionNo: 1,
                  DatabaseHelper.watchColumnIsDeleted: 0,
                };

                // データベースに新しい鑑賞記録を挿入
                int? newRowId = await DatabaseHelper.instance.insertWatch(newRow);
                if (newRowId != null) {
                  print('新しい鑑賞記録が追加されました。ID: $newRowId');
                } else {
                  print('鑑賞記録の追加に失敗しました。');
                }

              } else {
                print('レビューの追加に失敗しました。');
              }




              // SnackBar を表示
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Watchedに追加したよ。"),
                    duration: Duration(seconds: 2),  // 表示する時間
                  ),
                );
            context.go('/movie-details/$movieId');
            },

              style: TextButton.styleFrom(
                  primary: Colors.black, // テキストの色
                  splashFactory: NoSplash.splashFactory// エフェクトを削除
              ),
              child:const Text("記録",
                style: TextStyle(decoration:TextDecoration.underline ,)
              )
          ),
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
        body:Container(
          child: Column(
            children: [
              Text(
                sliderValue == -0.1 ? 'レビュー評価: 未評価' : 'レビュー評価: ${sliderValue.toStringAsFixed(1)}', // 条件に応じて表示を変更
                style: const TextStyle(
                  fontSize: 24, // フォントサイズを設定
                  fontWeight: FontWeight.bold, // フォントウェイトを設定
                ),
              ),
              Text(
                '鑑賞日: ${selectedDate != null ? DateFormat('yyyy/MM/dd').format(selectedDate) : '未選択'}',
                style: const TextStyle(
                  fontSize: 24, // フォントサイズを設定
                  fontWeight: FontWeight.bold, // フォントウェイトを設定
                ),
              ),
              selectedHourIndex != -1 && selectedMinuteIndex != -1
                  ? Text(
                '開始時間: $selectedHourIndex:${(selectedMinuteIndex * 5).toString().padLeft(2, '0')}~',
                style: const TextStyle(
                  fontSize: 24, // フォントサイズを設定
                  fontWeight: FontWeight.bold, // フォントウェイトを設定
                ),
              ) : SizedBox.shrink(), // 条件を満たさない場合は何も表示しない
              Text(
                '鑑賞方法: $selectedWatchMethod', // 小数点以下1桁で表示
                style: const TextStyle(
                  fontSize: 24, // フォントサイズを設定
                  fontWeight: FontWeight.bold, // フォントウェイトを設定
                ),
              ),
              Text(
                (selectedTheater != null || selectedScreen != null || selectedSeat != null)
                    ? '${selectedTheater ?? ""}${selectedScreen != null ? "｜$selectedScreen" : ""}${selectedSeat != null ? "｜$selectedSeat" : ""}｜IMAX2D'
                    : '詳細情報',
                style: const TextStyle(
                    fontSize: 24,
                  fontWeight: FontWeight.bold, // フォントウェイトを設定
                ),
              ),

              Wrap(
                spacing: 8.0, // チップ間の水平スペース
                runSpacing: 4.0, // チップ間の垂直スペース
                children: selectedChips.map((chipText) {
                  return Chip( // return を追加
                    label: Text(chipText),
                    backgroundColor: Colors.lightBlueAccent, // チップの背景色
                    labelStyle: const TextStyle(color: Colors.white), // テキストの色
                    padding: const EdgeInsets.all(8.0), // チップ内のパディング
                  );
                }).toList(),
              ),


              const SizedBox(height: 40),
              Text(
                'コメント: $textReview', // 小数点以下1桁で表示
                style: const TextStyle(
                  fontSize: 24, // フォントサイズを設定
                  fontWeight: FontWeight.bold, // フォントウェイトを設定
                ),
              ),
            ],
          ),
        ),

    );
  }
}
