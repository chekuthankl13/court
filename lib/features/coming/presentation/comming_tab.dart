import 'package:courtclick/core/routes/app_routes.dart';
import 'package:courtclick/core/utils/utils.dart';
import 'package:courtclick/core/widgets/shimmer_box.dart';
import 'package:courtclick/features/coming/cubit/coming_cubit.dart';
import 'package:courtclick/features/coming/domain/entity/coming_soon_entity.dart';
import 'package:courtclick/features/dashboard/presentation/movie_item.dart';
import 'package:courtclick/features/dashboard/presentation/widgets/tmdb_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

const _genres = {
  28: 'Action',
  12: 'Adventure',
  16: 'Animation',
  35: 'Comedy',
  80: 'Crime',
  99: 'Documentary',
  18: 'Drama',
  10751: 'Family',
  14: 'Fantasy',
  36: 'History',
  27: 'Horror',
  10402: 'Music',
  9648: 'Mystery',
  10749: 'Romance',
  878: 'Sci-Fi',
  10770: 'TV Movie',
  53: 'Thriller',
  10752: 'War',
  37: 'Western',
};

void _openDetail(ComingSoonResult r, String tag) {
  navigatorKey.currentState!.pushNamed(
    AppRoutes.movieDetail,
    arguments: {
      "movie": MovieItem(
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
      "tag": tag,
    },
  );
}

class CommingTab extends StatefulWidget {
  const new({super.key});

  @override
  State<CommingTab> createState() => _CommingTabState();
}

class _CommingTabState extends State<CommingTab> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<ComingCubit>();
    if (cubit.state is! Loaded) cubit.loadComingSoon();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComingCubit, ComingState>(
      builder: (context, state) {
        switch (state) {
          case Loading _:
            return _ComingSkeleton();
          case Error e:
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      e.error,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    spaceHeight(16),
                    ElevatedButton(
                      onPressed: context.read<ComingCubit>().loadComingSoon,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );

          case Loaded cd:
            return _ComingList(movies: cd.data.results);
          default:
            return _ComingSkeleton();
        }
      },
    );
  }
}

class _ComingList extends StatelessWidget {
  final List<ComingSoonResult> movies;

  const new({required this.movies});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: const Color(0xFFE50914),
      backgroundColor: const Color(0xFF1F1F1F),
      onRefresh: () =>
          context.read<ComingCubit>().loadComingSoon(refresh: true),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const _NotificationsHeader(),
          if (movies.isNotEmpty)
            _Notifications(movies: movies.take(2).toList()),
          for (final movie in movies) _ComingItem(movie: movie),
        ],
      ),
    );
  }
}

/// Loading
class _ComingSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Skeleton(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 16, 14, 14),
            child: SkeletonBlock(width: 150, height: 22),
          ),
          for (var i = 0; i < 2; i++)
            Padding(
              padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
              child: Row(
                children: [
                  SkeletonBlock(width: 112, height: 56),
                  spaceWidth(30),
                  Expanded(child: SkeletonBlock(height: 40)),
                ],
              ),
            ),
          for (var i = 0; i < 2; i++) ...[
            spaceHeight(24),
            SkeletonBlock(width: width, height: width * 195 / 375, radius: 0),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBlock(width: 140, height: 12),
                  spaceHeight(10),
                  SkeletonBlock(width: 200, height: 20),
                  spaceHeight(10),
                  SkeletonBlock(height: 11),
                  spaceHeight(6),
                  SkeletonBlock(height: 11),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NotificationsHeader extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14, 16, 14, 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: Color(0xFFE50914),
            child: Icon(Icons.notifications, color: Colors.white, size: 15),
          ),
          spaceWidth(10),
          Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _Notifications extends StatelessWidget {
  final List<ComingSoonResult> movies;

  const new({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF424242),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        children: [
          for (final movie in movies)
            GestureDetector(
              onTap: () => _openDetail(movie, 'notification-${movie.id}'),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: SizedBox(
                        width: 112,
                        height: 56,
                        child: Hero(
                          tag: 'notification-${movie.id}',
                          child: TmdbImage(
                            path: movie.backdropPath ?? movie.posterPath,
                          ),
                        ),
                      ),
                    ),
                    spaceWidth(30),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'New Arrival',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            movie.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          if (movie.releaseDate != null)
                            Text(
                              '${_months[movie.releaseDate!.month - 1].substring(0, 3)} '
                              '${movie.releaseDate!.day}',
                              style: const TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 11,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// coming item

class _ComingItem extends StatelessWidget {
  final ComingSoonResult movie;

  const new({required this.movie});

  @override
  Widget build(BuildContext context) {
    final date = movie.releaseDate;
    final tags = [
      for (final id in movie.genreIds)
        if (_genres[id] != null) _genres[id]!,
    ];
    final tag = 'coming-${movie.id}';

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _openDetail(movie, tag),
            child: AspectRatio(
              aspectRatio: 375 / 195,
              child: Hero(
                tag: tag,
                child: TmdbImage(path: movie.backdropPath ?? movie.posterPath),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _Action(icon: Icons.notifications, label: 'Remind Me'),
                spaceWidth(30),
                _Action(icon: Icons.share, label: 'Share'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 14, 12, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (date != null)
                  Text(
                    'Coming ${_months[date.month - 1]} ${date.day}',
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                spaceHeight(8),
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                spaceHeight(10),
                Text(
                  movie.overview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFE0E0E0),
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
                if (tags.isNotEmpty) ...[
                  spaceHeight(12),
                  Text(
                    tags.join('  •  '),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String label;

  const new({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 26),
        spaceHeight(4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
      ],
    );
  }
}
