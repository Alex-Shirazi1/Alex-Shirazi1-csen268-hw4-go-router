import 'dart:async';

import 'package:flutter/foundation.dart';

class StreamToListenable extends ChangeNotifier {
  StreamToListenable(List<Stream<dynamic>> streams) {
    for (final stream in streams) {
      _subscriptions.add(stream.listen((_) => notifyListeners()));
    }
  }
  final _subscriptions = <StreamSubscription<dynamic>>[];
  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }
}
