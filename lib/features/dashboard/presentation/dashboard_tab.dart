import 'package:courtclick/core/routes/app_routes.dart';
import 'package:courtclick/core/utils/utils.dart';
import 'package:courtclick/core/widgets/shimmer_box.dart';
import 'package:courtclick/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:courtclick/features/dashboard/presentation/movie_item.dart';
import 'package:courtclick/features/dashboard/presentation/widgets/tmdb_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void _openDetail(MovieItem movie, String tag) {
  navigatorKey.currentState!.pushNamed(
    AppRoutes.movieDetail,
    arguments: {"movie": movie, "tag": tag},
  );
}

class DashboardTab extends StatefulWidget {
  final String userName;

  const new({super.key, required this.userName});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<DashboardCubit>();
    if (cubit.state is! Loaded) cubit.loadHome();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        switch (state) {
          case Loading _:
            return _DashboardSkeleton();

          case Loaded ld:
            var week = ld.week;
            var nowPlaying = ld.nowPlaying;
            var popular = ld.popular;
            var topRated = ld.topRated;
            return _DashboardContent(
              userName: widget.userName,
              week: [
                for (final r in week.results)
                  MovieItem(
                    id: r.id,
                    title: r.title ?? r.name ?? '',
                    poster: r.posterPath,
                    backdrop: r.backdropPath,
                    overview: r.overview,
                    language: r.originalLanguage,
                    popularity: r.popularity,
                    voteAverage: r.voteAverage,
                    voteCount: r.voteCount,
                    releaseDate: r.releaseDate ?? r.firstAirDate,
                  ),
              ],
              nowPlaying: [
                for (final r in nowPlaying.results)
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
              popular: [
                for (final r in popular.results)
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
              topRated: [
                for (final r in topRated.results)
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
          case Error e:
            return _ErrorView(
              error: e.error,
              onRetry: context.read<DashboardCubit>().loadHome,
            );

          default:
            return _DashboardSkeleton();
        }
      },
    );
  }
}

//// data

class _DashboardContent extends StatelessWidget {
  final String userName;
  final List<MovieItem> week;
  final List<MovieItem> nowPlaying;
  final List<MovieItem> popular;
  final List<MovieItem> topRated;

  const new({
    required this.userName,
    required this.week,
    required this.nowPlaying,
    required this.popular,
    required this.topRated,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: const Color(0xFFE50914),
      backgroundColor: const Color(0xFF1F1F1F),
      // The hero sits under the status bar, so start the spinner below it.
      edgeOffset: MediaQuery.paddingOf(context).top,
      onRefresh: () => context.read<DashboardCubit>().loadHome(refresh: true),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          if (week.isNotEmpty) _Hero(movie: week.first),
          _Section(
            title: 'Previews',
            child: _PreviewRow(movies: nowPlaying),
          ),
          _Section(
            title: 'Continue Watching for $userName',
            child: _ContinueWatchingRow(movies: topRated),
          ),
          _Section(
            title: 'Popular on Netflix',
            child: _PosterRow(movies: popular, tag: "popular"),
          ),
          _Section(
            title: 'Trending Now',
            child: _PosterRow(movies: week.skip(1).toList(), tag: "trending"),
          ),
          _Section(
            title: 'Top 10 Today',
            child: _PosterRow(movies: topRated.take(10).toList(), tag: "top"),
          ),
          _Section(
            title: 'Netflix Originals',
            child: _PosterRow(
              movies: popular.reversed.toList(),
              tag: "original",
              width: 154,
              height: 251,
            ),
          ),
          _Section(
            title: 'New Releases',
            child: _PosterRow(movies: nowPlaying, tag: "new"),
          ),
          spaceHeight(24),
        ],
      ),
    );
  }
}

/// Loading
class _DashboardSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    Widget title() => const Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: SkeletonBlock(width: 180, height: 20),
    );

    Widget row({required double size, bool circle = false}) => SizedBox(
      height: circle ? size : size * 1.56,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        separatorBuilder: (_, _) => spaceWidth(7),
        itemBuilder: (_, _) => SkeletonBlock(
          width: size,
          height: circle ? size : size * 1.56,
          circle: circle,
        ),
      ),
    );

    return Skeleton(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          SkeletonBlock(width: width, height: width * 1.15, radius: 0),
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonBlock(width: 40, height: 40),
                SkeletonBlock(width: 110, height: 45, radius: 4),
                SkeletonBlock(width: 40, height: 40),
              ],
            ),
          ),
          title(),
          row(size: 102, circle: true),
          title(),
          row(size: 103),
          title(),
          row(size: 103),
        ],
      ),
    );
  }
}

