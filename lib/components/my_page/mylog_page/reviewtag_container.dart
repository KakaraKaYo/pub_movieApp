import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedChipProvider = StateProvider<String>((ref) => '');


class ReviewTagContainer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedChip = ref.watch(selectedChipProvider);

    print('ReviewTagContainerが再構築されました。選択されたチップ: $selectedChip');

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
      child: Container(
        //height: 400,
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              Text(selectedChip,style: TextStyle(fontSize: 40),), // 選択されたチップを表示

              // 他の子ウィジェット
            ],
          ),
        ),
      ),
    );
  }
}
