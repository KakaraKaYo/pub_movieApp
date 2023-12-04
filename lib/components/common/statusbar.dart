import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


/*
status barの設定
 */
class CustomStatusBar extends StatelessWidget {
  final Widget child;

  const CustomStatusBar({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark, // アイコンの色 (darkは黒、lightは白)
    ));

    return child;
  }
}
