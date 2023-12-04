import 'package:flutter/material.dart';

class MovieToWebButton extends StatelessWidget {
  const MovieToWebButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: InkWell(
        onTap: () {
          // タップされたときのアクションをここに書きます。
        },
        splashColor: Colors.transparent, // インクスプラッシュを透明にします。
        highlightColor: Colors.transparent, // ハイライト色を透明にします。
        child: const Text(
          '公式サイト',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.underline,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
