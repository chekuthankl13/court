import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

const _baseColor = Color(0xFF1F1F1F);
const _highlightColor = Color(0xFF3A3A3A);

/// Wraps a skeleton layout in one shared shimmer animation.
/// Build the layout from [SkeletonBlock]s.
class Skeleton extends StatelessWidget {
  final Widget child;

  const new({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _baseColor,
      highlightColor: _highlightColor,
      child: child,
    );
  }
}

/// A plain grey block; shimmers when placed inside a [Skeleton].
class SkeletonBlock extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final bool circle;

  const new({
    super.key,
    this.width,
    this.height,
    this.radius = 2,
    this.circle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _baseColor,
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: circle ? null : BorderRadius.circular(radius),
      ),
    );
  }
}

/// A single self-contained shimmering box, e.g. an image placeholder.
class ShimmerBox extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeleton(child: SkeletonBlock(radius: 0));
  }
}
