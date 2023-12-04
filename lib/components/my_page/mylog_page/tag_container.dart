import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Page/my_page/mylog_page.dart';
import '../../../db/database_helper.dart';


final tagsProvider = FutureProvider.family<List<String>, int>((ref, movieId) async {
  // DatabaseHelper クラスに getTagsByMovieId メソッドが定義されていることを前提とします。
  // このメソッドは指定された映画IDに関連付けられているタグのリストを返すことを想定しています。
  return DatabaseHelper.instance.getTagsByMovieId(movieId);
});



final reviewProvider = FutureProvider.family<Map<String, dynamic>?, int>((ref, movieId) async {
  return DatabaseHelper.instance.getReviewByMovieId(movieId);
});



class TagContainer extends ConsumerWidget {
  final int movieId;

  TagContainer({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsFuture = ref.watch(tagsProvider(movieId));

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: tagsFuture.when(
        data: (tags) {
          print('取得したタグ: $tags');
          return Wrap(
            children: tags.map((tag) => Chip(label: Text(tag))).toList(),
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (e, stack) => Text('Error: $e'),
      ),
    );
  }
}
