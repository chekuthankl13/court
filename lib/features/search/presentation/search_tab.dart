import 'dart:async';

import 'package:courtclick/core/routes/app_routes.dart';
import 'package:courtclick/core/utils/utils.dart';
import 'package:courtclick/core/widgets/shimmer_box.dart';
import 'package:courtclick/features/dashboard/cubit/dashboard_cubit.dart'
    as dashboard;
import 'package:courtclick/features/dashboard/presentation/movie_item.dart';
import 'package:courtclick/features/dashboard/presentation/widgets/tmdb_image.dart';
import 'package:courtclick/features/search/cubit/search_cubit.dart';
import 'package:courtclick/features/search/domain/entity/search_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTab extends StatefulWidget {
  const new({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    final query = value.trim();
    final cubit = context.read<SearchCubit>();
    if (query.isEmpty) {
      cubit.clear();
      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 500),
      () => cubit.search(query: query),
    );
  }

  void _onSubmitted(String value) {
    _debounce?.cancel();
    final query = value.trim();
    if (query.isNotEmpty) context.read<SearchCubit>().search(query: query);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SearchBar(
          controller: _controller,
          onChanged: _onChanged,
          onSubmitted: _onSubmitted,
        ),
        Expanded(
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return switch (state) {
                Loaded(:final data) =>
                  data.isEmpty
                      ? const _Message(text: 'No results found.')
                      : _ResultList(
                          title: 'Movies & TV',
                          movies: data.map(_toMovieItem).toList(),
                          onRefresh: context.read<SearchCubit>().refresh,
                        ),
                Loading() => const _ResultSkeleton(),
                Error(:final error) => _Message(text: error),
                _ => const _TopSearches(),
              };
            },
          ),
        ),
      ],
    );
  }
}

MovieItem _toMovieItem(SearchResult r) => MovieItem(
  id: r.id,
  title: r.title,
  poster: r.posterPath,
  backdrop: r.backdropPath,
  overview: r.overview,
  language: r.originalLanguage,
  popularity: r.popularity,
  voteAverage: r.voteAverage,
  voteCount: r.voteCount,
  releaseDate: r.releaseDate,
);

class _TopSearches extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<dashboard.DashboardCubit, dashboard.DashboardState>(
      builder: (context, state) {
        if (state is dashboard.Error) return const SizedBox.shrink();
        if (state is! dashboard.Loaded) return const _ResultSkeleton();
        return _ResultList(
          title: 'Top Searches',
          onRefresh: () =>
              context.read<dashboard.DashboardCubit>().loadHome(refresh: true),
          movies: [
            for (final r in state.popular.results)
              MovieItem(
                id: r.id,
                title: r.title,
                poster: r.posterPath,
                backdrop: r.backdropPath,
                overview: r.overview,
                language: r.originalLanguage,
                popularity: r.popularity,
                voteAverage: r.voteAverage,
                voteCount: r.voteCount,
                releaseDate: r.releaseDate,
              ),
          ],
        );
      },
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  const new({
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 52,
      color: const Color(0xFF424242),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.search,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: const InputDecoration(
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          hintText: 'Search for a show, movie, genre, e.t.c.',
          hintStyle: TextStyle(color: Color(0xFFC4C4C4), fontSize: 15),
          prefixIcon: Icon(Icons.search, color: Color(0xFFC4C4C4)),
          suffixIcon: Icon(Icons.mic, color: Color(0xFFC4C4C4)),
        ),
      ),
    );
  }
}

class _ResultList extends StatelessWidget {
  final String title;
  final List<MovieItem> movies;
  final RefreshCallback onRefresh;

  const new({
    required this.title,
    required this.movies,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: const Color(0xFFE50914),
      backgroundColor: const Color(0xFF1F1F1F),
      onRefresh: onRefresh,
      child: _list(),
    );
  }

  Widget _list() {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: movies.length + 1,
      separatorBuilder: (_, i) => spaceHeight(i == 0 ? 0 : 3),
      itemBuilder: (_, i) {
        if (i == 0) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 12),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return _ResultTile(movie: movies[i - 1]);
      },
    );
  }
}

class _ResultTile extends StatelessWidget {
  final MovieItem movie;

  const new({required this.movie});

  @override
  Widget build(BuildContext context) {
    final tag = 'search-${movie.id}';
    return GestureDetector(
      onTap: () => navigatorKey.currentState!.pushNamed(
        AppRoutes.movieDetail,
        arguments: {"movie": movie, "tag": tag},
      ),
      child: Container(
        height: 76,
        color: const Color(0xFF424242),
        child: Row(
          children: [
            SizedBox(
              width: 146,
              height: 76,
              child: Hero(
                tag: tag,
                child: TmdbImage(path: movie.backdrop ?? movie.poster),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 12),
            child: SkeletonBlock(width: 170, height: 26),
          ),
          for (var i = 0; i < 8; i++)
            Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Row(
                children: [
                  SkeletonBlock(width: 146, height: 76, radius: 0),
                  spaceWidth(16),
                  Expanded(child: SkeletonBlock(height: 14)),
                  spaceWidth(60),
                  SkeletonBlock(width: 30, height: 30, circle: true),
                  spaceWidth(8),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final String text;

  const new({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
