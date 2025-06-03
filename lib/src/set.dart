import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/state.dart';

@Deprecated('Use state.q instead')
extension HaloStateProviderSet<T> on StateProvider<Set<T>> {
  /// add value
  @Deprecated('Use state.q = {...q, value} instead')
  void ua(T value) {
    q = {...q, value};
  }

  /// add list
  @Deprecated('Use state.q = {...q, ...values} instead')
  void ul(List<T> values) {
    q = {...q, ...values};
  }

  /// remove value
  @Deprecated('Use state.q = {...q}..remove(value) instead')
  void ur(T value) {
    final newValue = q.where((v) => v != value);
    q = {...newValue};
  }

  /// check if set contains value
  @Deprecated('Use state.q.contains(value) instead')
  bool contains(T value) {
    return q.contains(value);
  }

  /// clear set
  @Deprecated('Use state.q = {} instead')
  void uc() {
    q = {};
  }
}
