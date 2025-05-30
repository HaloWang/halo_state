import 'package:example/state/p.dart';
import 'package:example/route/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo_state/halo_state.dart';

void main() async {
  await P.init();
  runApp(const _StateWrapper());
}

class _StateWrapper extends StatelessWidget {
  const _StateWrapper();

  @override
  Widget build(BuildContext context) {
    P.app.firstContextGot(context);
    return StateWrapper(
      child: const _App(),
    );
  }
}

final v2 = qsf<String, int?>(null);
final v3 = qsff((_, String key) => 1);
final v4 = qs<int?>(null);
final v5 = qs<int?>(1);
final v6 = qs(2);
final v7 = qsn<int>();
final v8 = qs({"foo": "bar"});

class _App extends ConsumerWidget {
  const _App();

  void _test() {
    v6.q = 5;
    v6.q += 5;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(P.app.preferredThemeMode);
    return MaterialApp.router(
      routerConfig: kRouter,
      themeMode: themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      builder: (context, child) {
        return child!;
      },
    );
  }
}
