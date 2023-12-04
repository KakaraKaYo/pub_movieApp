class TmdbMovieResponse {
  final int id; // 映画のid
  final String title; // 映画のタイトル
  final String posterPath; // 映画のポスターのURL
  const TmdbMovieResponse(
      {required this.title, required this.id, required this.posterPath});
}
