import 'package:dup_movielist/components/my_page/mylog_page/sort_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:dup_movielist/components/my_page/mylog_page/my_label_switch.dart';
import 'drumroll_calender.dart';
import 'cutomcheckbox.dart';


/*
my_pageのFABを構成するcomponent
 */

class SearchData extends ChangeNotifier {


  String sortType = '記録日時が新しい順'; // 並び替え 1->昇順, 2->降順
  String searchValue = ''; // 検索用キーワード
  bool onlyMovie = false; // 映画のみの絞り込み
  String targetYear = ''; // 検索対象年
}


class FlowButton extends StatelessWidget {
  String selectedSortType = '1'; // デフォルトは '1' または適切なデフォルト値に設定

  @override
  Widget build(BuildContext context) {
    final searchData = Provider.of<SearchData>(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double padding = 20.0;
    double desiredWidth = screenWidth - (2 * padding);

    return Container(
      //FABの位置と大きさの設定
      margin: EdgeInsets.only(bottom: 10.0),
      height: 65,
      width: 65,
      child: FloatingActionButton(
        onPressed: () {

          /*
          以下、FABタップ後のmodalsheet
           */

          showModalBottomSheet(
            backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (BuildContext context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 50, 15, 0),
                  child: SingleChildScrollView( //modalbottomsheet内でのスクロールが可能
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //↓並び順設定用Widget
                        const Text("並び順", style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 10),
                        SortDropdown(
                          desiredWidth: desiredWidth,
                          onSortChanged: (String newSortType) {
                            // 選択された並び替えタイプを更新
                            selectedSortType = newSortType;
                          },
                        ),
                        //↑並び順設定用Widget

                        const SizedBox(height: 20),

                        //↓鑑賞年月絞り込み設定用Widget
                        const Text("鑑賞年月",style: TextStyle(fontSize: 12),),
                        const SizedBox(height:10),
                        DrumrollCalender(desiredWidth: desiredWidth,),
                        //↑鑑賞年月絞り込み設定用Widget


                        const SizedBox(height: 20),

                        //鑑賞方法絞り込み設定用Widget
                        const Text("鑑賞方法",style: TextStyle(fontSize: 12),),
                        const SizedBox(height:10),
                        Row(
                          children: [
                            CustomCheckbox(watchWay: '映画館',),
                            SizedBox(width: 5,),
                            CustomCheckbox(watchWay: '動画配信サービス',),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            CustomCheckbox(watchWay: 'DVD/Blu-ray',),
                            const SizedBox(width: 5,),
                            CustomCheckbox(watchWay: 'その他',),
                          ],
                        ),
                        //鑑賞方法絞り込み設定用Widget終わり


                        const SizedBox(height: 20),

                        //↓表示形式設定用Widget
                        const Text("表示形式",style: TextStyle(fontSize: 12),),
                        const SizedBox(height:10),
                        CustomSwitchRow(),
                        //↑表示形式設定用Widget

                        const SizedBox(height: 40,),



                        // 適用ボタン構成Widget
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                height: 50,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.white,
                                    side: BorderSide(width: 0, color: Colors.transparent),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                    backgroundColor: Color.fromRGBO(217, 217, 217, 1.0),
                                  ),
                                  onPressed: () {
                                    // 削除ボタンの処理
                                  },
                                  child: const Icon(Icons.delete_outline, color: Colors.black, size: 30),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 7,
                              child: SizedBox(
                                height: 50,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.white,
                                    side: const BorderSide(width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                    backgroundColor: const Color.fromRGBO(22, 22, 22, 1.0),
                                  ),
                                  onPressed: () async {
                                    context.pop('/my-page');
                                    print(selectedSortType+"に並び替えました");
                                    searchData.sortType = selectedSortType; // キャプチャされた並び替えタイプを使用
                                    searchData.notifyListeners();
                                  },
                                  child: const Text('適用'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //適用ボタンWidget終わり

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromRGBO(22, 22, 22, 1),
        child: const Icon(Icons.more_horiz_outlined, size: 40),
      ),
    );
  }
}
