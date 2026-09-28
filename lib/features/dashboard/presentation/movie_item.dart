class MovieItem {
  final int id;
  final String title;
  final String? poster;
  final String? backdrop;
  final String overview;
  final String language;
  final double? popularity;
  final double? voteAverage;
  final int? voteCount;
  final DateTime? releaseDate;

  const new({
    required this.id,
    required this.title,
    required this.poster,
    required this.backdrop,
    required this.overview,
    required this.language,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
  });
}
