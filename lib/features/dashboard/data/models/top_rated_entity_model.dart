import 'package:courtclick/features/dashboard/domain/entity/top_rated_entity.dart';

class TopRatedEntityModel extends TopRatedEntity {
  new({required super.page, required super.results, required super.totalPages, required super.totalResults});
   factory TopRatedEntityModel.fromJson(Map<String, dynamic> json) =>
      TopRatedEntityModel(
        page: json["page"],
        results: List<TopRatedResultModel>.from(
          json["results"].map((x) => TopRatedResultModel.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class TopRatedResultModel extends TopRatedResult {
  new({required super.adult, required super.backdropPath, required super.genreIds, required super.id, required super.title, required super.originalLanguage, required super.originalTitle, required super.overview, required super.popularity, required super.posterPath, required super.releaseDate, required super.softcore, required super.video, required super.voteAverage, required super.voteCount});
  
    

  factory TopRatedResultModel.fromJson(Map<String, dynamic> json) => TopRatedResultModel(
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
    releaseDate: DateTime.parse(json["release_date"]),
    softcore: json["softcore"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );
}