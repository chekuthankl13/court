import 'package:courtclick/features/dashboard/presentation/movie_item.dart';
import 'package:courtclick/features/dashboard/presentation/widgets/tmdb_image.dart';
import 'package:flutter/material.dart';
import 'package:courtclick/core/utils/utils.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieItem movie;
  final String tag;

  const new({super.key, required this.movie, required this.tag});

  @override
  Widget build(BuildContext context) {
    final date = movie.releaseDate;
    final releaseText = date == null
        ? '-'
        : '${date.day.toString().padLeft(2, '0')}-'
              '${date.month.toString().padLeft(2, '0')}-${date.year}';

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _Backdrop(movie: movie, tag: tag),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                spaceHeight(8),
                Row(
                  children: [
                    if (date != null) ...[
                      Text(
                        '${date.year}',
                        style: const TextStyle(color: Color(0xFFBDBDBD)),
                      ),
                      spaceWidth(12),
                    ],
                    if (movie.voteAverage != null) ...[
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      spaceWidth(4),
                      Text(
                        movie.voteAverage!.toStringAsFixed(1),
                        style: const TextStyle(color: Color(0xFFBDBDBD)),
                      ),
                      spaceWidth(12),
                    ],
                    _Chip(text: movie.language.toUpperCase()),
                  ],
                ),
                spaceHeight(16),
                _WideButton(
                  icon: Icons.play_arrow,
                  label: 'Play',
                  background: Colors.white,
                  foreground: Colors.black,
                ),
                spaceHeight(8),
                _WideButton(
                  icon: Icons.download,
                  label: 'Download',
                  background: const Color(0xFF262626),
                  foreground: Colors.white,
                ),
                spaceHeight(16),
                Text(
                  movie.overview.isEmpty
                      ? 'No overview available.'
                      : movie.overview,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                spaceHeight(24),
                const Text(
                  'Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                spaceHeight(8),
                _InfoRow(
                  label: 'Language',
                  value: movie.language.toUpperCase(),
                ),
                _InfoRow(
                  label: 'Popularity',
                  value: movie.popularity?.toStringAsFixed(1) ?? '-',
                ),
                _InfoRow(
                  label: 'Rating',
                  value: movie.voteAverage == null
                      ? '-'
                      : '${movie.voteAverage!.toStringAsFixed(1)} / 10',
                ),
                _InfoRow(
                  label: 'Votes',
                  value: movie.voteCount?.toString() ?? '-',
                ),
                _InfoRow(label: 'Release date', value: releaseText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Backdrop extends StatelessWidget {
  final MovieItem movie;
  final String tag;

  const new({required this.movie, required this.tag});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            curve: Curves.easeIn,
            tag: tag,
            child: TmdbImage(path: movie.backdrop ?? movie.poster),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x99000000), Colors.transparent, Colors.black],
                stops: [0, 0.4, 1],
              ),
            ),
          ),
          const Center(
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Color(0x99000000),
              child: Icon(Icons.play_arrow, color: Colors.white, size: 36),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;

  const new({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: const Color(0xFF404040),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

class _WideButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color background;
  final Color foreground;

  const new({
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () {},
        style: FilledButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          minimumSize: const Size.fromHeight(42),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const new({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
