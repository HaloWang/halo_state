import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/state.dart';

@Deprecated('Use state.q instead')
extension HaloStateProviderList<T> on StateProvider<List<T>> {
  /// add value
  @Deprecated('Use state.q = [...q, value] instead')
  void ua(T value) {
    u([...q, value]);
  }

  /// add list
  @Deprecated('Use state.q = [...q, ...values] instead')
  void ul(List<T> values) {
    u([...q, ...values]);
  }

  /// remove value
  @Deprecated('Use state.q = q.where((v) => v != value).toList() instead')
  void r(T value) {
    final newValue = q.where((v) => v != value);
    u([...newValue]);
  }

  /// remove value at index
  @Deprecated("Use state.q = q.where((v, i) => i != index).toList() instead")
  void ri(int index) {
    final newValue = [...q];
    if (0 <= index && index < newValue.length) {
      newValue.removeAt(index);
    }
    u(newValue);
  }

  /// check if list contains value
  @Deprecated('Use state.q.contains(value) instead')
  bool contains(T value) {
    return q.contains(value);
  }

  @Deprecated('Use state.q = [] instead')
  void uc() {
    u([]);
  }
}
