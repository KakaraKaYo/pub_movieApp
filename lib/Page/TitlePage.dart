import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../components/my_page/mylog_page/DateScrollSheet.dart';
import '../components/my_page/mylog_page/wantlist.dart';

class TitlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ここに背面のコンテンツを配置
          SingleChildScrollView(
            child: Column(
              children: [
                // 他のコンテンツ
                WantList(),
                // ...他のウィジェット...
              ],
            ),
          ),

          // ガラスコンテナを最前面に配置
          Align(
            alignment: Alignment.center,
            child: GlassmorphicContainer(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              borderRadius: 20,
              blur: 20,
              alignment: Alignment.bottomCenter,
              border: 2,
              linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFffffff).withOpacity(0.1),
                    Color(0xFF5E2727).withOpacity(0.05),
                  ],
                  stops: [
                    0.1,
                    1,
                  ]),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFffffff).withOpacity(0.5),
                  Color((0xFFFFFFFF)).withOpacity(0.5),
                ],
              ),
              child: Center(
                child: Text("ガラスコンテナ内のコンテンツ"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
