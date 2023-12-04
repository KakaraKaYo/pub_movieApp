import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../components/movie_page/gallery_row.dart';
import '../../components/movie_page/backimages.dart';
import '../../components/movie_page/staff_listview.dart';
import '../../components/movie_page/title_container.dart';
import '../../components/movie_page/overviewcontainer.dart';
import '../../components/movie_page/cast_listview.dart';
import '../../components/movie_page/logbutton_container.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../components/movie_page/movie_towebbutton.dart';
import '../../components/movie_page/similar_listview.dart';
import '../../db/database_helper.dart';
import '../../model/api_client.dart';
import '../../components/movie_page/positionedthumbnail.dart';
import '../../components/movie_page/reviewbar.dart';


/*
各映画の映画詳細情報を確認できるpage
 */


// 鑑賞回数の取得
Future<int> fetchWatchCount(int movieId) async {
  final watchCount = await DatabaseHelper.instance.getWatchCountByMovieId(movieId);
  return watchCount;
}

final watchCountProvider = FutureProvider.family<int, int>((ref, movieId) async {
  return await DatabaseHelper.instance.getWatchCountByMovieId(movieId);
});


class MovieDetailsPage extends ConsumerWidget {
  final int movieId;

  MovieDetailsPage({required this.movieId});

  bool containJapanese(String text) {
    return RegExp(r'[\u3040-\u309F]|\u3000|[\u30A1-\u30FC]|[\u4E00-\u9FFF]')
        .hasMatch(text);
  }

  bool isJapanese(String text) {
    final pattern = r'[\p{Script=Hiragana}\p{Script=Katakana}\p{Script=Han}]';
    final regex = RegExp(pattern, unicode: true);

    return regex.hasMatch(text);
  }

