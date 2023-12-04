import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hourPickerProvider = StateProvider<int>((ref) => -1);
final minutePickerProvider = StateProvider<int>((ref) => -1);

typedef IndexedStringBuilder = String Function(int index);

class TimeDrumroll extends ConsumerWidget {
  final String title;
  final ValueChanged<String> onHourSelected;
  final ValueChanged<String> onMinuteSelected;

  TimeDrumroll({required this.title, required this.onHourSelected, required this.onMinuteSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 時間の項目数
    int itemHourCount = 24;
    // 分の項目数
    int itemMinuteCount = 12;

    // 時間と分の選択されたインデックス
    int selectedHourIndex = ref.watch(hourPickerProvider.state).state;
    int selectedMinuteIndex = ref.watch(minutePickerProvider.state).state;

    // 時間と分のコントローラ
    FixedExtentScrollController hourController = FixedExtentScrollController(
      initialItem: selectedHourIndex,
    );
    FixedExtentScrollController minuteController = FixedExtentScrollController(
      initialItem: selectedMinuteIndex,
    );

    // 時間をビルドする関数
    String hourBuilder(int index) {
      return '${index.toString().padLeft(2, '0')}';
    }

    // 分をビルドする関数
    String minuteBuilder(int index) {
      return '${(index * 5).toString().padLeft(2, '0')}';
    }


    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 時間のピッカー
          Expanded(
            child:
            Container(
              height: 160,
              width: MediaQuery.of(context).size.width * 0.4,
              child: ListWheelScrollView(
                controller: hourController,
                physics: FixedExtentScrollPhysics(),
                useMagnifier: true,
                magnification: 1.0,
                itemExtent: 50,
                onSelectedItemChanged: (index) {
                  ref.read(hourPickerProvider.state).state = index;
                  onHourSelected(hourBuilder(index));
                  },
                children: List<Widget>.generate(itemHourCount, (index) {
                  return Padding(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        color: selectedHourIndex == index
                            ? Color.fromRGBO(222, 222, 222, 1)
                            : Colors.transparent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:Text(
                          hourBuilder(index),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: selectedHourIndex == index ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                ),
              ),
            ),
          ),
          // 分のピッカー
          Expanded(
            child:Container(
              height: 160,
              width: MediaQuery.of(context).size.width * 0.4,
              child: ListWheelScrollView(
                controller: minuteController,
                physics: FixedExtentScrollPhysics(),
                useMagnifier: true,
                magnification: 1.0,
                itemExtent: 50,
                onSelectedItemChanged: (index) {
                  ref.read(minutePickerProvider.state).state = index;
                  onMinuteSelected(minuteBuilder(index));
                  },
                children: List<Widget>.generate(itemMinuteCount, (index) {
                  return Padding(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        color: selectedMinuteIndex == index
                            ? Color.fromRGBO(222, 222, 222, 1)
                            : Colors.transparent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child:Text(
                          minuteBuilder(index),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: selectedMinuteIndex == index ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
