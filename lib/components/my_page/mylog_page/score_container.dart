import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../db/database_helper.dart';



final reviewProvider = FutureProvider.family<Map<String, dynamic>?, int>((ref, movieId) async {
  return DatabaseHelper.instance.getReviewByMovieId(movieId);
});


class ScoreContainer extends ConsumerWidget {
  final int movieId;

  ScoreContainer({required this.movieId});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewFuture = ref.watch(reviewProvider(movieId));


    return reviewFuture.when(
      data: (review) {
        if (review != null && review.containsKey(DatabaseHelper.columnScore) && review[DatabaseHelper.columnScore] != null) {
          // レビューが存在し、かつstarがnullでない場合、評価を表示
          double starRating = review[DatabaseHelper.columnScore] is double
              ? review[DatabaseHelper.columnScore]
              : double.tryParse(review[DatabaseHelper.columnScore].toString()) ?? -1.0;

          // starRating が -1 の場合、別のウィジェットを表示
          if (starRating == -0.1) {
            return const Text('評価なし', style: TextStyle(fontSize: 16));
          }

          return Column(
              children: [
                Text('score ${starRating.toStringAsFixed(1)}',
                  // 小数点以下1桁で表示
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(116, 105, 0, 1),
                    fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(height: 5),
                RatingBarIndicator(
                  rating: starRating,
                  itemBuilder: (context, index) =>
                  const Icon(
                    Icons.star_purple500_sharp,
                    color: Color.fromRGBO(116, 105, 0, 1),
                  ),
                  itemCount: 5,
                  itemSize: 30.0,
                  direction: Axis.horizontal,
                ),
              ]
          );
        } else {
          // レビューが存在しない場合、またはstarがnullの場合、メッセージを表示
          return const Text('レビューがありません');
        }
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, st) => Text('エラー: $e'),
    );
  }
}
