import 'package:flutter/material.dart';

class YearMonthPicker extends StatefulWidget {
  @override
  _YearMonthPickerState createState() => _YearMonthPickerState();
}

class _YearMonthPickerState extends State<YearMonthPicker> {
  int? selectedYear;
  int? selectedMonth;

  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;

  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;

  @override
  void initState() {
    super.initState();
    yearController = FixedExtentScrollController(initialItem: currentYear - 1895);
    monthController = FixedExtentScrollController(initialItem: currentMonth - 1);
  }

  void onYearChanged(int index) {
    selectedYear = 1895 + index;
    printSelectedDate();
  }

  void onMonthChanged(int index) {
    selectedMonth = 1 + index;
    printSelectedDate();
  }

  void printSelectedDate() {
    if (selectedYear != null && selectedMonth != null) {
      print("Selected: $selectedYear-$selectedMonth");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListWheelScrollView(
                    itemExtent: MediaQuery.of(context).size.height * 0.3 * 0.2,
                    diameterRatio: 20.0,
                    perspective: 0.003,
                    overAndUnderCenterOpacity:  0.3,
                    controller: yearController,
                    onSelectedItemChanged: onYearChanged,
                    children: List.generate(currentYear - 1895 + 1, (index) {
                      return Center(
                          child: Text((1895 + index).toString(),
                          style: const TextStyle(fontSize: 24),));
                    }),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(child: Text('年',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500))),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListWheelScrollView(
                    itemExtent: MediaQuery.of(context).size.height * 0.3 * 0.2,
                    diameterRatio: 20.0,
                    perspective: 0.003,
                    overAndUnderCenterOpacity:  0.3,
                    controller: monthController,
                    onSelectedItemChanged: onMonthChanged,
                    children: List.generate(13, (index) {
                      if(index == 0) {
                        return const Center(
                            child: Text(
                              'ー',
                              style: TextStyle(fontSize: 24),
                            ));
                      } else {
                        return Center(
                            child: Text(
                              index.toString(),
                              style: const TextStyle(fontSize: 24),
                            ));
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(child: Text('月',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),)),
          ),
        ],
      ),
    );
  }
}
