import 'dart:io';
import 'package:dup_movielist/components/my_page/mylog_page/flow_button.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// 参考サイト
// https://yakiimosan.com/flutter-sqlite-basic/

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db"; // DB名
  static final _databaseVersion = 1; // スキーマのバージョン指定
  static final String watchColumnWatchCount = 'watch_count'; // この行を追加


  // レビューテーブル定義 ここから
  static final tableNameReview = 'review'; // レビューテーブル名
  static final columnId = '_id'; // カラム名：ID (一意に判別するID)
  static final columnMovieId = 'movie_id'; // カラム名：movie_id (レビュー対象の映画のID)
  static final columnScore = 'score'; // 星の数(小数型を想定)
  static final columnTitle = 'title'; // カラム名:title (レビュータイトル)
  static final columnText = 'text'; // カラム名:text (レビュー内容)
  static final columnUpdatedAt = 'updated_at'; // カラム名：updated_at (最終更新日時)
  static final columnCreatedAt = 'created_at'; // カラム名：created_at (レビュー初回作成日時)
  static final columnVersionNo = 'version_no'; // カラム名：version_no (編集回数)
  static final columnIsDeleted = 'is_deleted'; // カラム名：is_deleted (レビューを削除したか)
  // レビューテーブル定義 ここまで




  //以下レビュータグ保存のため試行錯誤コード（未解決）

  // テーブル名とカラム名の変数定義（適切な値に置き換えてください）
  String tableNameReviewTags = 'review_tags';
  String columnReviewId = 'review_id';
  String columnTagId = 'tag_id';
  //String tableNameReview = 'review';
  //String columnId = '_id'; // 'review' テーブルのIDカラム名
  String tableNameTags = 'tags';
  String tagId = 'id';
  String tagName = 'name';

  //以上レビュータグ保存のため試行錯誤コード（未解決）




  // 映画テーブル定義 ここから
  static final tableNameTheater = 'theater';
  static final theaterColumnTheaterId = '_theater_id';
  static final theaterColumnMovieId = 'movie_id';
  static final theaterColumnTitle = 'title';
  static final theaterColumnBody = 'body';
  static final theaterColumnUpdatedAt = 'updated_at';
  static final theaterColumnCreatedAt = 'created_at';
  static final theaterColumnVersionNo = 'version_no';
  static final theaterColumnIsDeleted = 'is_deleted';

  // 視聴履歴テーブル定義 ここから
  static final tableNameWatch = 'watch';
  static final watchColumnId = '_watch_id';
  static final watchColumnMethod = 'watch_method';
  static final watchColumnTheaterId = 'theater_id'; //鑑賞した映画館のID
  static final watchColumnMovieId = 'movie_id';
  static final watchColumnWatchDateAt = 'watched_date'; //鑑賞した日程
  static final watchColumnStartedAt = 'started_at'; //上映開始日時（いらないかも）
  static final watchColumnScreenTime = 'screen_time'; //上映時間（いらないかも）
  static final watchColumnScreenNumber = 'screen_number'; //鑑賞したスクリーン
  static final watchColumnSeatNumber = 'seat_number'; //鑑賞した座席番号
  static final watchColumnTicketPrice = 'ticket_price'; //映画の価格
  static final watchColumnWatchType = 'watch_type'; //鑑賞形式、IMAXとか
  static final watchColumnCount = 'watch_count'; //鑑賞回数
  static final watchColumnUpdatedAt = 'updated_at';
  static final watchColumnCreatedAt = 'created_at';
  static final watchColumnVersionNo = 'version_no';
  static final watchColumnIsDeleted = 'is_deleted';

  // 見たいテーブル定義 ここから
  static final tableNameWant = 'want';
  static final wantColumnId = '_want_id';
  static final wantColumnMovieId = 'movie_id';
  static final wantColumnUpdatedAt = 'updated_at';
  static final wantColumnCreatedAt = 'created_at';
  static final wantColumnVersionNo = 'version_no';
  static final wantColumnIsDeleted = 'is_deleted';

  // チケット画像テーブル定義 ここから
  static final tableNameTicketPicture = 'ticket_picture';
  static final ticketPictureColumnId = '_ticket_picture_id';
  static final ticketPictureColumnTicketId = 'ticket_id';
  static final ticketPictureColumnPicturePath = 'picture_path';
  static final ticketPictureColumnUpdatedAt = 'updated_at';
  static final ticketPictureColumnCreatedAt = 'created_at';
  static final ticketPictureColumnVersionNo = 'version_no';
  static final ticketPictureColumnIsDeleted = 'is_deleted';

  // DatabaseHelper クラスを定義
  DatabaseHelper._privateConstructor();

  // DatabaseHelper._privateConstructor() コンストラクタを使用して生成されたインスタンスを返すように定義
  // DatabaseHelper クラスのインスタンスは、常に同じものであるという保証
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Databaseクラス型のstatic変数_databaseを宣言
  // クラスはインスタンス化しない
  static Database? _database;

  // databaseメソッド定義
  // 非同期処理
  Future<Database?> get database async {
    // _databaseがNULLか判定
    // NULLの場合、_initDatabaseを呼び出しデータベースの初期化し、_databaseに返す
    // NULLでない場合、そのまま_database変数を返す
    // これにより、データベースを初期化する処理は、最初にデータベースを参照するときにのみ実行されるようになります。
    // このような実装を「遅延初期化 (lazy initialization)」と呼びます。
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // データベース接続
  _initDatabase() async {
    // アプリケーションのドキュメントディレクトリのパスを取得
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // 取得パスを基に、データベースのパスを生成
    String path = join(documentsDirectory.path, _databaseName);
    // データベース接続
    return await openDatabase(path,
        version: _databaseVersion,
        // テーブル作成メソッドの呼び出し
        onCreate: _onCreate);
  }

  // テーブル作成
  // 引数:dbの名前
  // 引数:スキーマーのversion
  // スキーマーのバージョンはテーブル変更時にバージョンを上げる（テーブル・カラム追加・変更・削除など）
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableNameReview (
            $columnId INTEGER PRIMARY KEY,
            $columnMovieId INTEGER NOT NULL,
            $columnTitle TEXT,
            $columnText TEXT,
            $columnScore REAL,
            $columnUpdatedAt DATE NOT NULL,
            $columnCreatedAt DATE NOT NULL,
            $columnVersionNo INTEGER NOT NULL,
            $columnIsDeleted INTEGER NOT NULL
          )
          ''');


    //以下レビュータグ保存のため試行錯誤コード（未解決）


    // レビュータグテーブルの作成
    await db.execute("""
  CREATE TABLE $tableNameReviewTags (
    $columnReviewId INTEGER,
    $columnTagId INTEGER,
    PRIMARY KEY ($columnReviewId, $columnTagId),
    FOREIGN KEY ($columnReviewId) REFERENCES $tableNameReview ($columnId),
    FOREIGN KEY ($columnTagId) REFERENCES $tableNameTags ($tagId)
  )
""");

// タグテーブルの作成
    await db.execute("""
  CREATE TABLE $tableNameTags (
    $tagId INTEGER PRIMARY KEY,
    $tagName TEXT NOT NULL
  )
""");

// タグの挿入
    var tags = ['いちじく', 'りんご', 'ぶどう', 'グレープフルーツ', 'れもん', 'もも', 'マスカット', 'メロン', 'いちご', 'スイカ'];
    for (var tag in tags) {
      await db.insert(tableNameTags, {tagName: tag});
    }
    //以上レビュータグ保存のため試行錯誤コード（未解決）




    // 映画テーブルのCREATE文


    await db.execute('''
          CREATE TABLE $tableNameTheater (
            $theaterColumnTheaterId INTEGER PRIMARY KEY,
            $theaterColumnMovieId INTEGER NOT NULL,
            $theaterColumnTitle TEXT,
            $theaterColumnBody TEXT,
            $theaterColumnUpdatedAt DATE NOT NULL,
            $theaterColumnCreatedAt DATE NOT NULL,
            $theaterColumnVersionNo INTEGER NOT NULL,
            $theaterColumnIsDeleted INTEGER NOT NULL
          )
          ''');

    // 視聴履歴テーブルのCREATE文
    await db.execute('''
            CREATE TABLE $tableNameWatch (
              $watchColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
              $watchColumnMethod TEXT,
              $watchColumnTheaterId INTEGER NOT NULL,
              $watchColumnMovieId INTEGER NOT NULL,
              $watchColumnWatchDateAt DATE NOT NULL,
              $watchColumnStartedAt DATETIME,
              $watchColumnScreenTime INTEGER,
              $watchColumnScreenNumber TEXT,
              $watchColumnSeatNumber TEXT,
              $watchColumnTicketPrice INTEGER,
              $watchColumnWatchType INTEGER,
              $watchColumnCount INTEGER DEFAULT 0,
              $watchColumnUpdatedAt DATE NOT NULL,
              $watchColumnCreatedAt DATE NOT NULL,
              $watchColumnVersionNo INTEGER NOT NULL,
              $watchColumnIsDeleted INTEGER NOT NULL
            )
          ''');

    // 見たいテーブルのCREATE文
    await db.execute('''
            CREATE TABLE $tableNameWant (
              $wantColumnId INTEGER PRIMARY KEY,
              $wantColumnMovieId INTEGER NOT NULL,
              $wantColumnUpdatedAt DATE NOT NULL,
              $wantColumnCreatedAt DATE NOT NULL,
              $wantColumnVersionNo INTEGER NOT NULL,
              $wantColumnIsDeleted INTEGER NOT NULL
            )
          ''');

    // チケット画像テーブルのCREATE文
    await db.execute('''
            CREATE TABLE $tableNameTicketPicture (
              $ticketPictureColumnId INTEGER PRIMARY KEY,
              $ticketPictureColumnTicketId INTEGER NOT NULL,
              $ticketPictureColumnPicturePath TEXT,
              $ticketPictureColumnUpdatedAt DATE NOT NULL,
              $ticketPictureColumnCreatedAt DATE NOT NULL,
              $ticketPictureColumnVersionNo INTEGER NOT NULL,
              $ticketPictureColumnIsDeleted INTEGER NOT NULL
            )
          ''');
  }

  // レコード追加メソッド
  Future<int> insertReview(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tableNameReview, row);
  }

  // 鑑賞履歴テーブル追加メソッド
  Future<int> insertWatch(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tableNameWatch, row);
  }


  Future<int> getWatchCountByMovieId(int movieId) async {
    final db = await database;
    if (db == null) {
      print('データベースへの接続に失敗しました。');
      return 0; // データベースがnullの場合は0を返す
    }
    // COUNT関数を使って指定されたmovieIdの鑑賞回数をカウントするクエリ
    final result = await db.rawQuery(
      'SELECT COUNT(*) AS watch_count FROM $tableNameWatch WHERE $watchColumnMovieId = ?',
      [movieId],
    );

    // デバッグログを出力
    print('getWatchCountByMovieId - rawQuery result: $result');

    if (result.isNotEmpty && result.first['watch_count'] != null) {
      // nullチェックと型変換を行い、カウント値を返す
      int count = int.tryParse(result.first['watch_count'].toString()) ?? 0;
      print('映画ID $movieId の鑑賞回数: $count');
      return count;
    } else {
      print('映画ID $movieId の鑑賞記録はありません。');
      return 0; // 結果が空の場合は0を返す
    }
  }


  Future<int?> updateWatch(int movieId, int newWatchCount) async {
    final db = await database;

    // 更新するデータのマップを作成
    Map<String, dynamic> row = {
      watchColumnWatchCount: newWatchCount,
      // 他に更新する必要があるカラムがあればここに追加
      watchColumnUpdatedAt: DateTime.now().toIso8601String(), // 更新日時
    };

    // 指定された movieId に対応するレコードを更新
    return await db?.update(
      tableNameWatch,
      row,
      where: '$watchColumnMovieId = ?',
      whereArgs: [movieId],
    );
  }


  // 見たいテーブル追加メソッド
  Future<int> insertWant(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tableNameWant, row);
  }

  // レコード更新メソッド
  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update(
      tableNameReview,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

//movieIdより記録したレビューを取得するメソッド
  Future<Map<String, dynamic>?> getReviewByMovieId(int movieId) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = await db!.query(
      DatabaseHelper.tableNameReview,
      where: '${DatabaseHelper.columnMovieId} = ?',
      whereArgs: [movieId],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  //movieIdより記録したレビューを取得するメソッド
  Future<Map<String, dynamic>?> getWatchByMovieId(int movieId) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = await db!.query(
      DatabaseHelper.tableNameWatch,
      where: '${DatabaseHelper.columnMovieId} = ?',
      whereArgs: [movieId],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }


  Future<List<Map<String, dynamic>>?> getWatch() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = await db!.query(
      DatabaseHelper.tableNameWatch,
    );

    if (result.isNotEmpty) {
      return result;
    } else {
      return [];
    }
  }


  //鑑賞した映画の並び替えメソッド
  String getOrderBy(String sortType) {
    switch (sortType) {
      case "記録日時が新しい順":
        return 'w.created_at DESC'; // 記録日時の降順
      case "記録日時が古い順":
        return 'w.created_at ASC'; // 記録日時の昇順
      case "評価が高い順":
        return 'r.score DESC'; // 評価の降順
      case "評価が低い順":
        return 'r.score ASC'; // 評価の昇順
      case "鑑賞日時が新しい順":
        return 'w.watched_date DESC'; // 鑑賞日時の降順
      case "鑑賞日時が古い順":
        return 'w.watched_date ASC'; // 鑑賞日時の昇順
      case "鑑賞回数が多い順":
        return 'w.watch_count DESC'; // 鑑賞回数の降順
      default:
        return 'w.created_at DESC'; // デフォルトは記録日時の降順
    }
  }

  Future<List<Map<String, dynamic>>?> getSortedWatchData(SearchData searchData) async {
    Database? db = await instance.database;
    String orderBy = getOrderBy(searchData.sortType);
    String groupBy = '';
    String selectClause;

    if (searchData.sortType == "鑑賞回数が多い順" || searchData.sortType == "評価が高い順" || searchData.sortType == "評価が低い順") {
      // GROUP BYを使用してmovie_idごとに1つのレコードにまとめる
      groupBy = 'GROUP BY w.movie_id';
      selectClause = 'w.movie_id, MAX(r.title) as title, MAX(r.score) as score, COUNT(w.movie_id) as watch_count';
      if (searchData.sortType == "評価が高い順") {
        orderBy = 'MAX(r.score) DESC, MAX(w.watched_date) DESC';
      } else if (searchData.sortType == "評価が低い順") {
        orderBy = 'MAX(r.score) ASC, MAX(w.watched_date) DESC';
      } else {
        orderBy = 'watch_count DESC, MAX(w.watched_date) DESC';
      }
    } else {
      // 通常のSELECT句
      selectClause = 'w.*, r.score, r.title';
    }

    String rawQuery = '''
    SELECT $selectClause
    FROM ${DatabaseHelper.tableNameWatch} AS w
    LEFT JOIN ${DatabaseHelper.tableNameReview} AS r ON w.movie_id = r.movie_id
    WHERE w.is_deleted = 0 AND r.is_deleted = 0
    $groupBy
  ORDER BY $orderBy
  ''';

    List<Map<String, dynamic>> result = await db!.rawQuery(rawQuery);

    return result.isNotEmpty ? result : [];
  }
  //鑑賞した映画の並び替えメソッド終わり


  //見たい映画追加メソッド
  Future<List<Map<String, dynamic>>> getWant() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = await db!.query(
      DatabaseHelper.tableNameWant,
    );
    return result.isNotEmpty ? result : [];
  }



  //以下レビュータグ保存のため試行錯誤コード（未解決）


  // タグ名に基づいてタグIDを取得するメソッド
  Future<int?> getTagIdByName(String tagName) async {
    final db = await instance.database;

    if (db != null) {
      List<Map<String, dynamic>> result = await db.query(
        'tags', // 実際のテーブル名
        columns: ['id'], // 実際のタグIDのカラム名
        where: 'name = ?', // 実際のタグ名を格納するカラム名
        whereArgs: [tagName],
      );

      // ここにデバッグ出力を追加
      print("デバッグ出力: result = $result");

      if (result.isNotEmpty) {
        return result.first['id'] as int;
      }
    }
    return null;
  }






  // 映画にタグを関連付けるメソッド
  /*Future<void> addTagsToReview(int reviewId, List<String> tagNames) async {
    final db = await database;
    if (db != null) {
      for (var tagName in tagNames) {
        final tagId = await getTagIdByName(tagName);
        if (tagId != null) {
          await db.insert(
            tableNameReviewTags,
            {
              columnReviewId: reviewId,
              columnTagId: tagId,
            },
          );
        }
      }
    }
  }

   */



  // 指定された映画IDに関連付けられているタグのIDを取得するメソッド
  Future<List<int>> getTagIdsByMovieId(int movieId) async {
    final db = await database;

    List<Map<String, dynamic>> result = await db!.rawQuery('''
    SELECT t.id FROM tags AS t
    INNER JOIN review_tags AS rt ON t.id = rt.tag_id
    WHERE rt.review_id = ?
  ''', [movieId]);

    return result.map((row) => int.parse(row['id'].toString())).toList();
  }



  // 特定の映画IDに紐づくタグを取得するメソッド
  Future<List<String>> getTagsByMovieId(int movieId) async {
    Database? db = await instance.database;

    // 'review_tags' テーブルから、指定された映画IDに関連するタグIDを取得
    List<Map<String, dynamic>> tagIdsResult = await db!.query(
      tableNameReviewTags, // 'review_tags' テーブル名
      columns: [columnTagId], // タグIDのカラム
      where: '$columnReviewId = ?', // 映画IDに基づく条件
      whereArgs: [movieId],
    );

    // デバッグ出力：取得したタグIDのリスト
    print('取得したタグID: $tagIdsResult');

    List<String> tags = [];
    for (var map in tagIdsResult) {
      int tagId = map[columnTagId];

      var tagMaps = await db.query(
        tableNameTags, // 'tags' テーブル名
        columns: [tagName], // タグ名のカラム
        where: 'id = ?', // タグIDに基づく条件
        whereArgs: [tagId],
      );

      // デバッグ出力：特定のタグIDに対するタグ名のクエリ結果
      print('タグID $tagId に対するタグ名: $tagMaps');

      if (tagMaps.isNotEmpty) {
        var tag = tagMaps.first[tagName];
        if (tag is String) {
          tags.add(tag);
        }
      }
    }

    // デバッグ出力：最終的に取得したタグ名のリスト
    print('最終的に取得したタグ: $tags');

    return tags;
  }





  Future<void> insertReviewTag(int reviewId, int tagId) async {
    final db = await database; // 既存のデータベース接続を取得
    await db?.insert(
      tableNameReviewTags,
      {
        columnReviewId: reviewId,
        columnTagId: tagId,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore, // 既に存在する場合は無視
    );
  }


//以上レビュータグ保存のため試行錯誤コード（未解決）


}




