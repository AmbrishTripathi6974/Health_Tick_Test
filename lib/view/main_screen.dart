import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controller/tree_controller.dart';
import '../../view/forest/forest_page.dart';
import '../controller/bottom_nav_controller.dart';
import 'home/home_page.dart';

class MainScreen extends ConsumerWidget {
  final String uid;
  final TreeController treeController;

  const MainScreen({
    super.key,
    required this.uid,
    required this.treeController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomNavIndexProvider);
    final controller = ref.read(bottomNavIndexProvider.notifier);

    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [
          HomeScreen(uid: uid, treeController: treeController),
          ForestPage(uid: uid),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: controller.setIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_rounded),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forest_rounded),
            label: 'Forest',
          ),
        ],
      ),
    );
  }
}