  Future<Map<String, dynamic>> _fetchData() async {
    String searchByIdApiEndPoint = 'https://api.themoviedb.org/3/movie/$movieId?api_key=$API_TOKEN&language=ja-JP';
    // APIエンドポイントへのHTTP GETリクエストを作成
    final response = await http.get(Uri.parse(searchByIdApiEndPoint));
    print("DETAILS API URL: ${searchByIdApiEndPoint}");
    print("DETAILS: ${json.decode(response.body)["overview"]}");

    // Movie Credits の API
    String searchCreditsByIdApiEndPoint = 'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$API_TOKEN&language=ja-JP';
    print("CREDITS API URL: ${searchCreditsByIdApiEndPoint}");
    final creditsResponse = await http.get(
        Uri.parse(searchCreditsByIdApiEndPoint));
    final creditsResponseList = json.decode(creditsResponse.body);


    // Videos の API
    String getMovieVideosUrl = 'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$API_TOKEN&language=ja-JP';
    print("VIDEOS API URL: ${getMovieVideosUrl}");
    final videosResponse = await http.get(Uri.parse(getMovieVideosUrl));
    final videosResponseList = json.decode(videosResponse.body);
    print("VIDEOS RESPONSE: ${videosResponseList}");


    // Images の API
    String getImagesUrl = 'https://api.themoviedb.org/3/movie/$movieId/images?api_key=$API_TOKEN';
    print("IMAGES API URL: ${getImagesUrl}");
    final imagesResponse = await http.get(Uri.parse(getImagesUrl));
    final imagesResponseList = json.decode(imagesResponse.body);
    print("IMAGES RESPONSE: ${imagesResponseList}");


    // Similar の API
    String getMovieSimilarUrl = 'https://api.themoviedb.org/3/movie/$movieId/similar?api_key=$API_TOKEN&language=ja-JP';
    final similarResponse = await http.get(Uri.parse(getMovieSimilarUrl));
    print("SIMILAR API URL: ${getMovieSimilarUrl}");
    if (similarResponse.statusCode != 200) {
      throw Exception('関連映画の読み込みに失敗しました');
    }
    final similarResponseData = json.decode(similarResponse.body);
    final similarMovies = similarResponseData["results"];


    // 類似映画をレスポンスマップに追加
    Map<String, dynamic> responseMap = json.decode(response.body);
    responseMap["similarMovies"] = similarMovies;


    final casts = creditsResponseList["cast"];
    final crews = creditsResponseList["crew"];
    final videos = videosResponseList["results"]; // 'results'を取得
    final images = imagesResponseList["backdrops"];
    final similarIds = videosResponseList["results"]; // 'results'を取得


    responseMap["casts"] = casts;
    responseMap["videos"] = videos;
    responseMap["images"] = images;
    print("CASTS: ${casts}");

    responseMap["crews"] = crews;
    print("CREWS: ${crews}");

    Map<String, dynamic> responseVideoMap = json.decode(videosResponse.body);
    responseVideoMap["videos"] = videos;
    print("VIDEOS: ${videos}");

    Map<String, dynamic> similarVideoMap = json.decode(similarResponse.body);
    similarVideoMap["id"] = similarIds;

    Map<String, dynamic> responseImagesMap = json.decode(imagesResponse.body);
    responseImagesMap["images"] = images;
    //print("VIDEOS: ${videos}");


    if (response.statusCode == 200) {
      // JSONレスポンスを解析する
      print("New API connect : $movieId");
      return responseMap;
    } else {
      throw Exception('APIからデータを取得できませんでした');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // watchCountProviderを使って鑑賞回数を非同期で取得
    final watchCountFuture = ref.watch(watchCountProvider(movieId));

    // watchCountProviderを使って鑑賞回数を非同期で取得
    final watchCount = ref.watch(watchCountProvider(movieId));



    return FutureBuilder<int>(
      future: fetchWatchCount(movieId), // 鑑賞回数を非同期で取得
      builder: (BuildContext context, AsyncSnapshot<int> watchCountSnapshot) {
        // 鑑賞回数のロードがまだ完了していない場合はローディングインジケータを表示
        if (watchCountSnapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // 鑑賞回数に基づいてAppBarのアクションを決定
        List<Widget> appBarActions = [];
        if (watchCountSnapshot.hasData && watchCountSnapshot.data! > 0) {
          appBarActions.add(
            IconButton(
              onPressed: () => context.go('/mylog/$movieId'),
              icon: const Icon(Icons.receipt),
            ),
          );
        }


        return Scaffold(
          body: FutureBuilder<Map<String, dynamic>>(
            future: _fetchData(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // データ取得中にローディングインジケータを表示する
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // データ取得に失敗した場合にエラーメッセージを表示する
                return Center(child: Text('エラー: ${snapshot.error}'));
              } else {
                // 取得したJSONデータから「id」の値を表示する
                final title = snapshot.data!['title'];
                final originTitle = snapshot.data!['original_title'];
                final overview = snapshot.data!['overview'];
                final backdropUrl = 'https://image.tmdb.org/t/p/original' + snapshot.data!['backdrop_path'];
                final posterUrl = 'https://image.tmdb.org/t/p/original${snapshot
                    .data!['poster_path']}';

                final casts = snapshot.data!['casts'];
                final crews = snapshot.data!['crews'];

                final double review = snapshot.data!['vote_average'];

                final releaseDate = snapshot.data!['release_date'];
                final DateTime parsedDate = DateTime.parse(releaseDate);
                final String formattedDate = DateFormat('yyyy/MM/dd').format(
                    parsedDate);

                final runtime = snapshot.data!['runtime'];

                final List<dynamic> genres = snapshot.data!['genres'];
                final String genresText = genres.map((genre) {
                  String genreName = genre['name'].toString();
                  // 「履歴」が取得された場合に「歴史」に変換
                  if (genreName == '履歴') {
                    genreName = '歴史';
                  }
                  return genreName;
                }).join(', ');


                final videos = snapshot.data!['videos'];
                final images = snapshot.data!['images'];


                final similarMovies = snapshot.data!['similarMovies'];
                print('SIMILAR MOVIES:${similarMovies}');


                return Scaffold(

                  appBar: AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Color
                          .fromRGBO(22, 22, 22, 1),),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    backgroundColor: Colors.white,
                    actions: appBarActions,
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Column(
                                  children: [
                                    BackImage(imagePath: backdropUrl),
                                    const SizedBox(height: 15),
                                    LogButtonContainer(movieId: movieId,),
                                  ],
                                ),
                                PositionedThumbnail(posterUrl: posterUrl),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 0, 15, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleContainer(
                                      title: title, origin_title: originTitle),
                                  ReviewBar(review: review,
                                    onRatingUpdate: (double value) {},),
                                  Text(
                                    "${formattedDate}上映,${runtime}分,${genresText}",
                                    style: TextStyle(fontSize: 12),),
                                  const SizedBox(height: 10,),
                                  MovieToWebButton(),
                                  OverviewContainer(overview: overview),
                                ]
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 0, 0, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  CastListView(casts: casts,),
                                  //キャスト一覧Widget
                                  StaffListView(crews: crews),
                                  //スタッフ一覧Widget
                                  GalleryRow(videos: videos, images: images,),
                                  //関連動画、画像一覧Widget
                                  SimilarListView(similarMovies: similarMovies),
                                  //関連作品用Widget
                                  const SizedBox(height: 40,),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}