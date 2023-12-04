import 'package:flutter/material.dart';

/*
カスタム用の横線
 */

class CustomDivider extends StatelessWidget {
  final double indent;
  final double endIndent;

  const CustomDivider({this.indent = 0, this.endIndent = 0, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0,
      thickness: 1,
      indent: indent, // 外部から指定されたインデントを使用
      endIndent: endIndent, // 外部から指定されたエンドインデントを使用
      color: const Color.fromRGBO(210, 210, 210, 1),
    );
  }
}
