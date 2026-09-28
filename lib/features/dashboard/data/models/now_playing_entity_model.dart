import 'package:courtclick/features/dashboard/domain/entity/now_playing_entity.dart';

class NowPlayingEntityModel extends NowPlayingEntity {
  new({required super.dates, required super.page, required super.results, required super.totalPages, required super.totalResults});
  factory NowPlayingEntityModel.fromJson(Map<String, dynamic> json) => NowPlayingEntityModel(
    dates: DatesModel.fromJson(json["dates"]),
    page: json["page"],
    results: List<NowPlayingResultModel>.from(json["results"].map((x) => NowPlayingResultModel.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}

class NowPlayingResultModel extends NowPlayingResult {
  new({required super.adult, required super.backdropPath, required super.genreIds, required super.id, required super.title, required super.originalLanguage, required super.originalTitle, required super.overview, required super.popularity, required super.posterPath, required super.releaseDate, required super.softcore, required super.video, required super.voteAverage, required super.voteCount});
  
   factory NowPlayingResultModel.fromJson(Map<String, dynamic> json) => NowPlayingResultModel(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    title: json["title"],
    originalLanguage:json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    releaseDate: DateTime.parse(json["release_date"]),
    softcore: json["softcore"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );
}

class DatesModel extends Dates  {
  new({required super.maximum, required super.minimum});
    factory DatesModel.fromJson(Map<String, dynamic> json) => DatesModel(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );
}