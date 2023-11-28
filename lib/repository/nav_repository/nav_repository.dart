import 'dart:async';

class NavRepo {
  final StreamController<int> _navController = StreamController<int>();

  Stream<int> get currentIndexStream => _navController.stream;

  void updateIndex(int index) {
    _navController.sink.add(index);
  }

  void dispose() {
    _navController.close();
  }
}
