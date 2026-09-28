import 'package:courtclick/features/coming/domain/entity/coming_soon_entity.dart';

class ComingSoonEntityModel extends ComingSoonEntity {
  new({
    required super.dates,
    required super.page,
    required super.results,
    required super.totalPages,
    required super.totalResults,
  });
  factory ComingSoonEntityModel.fromJson(Map<String, dynamic> json) =>
      ComingSoonEntityModel(
        dates: ComingSoonDatesModel.fromJson(json["dates"]),
        page: json["page"],
        results: List<ComingSoonResultModel>.from(
          json["results"].map((x) => ComingSoonResultModel.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class ComingSoonDatesModel extends ComingSoonDates {
  new({required super.maximum, required super.minimum});
  factory ComingSoonDatesModel.fromJson(Map<String, dynamic> json) =>
      ComingSoonDatesModel(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );
}

class ComingSoonResultModel extends ComingSoonResult {
  new({
    required super.adult,
    required super.backdropPath,
    required super.genreIds,
    required super.id,
    required super.title,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    required super.releaseDate,
    required super.softcore,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
  });

  factory ComingSoonResultModel.fromJson(Map<String, dynamic> json) =>
      ComingSoonResultModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        title: json["title"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        // Upcoming titles can have a missing or empty release date.
        releaseDate: DateTime.tryParse(json["release_date"] ?? ''),
        softcore: json["softcore"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );
}
