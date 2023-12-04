import 'package:dup_movielist/components/movie_page/staff_image.dart';
import 'package:flutter/material.dart';

/*
moviedetails_pageで表示させる各キャスト写真リストを構成するcomponent
 */
class StaffListView extends StatelessWidget {
  final List<dynamic> crews;
  const StaffListView({required this.crews});

  @override
  Widget build(BuildContext context) {
    Set<int> processedIds = {}; // 既に処理されたIDを追跡するセット
    List<dynamic> uniqueStaffs = []; // 重複しないスタッフのリスト

    // まずdirectorをリストに追加
    for (var crew in crews) {
      if (crew["job"] == "Director") {
        uniqueStaffs.add(crew);
        processedIds.add(crew["id"]);
      }
    }

    // 次に他のスタッフを追加
    for (var crew in crews) {
      if (crew["job"] != "Director" && !processedIds.contains(crew["id"])) {
        uniqueStaffs.add(crew);
        processedIds.add(crew["id"]);
      }
    }

    int displayCount = uniqueStaffs.length > 20 ? 20 : uniqueStaffs.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        const SizedBox(height: 40),
        const Text("スタッフ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
        const SizedBox(height:5),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 154,
            maxHeight: 166,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayCount,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: StaffImage(crews: uniqueStaffs[index]),
            ),
          ),
        ),
      ],
    );
  }
}
