import 'package:flutter/material.dart';

class SimpleNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onProfileTap;

  const SimpleNavBar({Key? key, required this.title, this.onProfileTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.deepPurple,
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: onProfileTap ?? () {},
        ),
      ],
      elevation: 2,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
