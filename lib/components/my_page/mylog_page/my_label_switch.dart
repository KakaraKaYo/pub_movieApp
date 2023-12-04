import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitchRow extends StatefulWidget {
  @override
  _CustomSwitchRowState createState() => _CustomSwitchRowState();
}

class _CustomSwitchRowState extends State<CustomSwitchRow> {
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '文字表示',
              style: TextStyle(fontSize: 16),
            ),
            FlutterSwitch(
              width: 55.0, // width for the switch
              height: 30.0, // height for the switch
              value: _isEnabled,
              borderRadius: 30.0,
              activeColor: const Color.fromRGBO(34, 34, 34, 1),
              onToggle: (val) {
                setState(() {
                  _isEnabled = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
