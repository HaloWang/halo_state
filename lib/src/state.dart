import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/rc.dart';

/// Generates a [StateProvider] initialized to the specified value.
StateProvider<V> qs<V>(V v) => StateProvider<V>((_) => v);

/// Generates a [Provider] using the provided createFn.
Provider<V> qp<V>(V Function(Ref<V> ref) createFn) => Provider<V>(createFn);

/// Generates a nullable [StateProvider], initialized to the provided value (or null).
StateProvider<V?> qsn<V>([V? v]) => qs<V?>(v);

/// Creates a [StateProviderFamily] that always starts with the specified initial value of type S.
///
/// Example:
/// ```dart
/// final provider = qsf<String, List>([]);
/// ```
StateProviderFamily<V, K> qsf<K, V>(V v) => StateProvider.family<V, K>((_, __) => v);

/// Creates a [StateProviderFamily] using the provided create function.
///
/// Example:
/// ```dart
/// final provider = qsff<String, String>((ref, String key) => '');
/// ```
StateProviderFamily<V, K> qsff<K, V>(V Function(Ref<V> ref, K arg) createFn) => StateProvider.family<V, K>(createFn);

extension HaloProviderListenable<V> on ProviderListenable<V> {
  /// Reads the current value.
  @Deprecated('Use q instead')
  V get v => rc.read(this);

  /// Reads the current value using shorthand `q`.
  V get q => rc.read(this);

  /// Listens only for the next value.
  void l(void Function(V next) listener, {bool fireImmediately = false}) {
    rc.listen(this, (_, V next) => listener(next), fireImmediately: fireImmediately);
  }

  /// Listens only for the next change.
  void lv(void Function() listener, {bool fireImmediately = false}) {
    rc.listen(this, (_, __) => listener(), fireImmediately: fireImmediately);
  }

  /// Listens and provides both previous and next values on change.
  void lb(void Function(V? previous, V next) listener, {bool fireImmediately = false}) {
    rc.listen(this, (previous, next) => listener(previous, next), fireImmediately: fireImmediately);
  }
}

extension HaloStateProvider<V> on StateProvider<V> {
  /// Reads the current state using shorthand `q`.
  V get q => rc.read(this);

  /// Sets the state to [value].
  set q(V value) {
    rc.read(notifier).state = value;
  }

  /// Updates the state to [value].
  @Deprecated('Use q instead')
  void u(V value) {
    rc.read(notifier).state = value;
  }
}

extension HaloStateProviderNull<V> on StateProvider<V?> {
  /// Clears the current state by setting it to null.
  void uc() {
    u(null);
  }
}
