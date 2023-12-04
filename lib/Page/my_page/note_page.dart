import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dup_movielist/model/api_client.dart';

/*
鑑賞ずみの映画に対して記録した感想を確認できるpage
 */

class NotePage extends StatefulWidget {
  final int movieId;

  NotePage({required this.movieId});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

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
    String searchByIdApiEndPoint = 'https://api.themoviedb.org/3/movie/'+ widget.movieId.toString() +'?api_key=' + API_TOKEN + '&language=ja-JP';
// APIエンドポイントへのHTTP GETリクエストを作成
    final response = await http.get(Uri.parse(searchByIdApiEndPoint));
    print("DETAILS API URL: ${searchByIdApiEndPoint}");
    print("DETAILS: ${json.decode(response.body)["overview"]}");

// Movie Credits の API
    String searchCreditsByIdApiEndPoint = 'https://api.themoviedb.org/3/movie/'+ widget.movieId.toString() +'/credits?api_key=' + API_TOKEN + '&language=ja-JP';
    final credtisResponse = await http.get(Uri.parse(searchCreditsByIdApiEndPoint));
    final creditsResponseList = json.decode(credtisResponse.body);
    print("CREDITS: ${json.decode(credtisResponse.body)}");

    final casts = creditsResponseList["cast"];
//print("CASTS: ${casts}");

    final crews = creditsResponseList["crew"];
//print("CASTS: ${casts}");

    final actors = [];
    final directors = [];

    for(int i = 0; i < crews.length; i++) {
      print("${i}番目のクルーのジョブ： ${crews[i]["job"]}");
      if(crews[i]["job"].toString() == ("Director")){
        print("ディレクター");
        directors.add(crews[i]);
      }
    }
/*
    for(int i = 0; i < casts.length; i++) {
      //print(casts[i]["id"]);
      // Movie Credits の API
      int targetCastId = casts[i]["id"];
      String searchPersonByIdApiEndPoint = 'https://api.themoviedb.org/3/person/'+ targetCastId.toString() +'?api_key=' + API_TOKEN + '&language=ja-JP';
      final personResponse = await http.get(Uri.parse(searchPersonByIdApiEndPoint));
      final personResponseList = json.decode(personResponse.body);
      //print(personResponseList["name"]);
      for(int j = 0; j < personResponseList["also_known_as"].length; j++){
        if(containJapanese(personResponseList["also_known_as"][j]) && isJapanese(personResponseList["also_known_as"][j])){
          print(personResponseList["also_known_as"][j]);
        }
        //print("${personResponseList["also_known_as"][j]} -> ${containJapanese(personResponseList["also_known_as"][j])}");
      }
    }
    */
    if (response.statusCode == 200) {
// JSONレスポンスを解析する
      print("New API connect : ${widget.movieId}");
      return json.decode(response.body);
    } else {
      throw Exception('APIからデータを取得できませんでした');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON Fetcher'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchData(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
// データ取得中にローディングインジケータを表示する
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
// データ取得に失敗した場合にエラーメッセージを表示する
            return Center(child: Text('エラー: ${snapshot.error}'));
          } else {
// 取得したJSONデータから「id」の値を表示する
            final id = snapshot.data!['id'];
            final title = snapshot.data!['title'];
            final origin_title = snapshot.data!['original_title'];
            final origin_country = snapshot.data!['origin_country'];//取れてない
            final overview = snapshot.data!['overview'];
            final poster = snapshot.data!['poster_path'];
            return Column(
                children:[
                  Text('値: $id'),
                  Text('title:$title'),
                  Text('原題:$origin_title'),
                  Text('制作国:$origin_country'),
                  Text('あらすじ:$overview'),
                  Image.network('https://image.tmdb.org/t/p/original$poster'),
                ]);
          }
        },
      ),
    );
  }
}