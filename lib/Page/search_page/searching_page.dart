import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../components/common/thumbnail_list.dart';
import '../../model/api_client.dart';



final searchTextProvider = StateProvider<String>((ref) => '');

// moviesProviderの定義
final moviesProvider = StateProvider<List<Map<String, dynamic>>>((ref) => []);

class SearchingPage extends ConsumerWidget {

  bool containJapanese(String text) {
    return RegExp(r'[\u3040-\u309F]|\u3000|[\u30A1-\u30FC]|[\u4E00-\u9FFF]')
        .hasMatch(text);
  }

  bool isJapanese(String text) {
    final pattern = r'[\p{Script=Hiragana}\p{Script=Katakana}\p{Script=Han}]';
    final regex = RegExp(pattern, unicode: true);

    return regex.hasMatch(text);
  }




  final FocusNode focusNode = FocusNode();
  bool isFirstLoad = true;

  Future<void> _fetchData(WidgetRef ref) async {
    final searchText = ref.read(searchTextProvider);
    String searchMovieApiEndPoint = 'https://api.themoviedb.org/3/search/movie?api_key=' + API_TOKEN + '&query=' + Uri.encodeComponent(searchText) + '&include_adult=true&language=ja-JP';

    try {
      var response = await http.get(Uri.parse(searchMovieApiEndPoint));
      var jsonData = json.decode(response.body);

      List<Map<String, dynamic>> movies = [];
      for (var item in jsonData['results']) {
        movies.add({
          'id': item['id'],
          'poster_path': item['poster_path'],
          // 他に必要なデータがあればここで追加
        });
      }

      // 'movies' リストをStateProviderを使って状態管理する
      ref.read(moviesProvider.notifier).state = movies;
    } catch (e) {
      print('エラー発生: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchTextProvider);
    final movies = ref.watch(moviesProvider); // 映画のリストを取得

    if (isFirstLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        focusNode.requestFocus();
        isFirstLoad = false;
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: (){context.pop();},
              icon: Icon(Icons.arrow_back)
          ),
          title: Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromRGBO(231, 231, 231, 1),
            ),
            child: TextField(
              focusNode: focusNode,
              onChanged: (value) => ref.read(searchTextProvider.notifier).state = value,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => _fetchData(ref), // 検索ボタンが押されたときに_fetchDataを実行
            ),
          ],
        ),
        body: SingleChildScrollView(
    child:Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),

          //APIで取得した映画のポスターを２０個Wrapで表示
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 7,
              childAspectRatio: (1000) / (1500),
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              var movie = movies[index];
              return ThumbnailList(
                imagePath: 'https://image.tmdb.org/t/p/original${movie['poster_path']}',
                movieId: movie['id'],
                nextPageId: "0",
              );
            },
          ),
        ),
        ),
      ),
    );
  }
}
