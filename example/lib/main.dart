import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/halo_state.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StateWrapper(
      child: MaterialApp(
        home: const _Scaffold(),
      ),
    );
  }
}

class _Scaffold extends ConsumerWidget {
  static final v = qs(0);
  static final _focusNode = FocusNode();

  const _Scaffold();

  void _onPressed() {
    v.ua(1);
  }

  void _onTap() {
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final v = ref.watch(_Scaffold.v);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        child: Icon(Icons.add),
      ),
      body: GestureDetector(
        onTap: _onTap,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Hello World! $v'),
              ),
              TextField(
                focusNode: _focusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
