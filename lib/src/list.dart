import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/state.dart';

extension HaloStateProviderList<T> on StateProvider<List<T>> {
  /// add value
  void ua(T value) {
    u([...v, value]);
  }

  /// add list
  void ul(List<T> values) {
    u([...v, ...values]);
  }

  /// remove value
  void r(T value) {
    final newValue = v.where((v) => v != value);
    u([...newValue]);
  }

  /// remove value at index
  void ri(int index) {
    final newValue = [...v];
    if (0 <= index && index < newValue.length) {
      newValue.removeAt(index);
    }
    u(newValue);
  }

  bool contains(T value) {
    return v.contains(value);
  }

  void uc() {
    u([]);
  }
}
