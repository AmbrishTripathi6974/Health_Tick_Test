import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controller/tree_controller.dart';
import '../providers/tree_provider.dart';
import '../view/main_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  const fakeUserId = 'user_123'; // Replace with Firebase Auth logic

  final speciesAsync = ref.watch(speciesProvider);
  final treeRepo = ref.read(treeRepoProvider);

  final treeController = speciesAsync.maybeWhen(
    data: (speciesList) => TreeController(treeRepo, speciesList),
    orElse: () => TreeController(treeRepo, []),
  );

  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        name: 'main',
        builder: (context, state) => MainScreen(
          uid: fakeUserId,
          treeController: treeController,
        ),
      ),
    ],
  );
});
