import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:example/route/page_key.dart';

BuildContext? getContext() {
  return getNavigatorKey().currentState?.context;
}

GlobalKey<NavigatorState> getNavigatorKey() {
  return _navigatorKey;
}

final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");

final kRouter = GoRouter(
  debugLogDiagnostics: false,
  navigatorKey: _navigatorKey,
  initialLocation: () {
    return PageKey.home.path;
  }(),
  routes: [
    ...PageKey.values.map((e) => e.route),
  ],
);
