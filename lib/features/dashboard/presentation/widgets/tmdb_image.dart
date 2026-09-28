import 'package:cached_network_image/cached_network_image.dart';
import 'package:courtclick/core/config/config.dart';
import 'package:courtclick/core/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';

class TmdbImage extends StatelessWidget {
  final String? path;
  final Alignment alignment;

  const new({super.key, required this.path, this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    if (path == null || path!.isEmpty) return const _Fallback();
    return CachedNetworkImage(
      imageUrl: '${Config.imageUrl}$path',
      fit: BoxFit.cover,
      alignment: alignment,
      fadeInDuration: const Duration(milliseconds: 200),
      placeholder: (_, _) => const ShimmerBox(),
      errorWidget: (_, _, _) => const _Fallback(),
    );
  }
}

class _Fallback extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFF1F1F1F),
      child: Center(
        child: Icon(Icons.movie_outlined, color: Color(0xFF5A5A5A), size: 28),
      ),
    );
  }
}
