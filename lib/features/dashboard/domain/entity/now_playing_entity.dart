abstract class NowPlayingEntity {
   final Dates dates;
    final int page;
    final List<NowPlayingResult> results;
    final int totalPages;
    final int totalResults;

  new({required this.dates, required this.page, required this.results, required this.totalPages, required this.totalResults});
}

  


abstract class Dates {
    final DateTime maximum;
    final DateTime minimum;

    Dates({
        required this.maximum,
        required this.minimum,
    });

}

 abstract class NowPlayingResult {
    final bool adult;
    final String backdropPath;
    final List<int> genreIds;
    final int id;
    final String title;
    final String originalLanguage;
    final String originalTitle;
    final String overview;
    final double popularity;
    final String posterPath;
    final DateTime releaseDate;
    final bool softcore;
    final bool video;
    final double voteAverage;
    final int voteCount;

    NowPlayingResult({
        required this.adult,
        required this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.title,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.releaseDate,
        required this.softcore,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

}

