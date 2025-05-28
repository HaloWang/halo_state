import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/state.dart';

extension HaloStateProviderList<T> on StateProvider<List<T>> {
  /// add value
  void ua(T value) {
    u([...q, value]);
  }

  /// add list
  void ul(List<T> values) {
    u([...q, ...values]);
  }

  /// remove value
  void r(T value) {
    final newValue = q.where((v) => v != value);
    u([...newValue]);
  }

  /// remove value at index
  void ri(int index) {
    final newValue = [...q];
    if (0 <= index && index < newValue.length) {
      newValue.removeAt(index);
    }
    u(newValue);
  }

  bool contains(T value) {
    return q.contains(value);
  }

  @Deprecated('Use state.q = [] instead')
  void uc() {
    u([]);
  }
}
