// import 'package:flutter/material.dart';
// import 'package:halo_state/halo_state.dart';

// abstract class GlobalStateHolder {
//   final app = RawApp();

//   Future<void> init() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await app.init();
//     await _orderedInit();
//     await _unorderedInit();
//   }

//   /// Ordered init.
//   Future<void> _orderedInit() async {
//     for (final future in orderedInit) {
//       await future;
//     }
//   }

//   /// Unordered init.
//   Future<void> _unorderedInit() async {
//     await Future.wait(unorderedInit);
//   }

//   List<Future<dynamic>> get orderedInit;
//   Set<Future<dynamic>> get unorderedInit;
// }
