import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../db/database_helper.dart';
import '../../../model/api_client.dart';
import 'package:http/http.dart' as http;

import '../../common/thumbnail_list.dart';


/*
wantに追加した映画画像を配列するWidget
 */
class WantList extends StatelessWidget {


  //TMDBからmovieIdを元に画像を取得
  Future<Map<String, dynamic>> _fetchData(int movieId) async {
    String searchByIdApiEndPoint =
        'https://api.themoviedb.org/3/movie/' + movieId.toString() + '?api_key=' + API_TOKEN + '&language=ja-JP';
    // APIエンドポイントへのHTTP GETリクエストを作成
    final response = await http.get(Uri.parse(searchByIdApiEndPoint));
    Map<String, dynamic> responseMap = json.decode(response.body);

    return responseMap;
  }

  //databaseからwantの情報を取得
  Future<List<Map<String, dynamic>>> _loadWantRecords() async {
    var wantMovieList = await DatabaseHelper.instance.getWant();
    return wantMovieList ?? [];
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _loadWantRecords(),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('エラー: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('データがありません');
        } else {
          print('ThumbnailListのwant数: ${snapshot.data!.length}');

          return Wrap(
            spacing: 3,
            runSpacing: 7,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.start,
            verticalDirection: VerticalDirection.down,
            clipBehavior: Clip.none,
            children: snapshot.data!.map((data) {
              return FutureBuilder<Map<String, dynamic>>(
                future: _fetchData(data['movie_id'] ?? 1),
                builder: (BuildContext context, AsyncSnapshot<Map<
                    String,
                    dynamic>> movieSnapshot) {
                  if (movieSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (movieSnapshot.hasError) {
                    return Text('エラー: ${movieSnapshot.error}');
                  } else if (!movieSnapshot.hasData) {
                    return const Text('映画データがありません');
                  } else {
                    return ThumbnailList(
                      imagePath: 'https://image.tmdb.org/t/p/original${movieSnapshot
                          .data?['poster_path'] ?? ''}',
                      movieId: movieSnapshot.data?['id'] ?? 1,
                      nextPageId: "0",
                    );
                  }
                },
              );
            }).toList(),
          );
        }
      },
    );
  }
}
