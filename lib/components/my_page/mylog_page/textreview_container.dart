import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../db/database_helper.dart';

final reviewProvider = FutureProvider.family<Map<String, dynamic>?, int>((ref, movieId) async {
  return DatabaseHelper.instance.getReviewByMovieId(movieId);
});

class TextReviewContainer extends ConsumerWidget {
  final int movieId;

  TextReviewContainer({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewFuture = ref.watch(reviewProvider(movieId));

    return reviewFuture.when(
      data: (review) {
        if (review != null && review.containsKey(DatabaseHelper.columnText) && review[DatabaseHelper.columnText] != null) {
          // テキストレビューが存在する場合は表示する
          String textReview = review[DatabaseHelper.columnText];
          return Text(
              textReview,
              style: const TextStyle(fontSize: 20),
          );
        } else {
          // レビューが存在しない場合は何も表示しない
          return Container();
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('エラー: $e'),
    );
  }
}
