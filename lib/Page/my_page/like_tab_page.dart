import 'package:flutter/material.dart';


/*
my_pageのtabの一つ。お気に入りの役者や監督等を確認できるpage
 */
class LikeTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('kano yoshitaka'),
      backgroundColor: Colors.white,
      shape: StadiumBorder(side: BorderSide(color: Color.fromRGBO(22, 22, 22, 1), width: 1)),
      onDeleted: () {
      },
    );
  }
}
