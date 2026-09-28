import 'package:courtclick/features/dashboard/domain/entity/all_week_entity.dart';

class AllWeekEntityModel extends AllWeekEntity {
  new({
    required super.page,
    required super.results,
    required super.totalPages,
    required super.totalResults,
  });
  factory AllWeekEntityModel.fromJson(Map<String, dynamic> json) =>
      AllWeekEntityModel(
        page: json["page"],
        results: List<Result>.from(
          json["results"].map((x) => ResultModel.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class ResultModel extends Result {
  new({
    required super.adult,
    required super.backdropPath,
    required super.id,
    required super.title,
    required super.originalTitle,
    required super.overview,
    required super.posterPath,
    required super.mediaType,
    required super.originalLanguage,
    required super.genreIds,
    required super.popularity,
    required super.releaseDate,
    required super.softcore,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
    required super.name,
    required super.originalName,
    required super.firstAirDate,
    required super.originCountry,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    id: json["id"],
    title: json["title"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    mediaType: json["media_type"],
    originalLanguage: json["original_language"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    popularity: json["popularity"]?.toDouble(),
    releaseDate: json["release_date"] == null
        ? null
        : DateTime.parse(json["release_date"]),
    softcore: json["softcore"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    name: json["name"],
    originalName: json["original_name"],
    firstAirDate: json["first_air_date"] == null
        ? null
        : DateTime.parse(json["first_air_date"]),
    originCountry: json["origin_country"] == null
        ? null
        : List<String>.from(json["origin_country"]),
  );
}
