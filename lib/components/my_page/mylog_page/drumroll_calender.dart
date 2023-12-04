import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'yearmonth_picker_container.dart';

final tappedProvider = StateProvider<bool>((ref) => false);
final showTextProvider = StateProvider<bool>((ref) => false);
final selectedYearProvider = StateProvider<String>((ref) => "");
final selectedMonthProvider = StateProvider<String>((ref) => "");

class DrumrollCalender extends ConsumerWidget {
  final double desiredWidth;

  DrumrollCalender({required this.desiredWidth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _tapped = ref.watch(tappedProvider.state).state;
    final _showText = ref.watch(showTextProvider.state).state;
    final selectedYear = ref.watch(selectedYearProvider.state).state;
    final selectedMonth = ref.watch(selectedMonthProvider.state).state;

    void _toggleContainer() {
      if (_tapped) {
        ref.read(showTextProvider.state).state = false;
        Future.delayed(const Duration(milliseconds: 100), () {
          ref.read(tappedProvider.state).state = false;
        });
      } else {
        ref.read(tappedProvider.state).state = true;
        Future.delayed(const Duration(milliseconds: 200), () {
          ref.read(showTextProvider.state).state = true;
        });
      }
    }

    void _onYearSelected(String year) {
      ref.read(selectedYearProvider.state).state = year;
    }

    void _onMonthSelected(String month) {
      ref.read(selectedMonthProvider.state).state = month;
    }

    return  GestureDetector(
        onTap: _tapped ? null : _toggleContainer, // _tappedがtrueの場合、onTapはnullに設定されます
        child:AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(5),
            color: Colors.white,
          ),
          duration: Duration(milliseconds: 100),
          height: _tapped ? 251 : 51,

          child: Column(
            children: <Widget>[
              SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text("$selectedYear", style: TextStyle(fontSize: 16)),
                    ),
                    Text("年",style: TextStyle(fontSize: 16),),
                    const Spacer(),
                    SizedBox(
                      width:50,
                      child:Text("$selectedMonth", style: TextStyle(fontSize: 16)),
                    ),
                    Text("月",style: TextStyle(fontSize: 16),),
                    const Spacer(),
                    Icon(_tapped ? null : Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),


          //タップすることでカレンダー表示
          if (_tapped && _showText)
            Column(
              children:[
                const Divider(
                  height: 0,
                  thickness: 1, // Dividerの線の厚さ
                  indent: 15,
                  endIndent: 15,
                  color: Color.fromRGBO(203, 203, 203, 1),
                ),
            GestureDetector(
              onTap: _tapped ? null : _toggleContainer,
              child: YearMonthPickerContainer(
                onYearSelected: _onYearSelected,
                onMonthSelected: _onMonthSelected,
              ),
            ),
            ]
            ),

        ],
      ),
        ),
    );
  }
}
