import 'package:flutter/material.dart';

class FilterMovieSwitchRow extends StatefulWidget {
  @override
  _FilterMovieSwitchRowState createState() => _FilterMovieSwitchRowState();
}

class _FilterMovieSwitchRowState extends State<FilterMovieSwitchRow> {
  bool _isSwitched = false;  // スイッチの状態を保持する変数を定義

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
    Padding(
    padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
       child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Expanded(  // このウィジェットでTextをラップして、オーバーフローを防ぎます
              child: Text(
                '映画館で鑑賞した作品のみ表示',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Transform.scale(
              scale: 1.3,
              child: Switch(
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
                activeColor: Color.fromRGBO(141, 144, 208, 1.0),
                activeTrackColor:Color.fromRGBO(141, 144, 208, 1.0),
              ),
            )

          ],
        ),),
        const Divider(
          height: 0,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          color: Colors.black,
        ),
      ],
    );
  }
}
