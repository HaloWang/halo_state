import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/state.dart';

extension HaloStateProviderSet<T> on StateProvider<Set<T>> {
  /// add value
  void ua(T value) {
    u({...q, value});
  }

  /// add list
  void ul(List<T> values) {
    u({...q, ...values});
  }

  /// remove value
  void ur(T value) {
    final newValue = q.where((v) => v != value);
    u({...newValue});
  }

  bool contains(T value) {
    return q.contains(value);
  }

  void uc() {
    u({});
  }
}
