import 'package:flutter/material.dart';
import '../../components/search_page/search_appbar.dart';


class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: Scaffold(
        appBar: SearchAppbar(),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4// グリッドの列数を指定
          ),
          itemBuilder: (BuildContext context, int index) {
            // グリッドの各アイテムをここで作成
            return GridTile(
              child: Container(
                color: Colors.tealAccent,
                child: Center(
                  child: Text(
                    'Item $index',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
