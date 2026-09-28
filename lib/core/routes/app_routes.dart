import 'package:courtclick/features/dashboard/presentation/movie_detail_screen.dart';
import 'package:courtclick/features/dashboard/presentation/movie_item.dart';
import 'package:courtclick/features/home/home_screen.dart';
import 'package:courtclick/splash_screen.dart';
import 'package:courtclick/user_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const user = '/user';
  static const splash = '/splash';
  static const home = '/home';
  static const movieDetail = '/movie-detail';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case user:
        return _route(const UserScreen());
      case splash:
        return _route(const SplashScreen());
      case home:
        return _route(
          HomeScreen(user: settings.arguments as Map<String, String>),
        );
      case movieDetail:
        var args = settings.arguments as Map<String, dynamic>;
        return _route(
          MovieDetailScreen(
            movie: args['movie'] as MovieItem,
            tag: args['tag'],
          ),
        );
      default:
        return null;
    }
  }
}

Route<dynamic> _route(Widget screen) => PageRouteBuilder(
  pageBuilder: (_, _, _) => screen,
  transitionDuration: const Duration(milliseconds: 350),
  reverseTransitionDuration: const Duration(milliseconds: 300),
  transitionsBuilder: (_, animation, _, child) {
    final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(curved),
      child: FadeTransition(opacity: curved, child: child),
    );
  },
);
