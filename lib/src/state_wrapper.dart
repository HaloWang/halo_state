import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/src/rc.dart';

/// Wrap the MaterialApp with UncontrolledProviderScope to get the global riverpod container
class StateWrapper extends StatelessWidget {
  final Widget child;

  const StateWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(container: rc, child: child);
  }
}
