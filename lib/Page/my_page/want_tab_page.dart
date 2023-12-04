import 'package:flutter/material.dart';
import '../../components/my_page/mylog_page/wantlist.dart';

/*
my_pageのtabの一つ。気になる、見たい映画作品を確認できるpage
*/


class WantTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              WantList(),
            ],
          ),
        ),
    );
  }
}
