import 'package:flutter/material.dart';


class CustomCheckbox extends StatefulWidget {

  final String watchWay;

  CustomCheckbox({required this.watchWay});
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(5),
            color: _isChecked ?  Colors.white: Color.fromRGBO(34, 34, 34, 1),
          border: Border.all(
            color: _isChecked ? Color.fromRGBO(168, 168, 168, 1) : Color.fromRGBO(168, 168, 168, 0),
            width: 1,),),
        child:Padding(
          padding:EdgeInsetsDirectional.fromSTEB(43, 5, 43, 7),
          child:Center(
          child:Text(
            widget.watchWay,
            style: TextStyle(
              fontSize: 16,
              color: _isChecked ? const Color.fromRGBO(22, 22, 22, 1) : Colors.white),
            ),
          ),
          ),
        ),
    );
  }
}
