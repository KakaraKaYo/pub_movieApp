import 'package:dup_movielist/components/my_page/mylog_page/sort_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



/*
並び替え用のドラムロールを作成するWidget
 */

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class SortDrumroll extends ConsumerWidget {
  final List<String> sortItem = [
    '記録日時が新しい順',
    '記録日時が古い順',
    '評価が高い順',
    '評価が低い順',
    '鑑賞日時が新しい順',
    '鑑賞日時が古い順',
    '鑑賞回数が多い順',
  ];

  final void Function(String) onItemSelected;


  SortDrumroll({Key? key, required this.onItemSelected}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final FixedExtentScrollController controller = FixedExtentScrollController(initialItem: selectedIndex);

    return Container(
      height: 201,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListWheelScrollView(
        controller: controller,
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        useMagnifier: true,
        magnification: 1.0,




        onSelectedItemChanged: (index) {
          ref.read(selectedIndexProvider.notifier).state = index;
          ref.read(selectedItemProvider.notifier).state = sortItem[index];
          onItemSelected(sortItem[index]);
          print('Selected item: ${sortItem[index]}'); // これを追加して選択された項目を確認
        },


        children: List<Widget>.generate(sortItem.length, (index) {
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: selectedIndex == index
                    ? const Color.fromRGBO(222, 222, 222, 1)
                    : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  sortItem[index],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
