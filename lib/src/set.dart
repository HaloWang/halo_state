import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/state.dart';

extension HaloStateProviderSet<T> on StateProvider<Set<T>> {
  /// add value
  void ua(T value) {
    u({...v, value});
  }

  /// add list
  void ul(List<T> values) {
    u({...v, ...values});
  }

  /// remove value
  void ur(T value) {
    final newValue = v.where((v) => v != value);
    u({...newValue});
  }

  bool contains(T value) {
    return v.contains(value);
  }

  void uc() {
    u({});
  }
}
