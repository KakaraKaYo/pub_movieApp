import 'package:dup_movielist/components/my_page/mylog_page/flow_button.dart';
import 'package:flutter/material.dart';
import '../../../db/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../model/api_client.dart';
import '../../common/thumbnail_list.dart';



class WatchedList extends StatelessWidget {
  // DBに保存済みの視聴済みの映画のリストを取得する
  Future<List<Map<String, dynamic>>> _loadWatchRecords(SearchData searchData) async {
    var watchedMovieList = await DatabaseHelper.instance.getSortedWatchData(searchData);
    return watchedMovieList ?? [];
  }

  Future<Map<String, dynamic>> _fetchData(int movieId) async {
    String searchByIdApiEndPoint = 'https://api.themoviedb.org/3/movie/$movieId?api_key=$API_TOKEN&language=ja-JP';
    final response = await http.get(Uri.parse(searchByIdApiEndPoint));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movie data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchData>(
        builder: (context, searchData, child)
    {
      print("Notifyを受け取りました。sortType:" + searchData.sortType);


      return FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadWatchRecords(searchData),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('エラー: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('データがありません');
          } else {
            // Providerを使用してThumbnailListの数を更新
            print('ThumbnailListの数: ${snapshot.data!.length}');


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
                        nextPageId: "1",
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
    );
  }
}
