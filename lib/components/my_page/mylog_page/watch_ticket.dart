import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../db/database_helper.dart';



final watchProvider = FutureProvider.family<Map<String, dynamic>?, int>((ref, movieId) async {
  return DatabaseHelper.instance.getWatchByMovieId(movieId);
});


class WatchTicket extends ConsumerWidget {
  final int movieId;

  WatchTicket({required this.movieId});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchFuture = ref.watch(watchProvider(movieId));

    return watchFuture.when(
      data: (watchData) {
        if (watchData != null) {
          return Container(
            width: 400,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // 枠線の色
                width: 2.0, // 枠線の太さ
              ),
            ),
            child: Column(
              children: [
                Text('鑑賞方法 ${watchData[DatabaseHelper.watchColumnMethod]}'),
                Text('映画館の場所 ${watchData[DatabaseHelper.watchColumnTheaterId]}'),
                Text('鑑賞日 ${watchData[DatabaseHelper.watchColumnWatchDateAt]}'),
                Text('開始時間 ${watchData[DatabaseHelper.watchColumnStartedAt]}'),
                Text('スクリーン ${watchData[DatabaseHelper.watchColumnScreenNumber]}'),
                Text('座席 ${watchData[DatabaseHelper.watchColumnSeatNumber]}'),
              ],
            ),
          );
        } else {
          return Text('鑑賞データがありません');
        }
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, st) => Text('エラー: $e'),
    );
  }
}
