import 'package:dup_movielist/components/common/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dup_movielist/components/my_page/mylog_page/sort_drumroll.dart';


// 並び替えの種類を管理するProvider
final sortTypeProvider = StateProvider<String>((ref) => '記録日時が新しい順');

// 選択されたアイテムを管理するProvider
final selectedItemProvider = StateProvider<String>((ref) => "記録日時が新しい順");

// タップ状態を管理するProvider
final tappedProvider = StateProvider<bool>((ref) => false);

// テキスト表示状態を管理するProvider
final showTextProvider = StateProvider<bool>((ref) => false);

//アニメーションの状態を管理
final animationInProgressProvider = StateProvider<bool>((ref) => false);


class SortDropdown extends ConsumerWidget {
  final double desiredWidth;
  final void Function(String) onSortChanged; // コールバック関数の正しい宣言

  SortDropdown({
    required this.desiredWidth,
    required this.onSortChanged, // コンストラクタでコールバックを要求
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(selectedItemProvider);
    final isTapped = ref.watch(tappedProvider);
    final showText = ref.watch(showTextProvider);


    void _toggleContainer() {
      ref.read(tappedProvider.notifier).state = !isTapped;
      if (ref.read(animationInProgressProvider)) return;

      // アニメーション開始を設定
      ref.read(animationInProgressProvider.notifier).state = true;

      if (!isTapped) {
        // タップしてコンテナを開く場合、遅延後にテキストを表示
        Future.delayed(const Duration(milliseconds: 150), () {
          ref.read(showTextProvider.notifier).state = true;
          // アニメーション終了を設定
          ref.read(animationInProgressProvider.notifier).state = false;
        });
      } else {
        // タップしてコンテナを閉じる場合、すぐにテキストを非表示
        ref.read(showTextProvider.notifier).state = false;
        // アニメーション終了を設定
        ref.read(animationInProgressProvider.notifier).state = false;
      }
    }




    void _onItemSelected(String sortItem) {
      ref.read(selectedItemProvider.notifier).state = sortItem;
      ref.read(sortTypeProvider.notifier).state = sortItem;
      onSortChanged(sortItem); // 外部のコールバックを呼び出す
    }




    return GestureDetector(
      onTap: () {
        if (!ref.read(animationInProgressProvider)) {
          _toggleContainer();
        }
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        duration: const Duration(milliseconds: 150),
        height: isTapped ? 251 : 51,
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
                    Text(selectedItem, style: const TextStyle(fontSize: 16)),
                    const Spacer(),
                    Icon(isTapped ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            if (isTapped && showText)
              Column(
                children: [
                  const CustomDivider(
                    indent: 15,
                    endIndent: 15,
                  ),
                  SortDrumroll(
                    onItemSelected: _onItemSelected, // ここで _onItemSelected を使用
                  )

                ],
              ),
          ],
        ),
      ),
    );
  }
}
