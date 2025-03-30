import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/state.dart';

extension HaloStateProviderString on StateProvider<String> {
  void uc() {
    u("");
  }

  void ua(String value) {
    u("$v$value");
  }
}
