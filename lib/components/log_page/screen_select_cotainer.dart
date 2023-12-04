import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// スクリーンのナンバーを保持するプロバイダー
final selectedScreenProvider = StateProvider<String?>((ref) => null);

class ScreenSelectContainer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 選択されたスクリーンのナンバーを取得
    final selectedScreen = ref.watch(selectedScreenProvider);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
      child: InkWell(
        onTap: () async {
          // ユーザーにスクリーンのナンバーを選択させるダイアログを表示
          final selected = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: const Text('スクリーン選択'),
                children: <Widget>[
                  SimpleDialogOption(
                    onPressed: () { Navigator.pop(context, 'Screen 1'); },
                    child: const Text('Screen 1'),
                  ),
                  SimpleDialogOption(
                    onPressed: () { Navigator.pop(context, 'Screen 2'); },
                    child: const Text('Screen 2'),
                  ),
                  // 他のスクリーンのオプションを追加
                ],
              );
            },
          );
          // 選択されたスクリーンをプロバイダーに保存
          if (selected != null) {
            ref.read(selectedScreenProvider.notifier).state = selected;
          }
        },
        child: SizedBox(
          height: 150,
          child: Column(
            children: [
              Row(
                children: const [
                  Text('スクリーン', style: TextStyle()),
                ],
              ),
              Expanded(
                child: Center(
                  child: Text(
                    selectedScreen ?? 'スクリーンを選択',
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
