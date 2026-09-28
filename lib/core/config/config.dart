class Config {


  static final _baseUrl = "https://api.themoviedb.org/3";

  final imageUrl = "https://image.tmdb.org/t/p/w500";

  static final allWeek = "$_baseUrl/trending/all/week";
  static final nowPlaying = "$_baseUrl/movie/now_playing";
  static final popular = "$_baseUrl/movie/popular";
  static final topRated = "$_baseUrl/movie/top_rated";

  static final search = "$_baseUrl/search/movie?query=";
  static final coming = "$_baseUrl/movie/upcoming";
}
