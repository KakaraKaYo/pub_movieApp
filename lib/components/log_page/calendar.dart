import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

/*
鑑賞日記録のためのカレンダーWidget
*/

// 選択された日付を管理するプロバイダー
final selectedDateProvider = StateProvider<DateTime?>((ref) => DateTime.now());


class Calendar extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider.state).state;
    final _selectedDay = ValueNotifier<DateTime?>(selectedDate);
    final _focusedDay = ValueNotifier<DateTime>(selectedDate ?? DateTime.now());

    return ValueListenableBuilder<DateTime>(
        valueListenable: _focusedDay,
        builder: (context, value, _) {
          bool isCurrentMonth = value.year == DateTime
              .now()
              .year && value.month == DateTime
              .now()
              .month;

          return TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: value,
              calendarFormat: CalendarFormat.month,
              locale: 'ja',
              daysOfWeekHeight: 35,
              //曜日行の高さ
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                leftChevronVisible: true, // 左のナビゲーションアイコンを非表示にする
                rightChevronVisible: !isCurrentMonth, // 現在の月であれば非表示
              ),
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Color.fromRGBO(22, 22, 22, 1), //選択日
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.black, //現在日の色
                  shape: BoxShape.circle,
                ),
                disabledTextStyle: TextStyle(
                  color: Colors.grey,
                ),),

              enabledDayPredicate: (day) {
                return day.isBefore(DateTime.now());
              },


              selectedDayPredicate: (day) {
                bool isSelected = isSameDay(_selectedDay.value, day);
                if (isSelected) {
                  print("Currently selected day: $day");
                }
                return isSelected;
              },


              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay.value, selectedDay)) {
                  _selectedDay.value = selectedDay;
                  ref.read(selectedDateProvider.notifier).state = selectedDay;
                }
              },



              onPageChanged: (focusedDay) {
                // 現在の月を取得
                final currentMonth = DateTime.now();
                // スライドした月が現在の月より前であるか、または同じ月であることを確認
                if (focusedDay.year < currentMonth.year ||
                    (focusedDay.year == currentMonth.year &&
                        focusedDay.month <= currentMonth.month)) {
                  _focusedDay.value = focusedDay;
                } else {
                  // スライドした月が未来の月であれば、_focusedDayを現在の月に戻す
                  _focusedDay.value = DateTime(
                      currentMonth.year, currentMonth.month);
                }
              }
          );
        }
    );
  }
}

