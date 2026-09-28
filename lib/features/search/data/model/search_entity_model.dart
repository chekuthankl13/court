import 'package:courtclick/features/search/domain/entity/search_entity.dart';

class SearchEntityModel extends SearchEntity {
  new({
    required super.page,
    required super.results,
    required super.totalPages,
    required super.totalResults,
  });

  factory SearchEntityModel.fromJson(Map<String, dynamic> json) =>
      SearchEntityModel(
        page: json["page"],
        results: List<SearchResultModel>.from(
          json["results"].map((x) => SearchResultModel.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class SearchResultModel extends SearchResult {
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

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        title: json["title"],
        originalLanguage: json["original_language"]!,
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        // Search results can have a missing or empty release date.
        releaseDate: DateTime.tryParse(json["release_date"] ?? ''),
        softcore: json["softcore"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );
}
