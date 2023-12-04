import 'dart:convert';
import 'package:http/http.dart' as http;

// TMDBに登録して付与されたAPIトークン
final API_TOKEN = "";

Future<List<Map<String, dynamic>>> fetchMovieData() async {
  // TMDBのAPIエンドポイント
  String apiEndPoint = 'https://api.themoviedb.org/3/movie/now_playing?api_key=' + API_TOKEN + '&language=ja-JP&region=US&page=1';
  // TMDBの画像が格納されているパス
  String imagePath = 'https://image.tmdb.org/t/p/original';

  print('通信するAPIエンドポイント： ${apiEndPoint}');

  // HTTP通信をし、JSONを取得する
  final response = await http.get(Uri.parse(apiEndPoint));

  if (response.statusCode == 200) {
    // 正常に通信ができたことを通知
    print('HTTPレスポンスコード:200');
    // JSONをパースしてデータを取得する
    final jsonData = json.decode(response.body);
    // 取得したJSONのうち、resultsをキーとする要素の配列に、映画情報が格納されている
    final movieResults = jsonData['results'];

    // 映画情報のオブジェクトを格納するリスト
    List<Map<String, dynamic>> movieList = [];
    // JSONデータを処理して、映画情報のオブジェクトのリストを返す
    for (var movie in movieResults) {
      // 念の為、タイトルや評価の値が空でないことを確認する
      if (movie['title'] != null && movie['vote_average'] != null) {
        // リストに生成したオブジェクトを追加する
        movieList.add({
          'title': movie['title'],
          'vote_average': movie['vote_average'],
          'poster_path': imagePath + movie['poster_path']
        });
      }
    }
    return movieList;
  } else {
    throw Exception('映画情報をTMDBのAPIから取得できませんでした。HTTPコード：' + response.statusCode.toString());
  }
}

// 1本の映画の情報のみを取得する場合は以下のメソッドを使用する
Future<Map<String, dynamic>> fetchSingleMovieData(String apiEndPointStr) async {
  // HTTP通信をし、JSONを取得する
  final response = await http.get(Uri.parse(apiEndPointStr));

  print('通信するAPIエンドポイント： ${apiEndPointStr}');

  if (response.statusCode == 200) {
    // 正常に通信ができたことを通知
    print('HTTPレスポンスコード:200');
    // JSONをパースしてデータを取得する
    final jsonData = json.decode(response.body);

    // 映画情報のオブジェクトを格納するリスト
    Map<String, dynamic> movie = new Map();
    movie['original_title'] = jsonData['original_title'];
    movie['release_date'] = jsonData['release_date'];
    movie['vote_average'] = jsonData['vote_average'];
    return movie;
  } else {
    throw Exception('映画情報をTMDBのAPIから取得できませんでした。HTTPコード：' + response.statusCode.toString());
  }
}
