import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../components/my_page/mylog_page/score_container.dart';
import '../../components/my_page/mylog_page/tag_container.dart';
import '../../components/my_page/mylog_page/textreview_container.dart';
import '../../components/my_page/mylog_page/thumbnail_card.dart';
import '../../components/my_page/mylog_page/vertical_title.dart';
import '../../components/my_page/mylog_page/watch_ticket.dart';
import '../../db/database_helper.dart';
import '../../model/api_client.dart';
import 'package:http/http.dart' as http;



final reviewProvider = FutureProvider.family<Map<String, dynamic>?, int>((ref, movieId) async {
  return DatabaseHelper.instance.getReviewByMovieId(movieId);
});

// タグを取得するFutureProviderの定義
final tagsProvider = FutureProvider.family<List<String>, int>((ref, movieId) async {
  return DatabaseHelper.instance.getTagsByMovieId(movieId);
});




class MyLogPage extends ConsumerWidget {
  // 本ログページが表示する映画ID

  final int movieId;

  MyLogPage({required this.movieId});


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

    String searchByIdApiEndPoint = 'https://api.themoviedb.org/3/movie/' + movieId.toString() + '?api_key=' + API_TOKEN + '&language=ja-JP';
    // APIエンドポイントへのHTTP GETリクエストを作成
    final response = await http.get(Uri.parse(searchByIdApiEndPoint));
    print("DETAILS API URL: ${searchByIdApiEndPoint}");
    print("DETAILS: ${json.decode(response.body)["overview"]}");

    // Movie Credits の API
    String searchCreditsByIdApiEndPoint = 'https://api.themoviedb.org/3/movie/' + movieId.toString() + '/credits?api_key=' + API_TOKEN + '&language=ja-JP';
    print("CREDITS API URL: ${searchCreditsByIdApiEndPoint}");
    final creditsResponse = await http.get(Uri.parse(searchCreditsByIdApiEndPoint));
    final creditsResponseList = json.decode(creditsResponse.body);
    print('CREDIT:${creditsResponseList}');

    Map<String, dynamic> responseMap = json.decode(response.body);


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
    final reviewFuture = ref.watch(reviewProvider(movieId));
    //final tagsFuture = ref.watch(tagsProvider(movieId)); // タグ取得


    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
          future: _fetchData(),
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // データ取得中にローディングインジケータを表示する
              return Center(child: CircularProgressIndicator());
            }else if (snapshot.hasError) {
              // データ取得に失敗した場合にエラーメッセージを表示する
              return Center(child: Text('エラー: ${snapshot.error}'));
            }else {


              final title = snapshot.data!['title'];
              final originTitle = snapshot.data!['original_title'];
              final releaseDate = snapshot.data!['release_date'];
              final DateTime parsedDate = DateTime.parse(releaseDate);
              final String formattedDate = DateFormat('yyyy/MM/dd').format(parsedDate);
              final posterUrl = 'https://image.tmdb.org/t/p/original${snapshot.data!['poster_path']}';


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


              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios, color: Color.fromRGBO(22, 22, 22, 1),),
                    onPressed: () {
                      context.pop('my-page');
                      },
                  ),
                  actions: [
                    IconButton(onPressed: (){
                      context.go('/movie-details/$movieId');
                      }, icon: const Icon(Icons.receipt),)
                  ],
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.white,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height * 0.45,
                                    child:Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        ThumbnailCard(posterUrl: posterUrl),
                                        const Spacer(),
                                        VerticalTitle(
                                          text: title, originTitle: originTitle, formattedDate: formattedDate, runtime: runtime, genresText: genresText,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Text('-Christopher Nolan'),
                                  Text('-Cillian Murphy'),
                                  Text('-Emily Blunt'),
                                ]
                            ),
                          ),


                          const SizedBox(height: 60,),
                          const Text('／',style: TextStyle(fontSize: 20),),
                          const Text('Review',style: TextStyle(fontSize: 20),),
                          const SizedBox(height: 20,),
                          ScoreContainer(movieId:movieId),
                          const SizedBox(height: 30,),
                          const Divider(
                            thickness: 2,
                            color: Colors.black,
                            indent: 150,
                            endIndent: 150
                          ),
                          const SizedBox(height: 40),
                          TagContainer(movieId: movieId,),
                          const SizedBox(height: 40),
                          TextReviewContainer(movieId: movieId,),
                          const SizedBox(height: 40),

                          const SizedBox(height: 60,),
                          const Text('／',style: TextStyle(fontSize: 20),),
                          const Text('Tickets',style: TextStyle(fontSize: 20),),
                          const SizedBox(height: 20,),
                          WatchTicket(movieId:movieId),
                          const SizedBox(height: 20,),
                        ],
                ),
              ),
            ),
          ),

        );
      }
    }
        ),
    );

  }
}
