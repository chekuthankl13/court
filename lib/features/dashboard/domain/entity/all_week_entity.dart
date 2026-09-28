abstract class AllWeekEntity {
   final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  new({required this.page, required this.results, required this.totalPages, required this.totalResults});


}
  


abstract class Result {
    final bool adult;
    final String backdropPath;
    final int id;
    final String? title;
    final String? originalTitle;
    final String overview;
    final String posterPath;
    final String mediaType;
    final String originalLanguage;
    final List<int> genreIds;
    final double popularity;
    final DateTime? releaseDate;
    final bool softcore;
    final bool? video;
    final double voteAverage;
    final int voteCount;
    final String? name;
    final String? originalName;
    final DateTime? firstAirDate;
    final List<String>? originCountry;

    Result({
        required this.adult,
        required this.backdropPath,
        required this.id,
        required this.title,
        required this.originalTitle,
        required this.overview,
        required this.posterPath,
        required this.mediaType,
        required this.originalLanguage,
        required this.genreIds,
        required this.popularity,
        required this.releaseDate,
        required this.softcore,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
        required this.name,
       required  this.originalName,
        required this.firstAirDate,
        required this.originCountry,
    });

}



