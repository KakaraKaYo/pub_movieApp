import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../model/TmdbMovieResponse.dart';
import '../model/api_client.dart'; // API_TOKENが定義されていると仮定

final movieProvider = StateNotifierProvider<MovieNotifier, List<TmdbMovieResponse>>((ref) => MovieNotifier());

class MovieNotifier extends StateNotifier<List<TmdbMovieResponse>> {
  MovieNotifier() : super([]) {
    _fetchData();
  }

  int _currentPage = 1;

  Future<void> _fetchData() async {
    String apiEndPoint = 'https://api.themoviedb.org/3/movie/popular?api_key=$API_TOKEN&language=ja-JP&page=$_currentPage';
    final response = await http.get(Uri.parse(apiEndPoint));

    if (response.statusCode == 200) {
      final results = json.decode(response.body)["results"];
      List<TmdbMovieResponse> newMovies = results.map<TmdbMovieResponse>((result) {
        return TmdbMovieResponse(
            title: result["title"],
            id: result["id"],
            posterPath: result["poster_path"]
        );
      }).toList();

      state = [...state, ...newMovies]; // 既存のリストに新しい映画を追加
      _currentPage++;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<void> fetchNextPage() async {
    await _fetchData();
  }
}
