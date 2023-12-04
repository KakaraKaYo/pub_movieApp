import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieRecord {
  final int id;
  final String title;
  final String imagePath;
  final DateTime createdAt;

  MovieRecord({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.createdAt,
  });

  // データベースから読み込んだMapからオブジェクトを生成するファクトリメソッド
  factory MovieRecord.fromMap(Map<String, dynamic> data) {
    return MovieRecord(
      id: data['id'],
      title: data['title'],
      imagePath: data['image_path'],
      createdAt: DateTime.parse(data['created_at']),
    );
  }

  // オブジェクトからデータベースに保存するためのMapを生成するメソッド
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image_path': imagePath,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

// StateNotifierを継承したMovieListNotifierクラス
class MovieListNotifier extends StateNotifier<List<MovieRecord>> {
  MovieListNotifier() : super([]);

  // 映画リストを並び替えるメソッド
  void sortWatchedList(String sortType) {
    switch (sortType) {
      case '記録日時が新しい順':
        state.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case '記録日時が古い順':
        state.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
    // 他の並び替え基準に応じたケースもここに追加
    }
    state = List.from(state); // 更新を通知するために新しいリストをセット
  }
}
