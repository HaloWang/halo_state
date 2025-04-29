import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/state.dart';

extension HaloStateProviderNum<T extends num> on StateProvider<T> {
  /// add value
  void ua(T value) {
    final T nv = q + value as T;
    u(nv);
  }

  void uc() {
    u(0 as T);
  }
}
