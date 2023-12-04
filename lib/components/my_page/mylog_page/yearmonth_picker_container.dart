import 'package:dup_movielist/components/my_page/mylog_page/yearmonth_picker.dart';
import 'package:flutter/material.dart';

class YearMonthPickerContainer extends StatelessWidget {
  final ValueChanged<String> onYearSelected;
  final ValueChanged<String> onMonthSelected;

  YearMonthPickerContainer({
    required this.onYearSelected,
    required this.onMonthSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
              Expanded(
                child: YearMonthPicker(
                  title: "Year",
                  itemCount: DateTime.now().year - 1895 + 2,
                  itemBuilder: (index) {
                    return '${DateTime.now().year - index }';


                    /*if (index == 0) {
                      return '全期間';
                    } else {
                      return '${DateTime.now().year - index + 1}';
                    }

                     */
                  },
                  onItemSelected: onYearSelected,
                ),
              ),
              Expanded(
                child: YearMonthPicker(
                  title: "Month",
                  itemCount: 13,
                  itemBuilder: (index) {
                    if (index == 0) {
                      return 'ー';
                    } else {
                      return '${index}';
                    }
                  },
                  onItemSelected: onMonthSelected,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
