import 'package:flutter/material.dart';


class TitleContainer extends StatelessWidget{
  final String title;
  final String origin_title;

  const TitleContainer({required this.title, required this.origin_title});

  @override
  Widget build(BuildContext context) {
    return Column(
        children:[
          const SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
                children:[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title, //公開年数を別ウィジェットで置きたいができていない
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                    overflow: TextOverflow.visible,
                    maxLines: 2, // Added maxLines
                    softWrap: true,
                  ),
                ),
              ],
            ),
             SizedBox(height: 5),
            Row(
                children:[
                  Text(origin_title, style: TextStyle(fontSize: 10,),
                  ),
                ]
            ),
          ]
      ),
          ),
          const SizedBox(height: 5),
        ]
    );
  }
}