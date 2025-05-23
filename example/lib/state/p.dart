import 'dart:async';
// ignore: unused_import
import 'dart:developer';

import 'package:example/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:halo_state/halo_state.dart';
import 'package:halo/halo.dart';

part "app.dart";

abstract class P {
  static final app = _App();

  static FV init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await app._init();
    await _unorderedInit();
  }

  static FV _unorderedInit() async {
    await Future.wait([]);
  }
}
