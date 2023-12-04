import 'package:flutter/material.dart';

typedef IndexedStringBuilder = String Function(int index);

class YearMonthPicker extends StatefulWidget {
  final String title;
  final int itemCount;
  final IndexedStringBuilder itemBuilder;
  final ValueChanged<String> onItemSelected;

  YearMonthPicker({
    required this.title,
    required this.itemCount,
    required this.itemBuilder,
    required this.onItemSelected,
  });

  @override
  _YearMonthPickerState createState() => _YearMonthPickerState();
}

class _YearMonthPickerState extends State<YearMonthPicker> {
  late FixedExtentScrollController controller;
  int selectedItemIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = FixedExtentScrollController(initialItem: selectedItemIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: ListWheelScrollView(
            controller: controller,
            physics: FixedExtentScrollPhysics(),
            //overAndUnderCenterOpacity: 0.3,
            useMagnifier: true,
            magnification: 1.0,
            itemExtent: 50,
            onSelectedItemChanged: (index) {
              setState(() {
                selectedItemIndex = index;
              });
              widget.onItemSelected(widget.itemBuilder(index));
            },
            children: List<Widget>.generate(widget.itemCount, (index) {
              return Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                child:Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: selectedItemIndex == index
                      ? Color.fromRGBO(222, 222, 222, 1)
                      : Colors.transparent,
                ),
                child: Text(
                  widget.itemBuilder(index),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: selectedItemIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
