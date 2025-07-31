import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  const CustomSliverAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 120,
      backgroundColor: const Color(0xFF386641),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 12),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