//  hero

class _Hero extends StatelessWidget {
  final MovieItem movie;

  const new({required this.movie});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final topInset = MediaQuery.paddingOf(context).top;

    return Column(
      children: [
        SizedBox(
          height: width * 1.15,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: movie.id.toString() + movie.title,
                child: TmdbImage(
                  path: movie.poster,
                  alignment: Alignment.topCenter,
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xB3000000),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black,
                    ],
                    stops: [0, 0.25, 0.7, 1],
                  ),
                ),
              ),
              Positioned(
                top: topInset + 8,
                left: 12,
                right: 12,
                child: const _TopMenu(),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Text(
                        'TOP\n10',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 6,
                          height: 1,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    spaceWidth(6),
                    const Text(
                      '#1 in Trending Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _IconLabel(icon: Icons.add, label: 'My List'),
              FilledButton.icon(
                onPressed: () => _openDetail(movie, 'mylist-${movie.id}-i'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFC4C4C4),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(110, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                icon: const Icon(Icons.play_arrow, size: 32),
                label: const Text(
                  'Play',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              _IconLabel(
                icon: Icons.info_outline,
                label: 'Info',
                onTap: () => _openDetail(movie, 'infoc-${movie.id}-i'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TopMenu extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      color: Colors.white,
      fontSize: 17,
      fontWeight: FontWeight.w500,
    );
    return Row(
      children: [
        Image.asset('assets/images/logos_netflix-icon.png', height: 50),
        const Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('TV Shows', style: style),
              Text('Movies', style: style),
              Text('My List', style: style),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const new({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          spaceHeight(4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

//  rows

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const new({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  final List<MovieItem> movies;

  const new({required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 102,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: movies.length,
        separatorBuilder: (_, _) => spaceWidth(8),
        itemBuilder: (_, i) {
          final heroTag = 'priview-${movies[i].id}-$i';

          return GestureDetector(
            onTap: () => _openDetail(movies[i], heroTag),
            child: ClipOval(
              child: SizedBox(
                width: 102,
                height: 102,
                child: Hero(
                  tag: heroTag,
                  child: TmdbImage(path: movies[i].poster),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PosterRow extends StatelessWidget {
  final List<MovieItem> movies;
  final double width;
  final double height;
  final String tag;

  const new({
    required this.movies,
    required this.tag,
    this.width = 103,
    this.height = 161,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: movies.length,
        separatorBuilder: (_, _) => spaceWidth(7),
        itemBuilder: (_, i) {
          final heroTag = '$tag-${movies[i].id}-$i';

          return GestureDetector(
            onTap: () => _openDetail(movies[i], heroTag),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: SizedBox(
                width: width,
                child: Hero(
                  tag: heroTag,
                  child: TmdbImage(path: movies[i].poster),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ContinueWatchingRow extends StatelessWidget {
  final List<MovieItem> movies;

  const new({required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 177,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: movies.length,
        separatorBuilder: (_, _) => spaceWidth(7),
        itemBuilder: (_, i) {
          final heroTag = 'continue-${movies[i].id}-$i';

          final progress = 0.2 + (movies[i].id % 7) / 10;
          return GestureDetector(
            onTap: () => _openDetail(movies[i], heroTag),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: SizedBox(
                width: 103,
                child: Column(
                  children: [
                    Expanded(
                      child: Hero(
                        tag: heroTag,
                        child: TmdbImage(path: movies[i].poster),
                      ),
                    ),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 2,
                      color: const Color(0xFFE50914),
                      backgroundColor: const Color(0xFF4D4D4D),
                    ),
                    Container(
                      height: 36,
                      color: const Color(0xFF121212),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                          Icon(Icons.more_vert, color: Colors.white, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//  shared

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const new({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),
            spaceHeight(16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
