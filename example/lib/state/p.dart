import 'dart:async';
// ignore: unused_import
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:example/main.dart';
import 'package:example/route/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:halo_state/halo_state.dart';
import 'package:halo/halo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part "app.dart";
part "preference.dart";

abstract class P {
  static final app = _App();
  static final preference = _Preference();

  static FV init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await app._init();
    await _unorderedInit();
  }

  static FV _unorderedInit() async {
    await Future.wait([
      preference._init(),
    ]);
  }
}
