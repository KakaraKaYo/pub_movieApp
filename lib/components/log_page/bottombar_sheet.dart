import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final showModalSheetProvider = StateProvider<bool>((ref) => false);

class TagModalSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 0.5,
      builder: (_, scrollController) {
        return Container(
          color: Colors.red,
          child: ListView.builder(
            controller: scrollController,
            itemCount: 10,
            itemBuilder: (_, index) => ListTile(title: Text('Item $index')),
          ),
        );
      },
    );
  }
}
