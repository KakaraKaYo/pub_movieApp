import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// スクリーンのナンバーを保持するプロバイダー
// 座席を保持するプロバイダー
final selectedSeatProvider = StateProvider<String?>((ref) => null);

class SeatSelectContainer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 選択された座席を取得
    final selectedSeat = ref.watch(selectedSeatProvider);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
      child: InkWell(
        onTap: () async {
          // ユーザーに座席を選択させるダイアログを表示
          final selected = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: const Text('座席選択'),
                children: <Widget>[
                  SimpleDialogOption(
                    onPressed: () { Navigator.pop(context, 'A-12'); },
                    child: const Text('A-12'),
                  ),
                  SimpleDialogOption(
                    onPressed: () { Navigator.pop(context, 'B-6'); },
                    child: const Text('B-6'),
                  ),
                  // 他の座席のオプションを追加
                ],
              );
            },
          );
          // 選択された座席をプロバイダーに保存
          if (selected != null) {
            ref.read(selectedSeatProvider.notifier).state = selected;
          }
        },
        child: SizedBox(
          height: 150,
          child: Column(
            children: [
              Row(
                children: const [
                  Text('座席', style: TextStyle()),
                ],
              ),
              Expanded(
                child: Center(
                  child: Text(
                    selectedSeat ?? '座席を選択',
                    style: const TextStyle(fontSize: 24, decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
