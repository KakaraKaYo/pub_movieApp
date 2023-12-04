import 'package:flutter/material.dart';
import 'DateScrollSheet.dart';

class FilterDateSwitchRow extends StatefulWidget {
  @override
  _FilterDateSwitchRowState createState() => _FilterDateSwitchRowState();
}

class _FilterDateSwitchRowState extends State<FilterDateSwitchRow> {
  bool _isSwitched = false;
  DateTime? _selectedDate;  // 選択された日付を保存する変数

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  '鑑賞年月で絞り込み',
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
                  activeColor: const Color.fromRGBO(141, 144, 208, 1.0),
                  activeTrackColor:const Color.fromRGBO(141, 144, 208, 1.0),
                ),
              )
            ],
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
          indent: 20,
          endIndent: 20,
          color: Colors.black,
        ),

        if (_isSwitched) // この条件式で、_isSwitchedがtrueのときのみコンテナを表示
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
            child: YearMonthPicker(),
          ),
      ],
    );
  }
}
