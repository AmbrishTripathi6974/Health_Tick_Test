import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/app_route.dart';
import 'repository/tree_repository.dart';
import 'providers/tree_provider.dart';
import 'firebase_options.dart';
import 'seed_data/seed_user_progree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const fakeUid = 'user_123';

  // 🔁 DEV ONLY: Seed Firestore for testing forest growth
  await seedUserProgressAndForest(fakeUid);

  runApp(
    ProviderScope(
      overrides: [
        treeRepoProvider.overrideWithValue(
          TreeRepository(FirebaseFirestore.instance),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF386641)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
