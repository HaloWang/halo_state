import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/rc.dart';

/// Generate an [StateProvider] with given initialValue and T
StateProvider<T> qs<T>(T v) => StateProvider<T>((_) => v);

/// Create an [StateProviderFamily] with given [State] initialValue
StateProviderFamily<State, Arg> qsf<State, Arg>(State v) => StateProvider.family<State, Arg>((_, __) => v);

/// Create an [StateProviderFamily] with given [State] initialValue
const qsff = StateProvider.family;

/// Generate an [StateProvider] with null and T?
StateProvider<T?> qsn<T>([T? v]) => qs<T?>(v);

/// Generate a [Provider] with given createFn and T
Provider<T> qp<T>(T Function(Ref<T> ref) createFn) => Provider<T>(createFn);

extension HaloProviderListenable<T> on ProviderListenable<T> {
  /// Read the value
  T get v => rc.read(this);

  /// Read the value
  ///
  /// Using "Q" because is the letter with the least frequency in English and coding.
  T get q => rc.read(this);

  /// Listen only next value
  void l(void Function(T next) listener, {bool fireImmediately = false}) {
    rc.listen(this, (_, T next) => listener(next), fireImmediately: fireImmediately);
  }

  /// Listen only next value's change
  void lv(void Function() listener, {bool fireImmediately = false}) {
    rc.listen(this, (_, __) => listener(), fireImmediately: fireImmediately);
  }

  /// Listen both previous and next value
  void lb(void Function(T? previous, T next) listener, {bool fireImmediately = false}) {
    rc.listen(this, (previous, next) => listener(previous, next), fireImmediately: fireImmediately);
  }
}

extension HaloStateProvider<T> on StateProvider<T> {
  /// Read the value
  ///
  /// Using "Q" because is the letter with the least frequency in English and coding.
  T get q => rc.read(this);

  /// Set the value.
  ///
  /// Using "Q" because is the letter with the least frequency in English and coding.
  set q(T value) {
    rc.read(notifier).state = value;
  }

  /// Set the value
  void u(T value) {
    rc.read(notifier).state = value;
  }
}

extension HaloStateProviderNull<T> on StateProvider<T?> {
  void uc() {
    u(null);
  }
}

