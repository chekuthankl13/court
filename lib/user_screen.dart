import 'package:courtclick/core/config/constants.dart';
import 'package:courtclick/core/routes/app_routes.dart';
import 'package:courtclick/core/utils/utils.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  void _onUserTap(Map<String, String> user) {
    navigatorKey.currentState!.pushNamed(AppRoutes.home, arguments: user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  // Fixed width keeps a 2-column grid with "Add Profile" under the first column.
                  child: SizedBox(
                    width: 98 * 2 + 26,
                    child: Wrap(
                      spacing: 26,
                      runSpacing: 24,
                      children: [
                        for (final user in Constants.dummyUsers)
                          _ProfileTile(
                            name: user['name']!,
                            image: user['img']!,
                            onTap: () => _onUserTap(user),
                          ),
                        const _AddProfileTile(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(Constants.splash, height: 36),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  const new({required this.name, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 98,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                image,
                width: 98,
                height: 92,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddProfileTile extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 98,
      height: 116,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.black, size: 48),
          ),
          const SizedBox(height: 16),
          const Text(
            'Add Profile',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
