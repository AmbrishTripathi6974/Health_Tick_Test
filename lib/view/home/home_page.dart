import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controller/progress_controller.dart';
import '../../controller/tree_controller.dart';
import '../../providers/progress_provider.dart';
import '../widgets/custom_appbar.dart';
import 'task_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String uid;
  final TreeController treeController;

  const HomeScreen({
    super.key,
    required this.uid,
    required this.treeController,
  });

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<bool> taskStatus = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF6F9),
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(title: "Today's Tasks"),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 24),
                for (int i = 0; i < 3; i++)
                  TaskCard(
                    index: i,
                    isChecked: taskStatus[i],
                    onChanged: (val) {
                      setState(() => taskStatus[i] = val!);
                    },
                  ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF386641),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  ),
                  onPressed: () async {
                    final completed = taskStatus.where((t) => t).length;

                    final progressController =
                        ProgressController(ref.read(userRepoProvider));

                    await progressController.submitProgress(
                      uid: widget.uid,
                      completedTasks: completed,
                      onGrow: () => widget.treeController.growTree(widget.uid, ref),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Progress submitted!"),
                    ));
                  },
                  child: const Text("Submit", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 40),
              ],
            ),
          )
        ],
      ),
    );
  }
}
