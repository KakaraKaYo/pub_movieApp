import 'package:flutter/material.dart';
import 'cast_image.dart';

/*
moviedetails_pageで表示させる各キャスト写真リストを構成するcomponent
 */

class CastListView extends StatelessWidget {


  final List<dynamic> casts;
  const CastListView({required this.casts,});

  @override
  Widget build(BuildContext context) {
    print("CAST2:${casts}");

    List<dynamic> actings = [];
    for (int i = 0; i < casts.length; i++) {
      if(casts[i]["known_for_department"] == "Acting"){
        print("${i}番目のキャストの立ち位置： ${casts[i]["known_for_department"]}");
        actings.add(casts[i]);
      }else{
      }
    }

    int displayCount = actings.length > 20 ? 20 : actings.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        const SizedBox(height: 40),
        const Text("キャスト", style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
        const SizedBox(height:5),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 154, // 最小の高さ
            maxHeight: 166, // 最大の高さ
      ),
      //  height: MediaQuery.of(context).size.width*0.25*1.9,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: displayCount,//actings.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: CastImage(casts: actings[index]),
                ),
              ),
    ),
    ]
    );
  }
}
