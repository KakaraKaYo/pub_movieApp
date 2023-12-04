import 'package:flutter/material.dart';

class MovieToScreenButton extends StatelessWidget {
  const MovieToScreenButton({super.key});

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
          '劇場検索',
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
