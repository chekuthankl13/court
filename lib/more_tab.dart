import 'package:courtclick/core/config/constants.dart';
import 'package:courtclick/core/routes/app_routes.dart';
import 'package:courtclick/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoreTab extends StatelessWidget {
  final Map<String, String> user;

  const new({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        spaceHeight(28),
        _Profiles(selected: user),
        spaceHeight(16),
        const _ManageProfiles(),
        spaceHeight(14),
        const _TellFriends(),
        const _MyList(),
        spaceHeight(10),
        for (final item in ['App Settings', 'Account', 'Help'])
          _MenuItem(label: item, onTap: () {}),
        _MenuItem(
          label: 'Sign Out',
          onTap: () => navigatorKey.currentState!.pushNamedAndRemoveUntil(
            AppRoutes.user,
            (_) => false,
          ),
        ),
      ],
    );
  }
}

//  profiles

class _Profiles extends StatelessWidget {
  final Map<String, String> selected;

  const new({required this.selected});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final profile in Constants.dummyUsers)
            _ProfileTile(
              profile: profile,
              isSelected: identical(profile, selected),
            ),
          const _AddTile(),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final Map<String, String> profile;
  final bool isSelected;

  const new({required this.profile, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final size = isSelected ? 70.0 : 62.0;
    return GestureDetector(
      onTap: isSelected
          ? null
          : () => navigatorKey.currentState!.pushReplacementNamed(
              AppRoutes.home,
              arguments: profile,
            ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(4, isSelected ? 0 : 4, 4, 0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                profile['img']!,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
            ),
            spaceHeight(6),
            SizedBox(
              width: size,
              child: Text(
                profile['name']!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFFBDBDBD),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddTile extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFBDBDBD)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 36),
    );
  }
}

class _ManageProfiles extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.edit, color: Color(0xFFBDBDBD), size: 14),
        spaceWidth(6),
        Text(
          'Manage Profiles',
          style: TextStyle(color: Color(0xFFBDBDBD), fontSize: 14),
        ),
      ],
    );
  }
}

class _TellFriends extends StatelessWidget {
  const new();

  static const _inviteLink = 'https://www.netflix.com/invite';

  void _copyLink(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: _inviteLink));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Link copied')));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1F1F1F),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.sms_outlined, color: Colors.white, size: 26),
              spaceWidth(10),
              Text(
                'Tell friends about Netflix.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          spaceHeight(10),
          const Text(
            'Share a link with your friends so they can join and start '
            'watching movies and TV shows together with you.',
            style: TextStyle(color: Colors.white, fontSize: 11, height: 1.6),
          ),
          spaceHeight(14),
          const Text(
            'Terms & Conditions',
            style: TextStyle(
              color: Color(0xFFBDBDBD),
              fontSize: 10,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFFBDBDBD),
            ),
          ),
          spaceHeight(18),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 38,
                  color: Colors.black,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    _inviteLink,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Color(0xFFBDBDBD), fontSize: 12),
                  ),
                ),
              ),
              spaceWidth(8),
              FilledButton(
                onPressed: () => _copyLink(context),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(97, 38),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                child: const Text(
                  'Copy Link',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          spaceHeight(16),
          SizedBox(
            height: 76,
            child: Row(
              children: [
                for (final (i, option) in Constants.dummyIcons.indexed) ...[
                  if (i > 0) const _ShareDivider(),
                  _ShareOption(
                    image: option['img']!,
                    name: option['name']!,
                    onTap: () {},
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

class _ShareOption extends StatelessWidget {
  final String image;
  final String name;
  final VoidCallback onTap;

  const new({required this.image, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Semantics(
          button: true,
          label: 'Share via $name',
          excludeSemantics: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  image,
                  width: 36,
                  height: 36,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShareDivider extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 42, color: const Color(0xFF5A5A5A));
  }
}

// menu

class _MyList extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF262626))),
      ),
      child: Row(
        children: [
          Icon(Icons.check, color: Colors.white, size: 30),
          spaceWidth(12),
          Text('My List', style: TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const new({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 9),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
