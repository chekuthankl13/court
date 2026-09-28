import 'package:courtclick/core/theme/app_theme.dart';
import 'package:courtclick/download_tab.dart';
import 'package:courtclick/features/coming/presentation/comming_tab.dart';
import 'package:courtclick/features/dashboard/presentation/dashboard_tab.dart';
import 'package:courtclick/features/home/cubit/bottom_nav_cubit.dart';
import 'package:courtclick/features/search/presentation/search_tab.dart';
import 'package:courtclick/more_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user, this.comingSoonCount = 2});

  final Map<String, String> user;
  final int comingSoonCount;

  static const _tabs = [
    (
      icon: CupertinoIcons.house,
      activeIcon: CupertinoIcons.house_fill,
      label: 'Home',
    ),
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

            body: IndexedStack(
              index: index,
              children: [
                DashboardTab(userName: user['name'] ?? ''),
                const SafeArea(child: SearchTab()),
                const SafeArea(child: CommingTab()),
                const SafeArea(child: DownloadTab()),
                SafeArea(child: MoreTab(user: user)),
              ],
            ),

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: index,
              onTap: context.read<BottomNavCubit>().changeTab,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppTheme.darkSurface,
              selectedItemColor: Colors.white,
              unselectedItemColor: const Color(0xFF8C8C8C),
              selectedFontSize: 10,
              unselectedFontSize: 10,
              iconSize: 26,

              items: [
                for (var i = 0; i < _tabs.length; i++)
                  BottomNavigationBarItem(
                    icon: i == 2
                        ? Badge.count(
                            count: comingSoonCount,
                            isLabelVisible: comingSoonCount > 0,
                            backgroundColor: const Color(0xFFE50914),
                            textColor: Colors.white,
                            maxCount: 99,
                            child: Icon(_tabs[i].icon),
                          )
                        : Icon(_tabs[i].icon),

                    activeIcon: i == 2
                        ? Badge.count(
                            count: comingSoonCount,
                            isLabelVisible: comingSoonCount > 0,
                            backgroundColor: const Color(0xFFE50914),
                            textColor: Colors.white,
                            maxCount: 99,
                            child: Icon(_tabs[i].activeIcon),
                          )
                        : Icon(_tabs[i].activeIcon),

                    label: _tabs[i].label,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
