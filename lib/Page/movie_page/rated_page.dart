import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../model/api_client.dart';
import '../../../model/TmdbMovieResponse.dart';
import '../../components/common/thumbnail_list.dart';


/*
映画情報を確認するmovie_pageを構成しているpage
*/

class RatedPage extends ConsumerWidget {

  //APIによTmdbからトレンドの映画情報を取得
  Future<List<TmdbMovieResponse>> _fetchData() async {
    String getPopularApiEndPoint = 'https://api.themoviedb.org/3/movie/top_rated?api_key=' + API_TOKEN + '&language=ja-JP';
    // APIエンドポイントへのHTTP GETリクエストを作成
    final response = await http.get(Uri.parse(getPopularApiEndPoint));
    final results = json.decode(response.body)["results"];

    // results = [ {id:1, title"aa"}, {id:2, title:"bb"} ];
    List<TmdbMovieResponse> tmdbMovieResponseList = [];

    for(int i = 0; i < results.length; i++){
      //print(results[i]["title"]);
      TmdbMovieResponse movieResponse = TmdbMovieResponse(title: results[i]["title"], id: results[i]["id"], posterPath: results[i]["poster_path"]);
      tmdbMovieResponseList.add(movieResponse);
    }

    if (response.statusCode == 200) {
      // JSONレスポンスを解析する
      return tmdbMovieResponseList;
    } else {
      throw Exception('APIからデータを取得できませんでした');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<TmdbMovieResponse>>(
      future: _fetchData(),
      builder: (BuildContext context, AsyncSnapshot<List<TmdbMovieResponse>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          if (snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          }
          return SingleChildScrollView(
              child:Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),

                //APIで取得した映画のポスターを２０個Wrapで表示
                child:Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 3,
                          runSpacing: 7,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.horizontal,
                          runAlignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          clipBehavior: Clip.none,
                          children: snapshot.data!.map((movieResponse) {
                            return ThumbnailList(
                              imagePath: 'https://image.tmdb.org/t/p/original' + movieResponse.posterPath,
                              movieId: movieResponse.id,
                              nextPageId: "0",);
                          }).toList(),
                        ),
                      ),
                    ]),
              ),
            );
        }
      },
    );
  }
}
