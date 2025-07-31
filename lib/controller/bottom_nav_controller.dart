import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavIndexProvider =
    StateNotifierProvider<BottomNavController, int>((ref) {
  return BottomNavController();
});

class BottomNavController extends StateNotifier<int> {
  BottomNavController() : super(0);

  void setIndex(int index) => state = index;
}
