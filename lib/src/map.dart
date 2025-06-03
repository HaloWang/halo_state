import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/state.dart';

@Deprecated('Use state.q instead')
extension HaloStateProviderMap<K, V> on StateProvider<Map<K, V>> {
  /// set value for key
  @Deprecated('Use state.q = {...q, ...pairs} instead')
  void uv(Map<K, V> pairs) {
    final v = q;
    final newV = {...v, ...pairs};
    u(newV);
  }

  /// remove value
  @Deprecated('Use state.q = {...q}..remove(key) instead')
  void ur(K key) {
    final v = q;
    final newValue = {...v};
    newValue.remove(key);
    u(newValue);
  }

  /// get value for key
  @Deprecated('Use state.q[key] instead')
  V? get(K key) {
    return q[key];
  }

  /// clear map
  @Deprecated('Use state.q = {} instead')
  void uc() {
    u({});
  }
}
