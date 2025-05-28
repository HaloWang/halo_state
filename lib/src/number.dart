import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/state.dart';

@Deprecated('Use state.q instead')
extension HaloStateProviderNum<T extends num> on StateProvider<T> {
  /// add value
  @Deprecated('Use state.q += value instead')
  void ua(T value) {
    final T nv = q + value as T;
    u(nv);
  }

  @Deprecated('Use state.q = 0 instead')
  void uc() {
    u(0 as T);
  }
}
