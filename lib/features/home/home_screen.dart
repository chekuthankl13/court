import 'package:courtclick/features/home/cubit/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  /// Selected profile from the user screen: {"img": ..., "name": ...}
  final Map<String, String> user;

  const new({super.key, required this.user});

  static const _tabs = [
    (icon: Icons.home, activeIcon: Icons.home, label: 'Home'),
    (icon: Icons.search, activeIcon: Icons.search, label: 'Search'),
    (
      icon: Icons.video_library_outlined,
      activeIcon: Icons.video_library,
      label: 'Coming Soon',
    ),
    (
      icon: Icons.download_outlined,
      activeIcon: Icons.download,
      label: 'Downloads',
    ),
    (icon: Icons.menu, activeIcon: Icons.menu, label: 'More'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, index) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: IndexedStack(
                index: index,
                children: [
                  for (final tab in _tabs)
                    _DummyTab(title: tab.label, user: user),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: index,
              onTap: context.read<BottomNavCubit>().changeTab,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFF121212),
              selectedItemColor: Colors.white,
              unselectedItemColor: const Color(0xFF8C8C8C),
              selectedFontSize: 10,
              unselectedFontSize: 10,
              iconSize: 26,
              items: [
                for (final tab in _tabs)
                  BottomNavigationBarItem(
                    icon: Icon(tab.icon),
                    activeIcon: Icon(tab.activeIcon),
                    label: tab.label,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Placeholder for each tab until the real screens are implemented.
class _DummyTab extends StatelessWidget {
  final String title;
  final Map<String, String> user;

  const new({required this.title, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  user['img']!,
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              '$title screen\nProfile: ${user['name']}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
