import 'package:example/page/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum PageKey {
  home;

  String get path => "/$name";

  Widget get widget {
    switch (this) {
      case PageKey.home:
        return const PageHome();
    }
  }

  GoRoute get route => GoRoute(path: path, builder: (_, __) => widget);
}
