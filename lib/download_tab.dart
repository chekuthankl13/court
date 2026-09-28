import 'package:courtclick/features/home/cubit/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:courtclick/core/utils/utils.dart';

class DownloadTab extends StatelessWidget {
  const new({super.key});

  static const _searchTabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(24, 12, 0, 0),
          child: Text(
            'Smart Downloads',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        spaceHeight(40),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            'Introducing Downloads For You',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        spaceHeight(12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            "We'll download a personalised selection of movies and shows for "
            'you, so there’s always something to watch on your device.',
            style: TextStyle(color: Colors.white, fontSize: 11, height: 1.6),
          ),
        ),
        spaceHeight(26),
        Center(
          child: Container(
            width: 176,
            height: 176,
            decoration: const BoxDecoration(
              color: Color(0xFF424242),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.download_for_offline_outlined,
              color: Color(0xFF8C8C8C),
              size: 72,
            ),
          ),
        ),
        spaceHeight(20),
        FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF0071EB),
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(42),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          child: const Text(
            'SETUP',
            style: TextStyle(fontSize: 14, letterSpacing: 1),
          ),
        ),
        spaceHeight(50),
        Center(
          child: FilledButton(
            onPressed: () =>
                context.read<BottomNavCubit>().changeTab(_searchTabIndex),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF424242),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: const Size(0, 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            child: const Text(
              'Find Something to Download',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
