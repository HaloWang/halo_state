import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/state.dart';

@Deprecated('Use state.q instead')
extension HaloStateProviderString on StateProvider<String> {
  /// clear string
  @Deprecated('Use state.q = "" instead')
  void uc() {
    q = "";
  }

  /// add value
  @Deprecated('Use state.q += value instead')
  void ua(String value) {
    q += value;
  }
}
