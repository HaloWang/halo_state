import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/state.dart';

extension HaloStateProviderMap<K, V> on StateProvider<Map<K, V>> {
  /// set value for key
  void uv(Map<K, V> pairs) {
    final v = this.v;
    final newV = {...v, ...pairs};
    u(newV);
  }

  /// remove value
  void ur(K key) {
    final v = this.v;
    final newValue = {...v};
    newValue.remove(key);
    u(newValue);
  }

  V? get(K key) {
    return v[key];
  }

  void uc() {
    u({});
  }
}
