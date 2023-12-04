import 'package:dup_movielist/components/log_page/calendar.dart';
import 'package:dup_movielist/components/log_page/time_drumroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
鑑賞日記録のためのカレンダーWidget
*/

// 選択された日付を管理するプロバイダー
final tappedProvider = StateProvider<bool>((ref) => false);
final currentStateProvider = StateProvider<ContainerState>((ref) => ContainerState.none);

enum ContainerState {
  none,
  calendar,
  timePicker
}


// アニメーションの状態を管理
final animationInProgressProvider = StateProvider<bool>((ref) => false);


// テキスト表示状態を管理するProvider
final showTextProvider = StateProvider<bool>((ref) => false);

final showTimePickerProvider = StateProvider<bool>((ref) => false);

final timeTextProvider = StateProvider<bool>((ref) => false);

class WatchedDayContainer extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider.state).state;
    final showText = ref.watch(showTextProvider);
    final timeText = ref.watch(timeTextProvider);
    final int? selectedHour = ref.watch(hourPickerProvider.state).state;
    final int? selectedMinute = ref.watch(minutePickerProvider.state).state;


    void _toggleCalendarContainer() {
      // アニメーションが進行中なら何もしない
      if (ref.read(animationInProgressProvider)) return;

      // 現在の状態を取得
      var currentState = ref.read(currentStateProvider);

      // カレンダーがアクティブかどうかをチェック
      bool isCalendarActive = currentState == ContainerState.calendar;
      bool isTimePickerActive = currentState == ContainerState.timePicker;

      // アニメーション開始
      ref.read(animationInProgressProvider.notifier).state = true;

      // アニメーションを即時に開始
      ref.read(currentStateProvider.notifier).state = ContainerState.calendar;


      if (isTimePickerActive) {
        // タイムピッカーがアクティブな場合、先に閉じる
        ref.read(timeTextProvider.notifier).state = false;
        ref.read(animationInProgressProvider.notifier).state = true;  // アニメーション開始

        // コンテナのアニメーション完了を待つ
        Future.delayed(const Duration(milliseconds: 200), () {
          // その後、カレンダーを開く
          ref.read(showTextProvider.notifier).state = true;
          ref.read(animationInProgressProvider.notifier).state = false;  // アニメーション終了
        });
      } else if (!isCalendarActive) {
        // カレンダーが非アクティブな場合、開く
        ref.read(currentStateProvider.notifier).state = ContainerState.calendar;
        Future.delayed(const Duration(milliseconds: 200), () {
          ref.read(showTextProvider.notifier).state = true;
          ref.read(animationInProgressProvider.notifier).state = false;
        });
      } else {
        // カレンダーがアクティブな場合、閉じる
        ref.read(currentStateProvider.notifier).state = ContainerState.none;
        ref.read(showTextProvider.notifier).state = false;
        ref.read(animationInProgressProvider.notifier).state = false;
      }
    }





    void _toggleTimeContainer() {

      // 他のアニメーションが進行中なら何もしない
      if (ref.read(animationInProgressProvider)) return;

      // 現在の状態を取得
      var currentState = ref.read(currentStateProvider);
      bool isTimePickerActive = currentState == ContainerState.timePicker;
      bool isCalendarActive = currentState == ContainerState.calendar;

      // アニメーション開始
      ref.read(animationInProgressProvider.notifier).state = true;

      if (isCalendarActive) {
        // カレンダーがアクティブな場合、先に閉じる
        ref.read(showTextProvider.notifier).state = false;
        Future.delayed(const Duration(milliseconds: 200), () {
          // その後、タイムピッカーを開く
          ref.read(currentStateProvider.notifier).state = ContainerState.timePicker;
          ref.read(timeTextProvider.notifier).state = true;
          ref.read(animationInProgressProvider.notifier).state = false;
        });
      } else if (!isTimePickerActive) {
        // タイムピッカーが非アクティブな場合、開く
        ref.read(currentStateProvider.notifier).state = ContainerState.timePicker;
        Future.delayed(const Duration(milliseconds: 200), () {
          ref.read(timeTextProvider.notifier).state = true;
          ref.read(animationInProgressProvider.notifier).state = false;
        });
      } else {
        // タイムピッカーがアクティブな場合、閉じる
        ref.read(currentStateProvider.notifier).state = ContainerState.none;
        ref.read(timeTextProvider.notifier).state = false;
        ref.read(animationInProgressProvider.notifier).state = false;
      }
    }


    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: ref.watch(currentStateProvider) == ContainerState.calendar ? 500 :
        ref.watch(currentStateProvider) == ContainerState.timePicker ? 260 : 100,
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              const Padding(padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                  child:Text('鑑賞日'),),
              Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child:
              Row(
                  children:[
                    TextButton(
                      onPressed: () {
                        if (
                        !ref.read(animationInProgressProvider)) {
                          _toggleCalendarContainer();
                        }
                        },
                      child:Text(selectedDate != null
                          ? '${selectedDate.year}年 ${selectedDate.month}月${selectedDate.day}日 (${_getWeekdayString(selectedDate.weekday)})'
                          : '${DateTime.now().year}年 ${DateTime.now().month}月${DateTime.now().day}日 (${_getWeekdayString(DateTime.now().weekday)})',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        if(!ref.read(animationInProgressProvider)) {
                          _toggleTimeContainer();
                        }
                      },
                      child: Text(
                        selectedHour == -1 || selectedMinute == -1
                            ? '開始時間'
                            : '${selectedHour.toString().padLeft(2, '0')}:${((selectedMinute ?? 0) * 5).toString().padLeft(2, '0')}~',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ]
              ),
              ),
              if (ref.watch(currentStateProvider) == ContainerState.calendar && showText)
                Calendar(),
              if (ref.watch(currentStateProvider) == ContainerState.timePicker && timeText)
                TimeDrumroll(title: '', onHourSelected: (String value) {  }, onMinuteSelected: (String value) {  },)
                ]
        ),
    );
  }


  String _getWeekdayString(int weekday) {
    // 曜日を表す文字列を返す
    switch (weekday) {
      case 1:
        return '月';
      case 2:
        return '火';
      case 3:
        return '水';
      case 4:
        return '木';
      case 5:
        return '金';
      case 6:
        return '土';
      case 7:
        return '日';
      default:
        return '';
    }
  }
}

