import 'package:flutter/material.dart';
import '../../components/my_page/mylog_page/watchedlist.dart';
import '../../components/my_page/mylog_page/TextTitle.dart';

/*
my_pageのtabの一つ。鑑賞ずみの映画作品を確認できるpage
 */

class WatchedTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(mainAxisAlignment: MainAxisAlignment.start, children:[const TextTitle(title: '2023.7'),]),
            const SizedBox(height: 10),
            WatchedList(),
          ],
        ),
      ),
    );
  }

}
