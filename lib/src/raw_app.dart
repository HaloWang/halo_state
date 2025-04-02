import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:halo_state/halo_state.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class RawApp {
  final version = qs("");
  final buildNumber = qs("");

  final isPortrait = qs(true);
  final screenHeight = qs(0.0);
  final screenWidth = qs(0.0);

  final light = qs(true);

  final paddingBottom = qs(0.0);
  final paddingLeft = qs(0.0);
  final paddingRight = qs(0.0);
  final paddingTop = qs(0.0);
  final viewInsetBottomIsZero = qs(false);
  final viewInsetsBottom = qs(0.0);
  final viewInsetsLeft = qs(0.0);
  final viewInsetsRight = qs(0.0);
  final viewInsetsTop = qs(0.0);
  final viewPaddingBottom = qs(0.0);
  final viewPaddingLeft = qs(0.0);
  final viewPaddingRight = qs(0.0);
  final viewPaddingTop = qs(0.0);

  /// Quantized with step 0.33 (0, 0.33, 0.66, 0.99, ...)
  final quantized33PaddingBottom = qs(0.0);

  /// Quantized with step 0.5 (0, 0.5, 1.0, 1.5, ...)
  final quantizedHalfPaddingBottom = qs(0.0);

  /// Quantized with step 0.25 (0, 0.25, 0.5, 0.75, ...)
  final quantizedQuarterPaddingBottom = qs(0.0);

  /// Quantized with step 1.0 (0, 1, 2, 3, ...)
  final quantizedIntPaddingBottom = qs(0.0);

  late final cacheDir = qsn<Directory>();
  late final documentsDir = qsn<Directory>();
  late final downloadsDir = qsn<Directory>();
  late final libraryDir = qsn<Directory>();
  late final supportDir = qsn<Directory>();
  late final tempDir = qsn<Directory>();

  Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;
    this.version.u(version);
    this.buildNumber.u(buildNumber);

    try {
      cacheDir.u(await getApplicationCacheDirectory());
    } catch (e) {
      if (kDebugMode) print("RawApp.init");
      if (kDebugMode) print("🚧 $e");
    }
    try {
      documentsDir.u(await getApplicationDocumentsDirectory());
    } catch (e) {
      if (kDebugMode) print("RawApp.init");
      if (kDebugMode) print("🚧 $e");
    }
    try {
      downloadsDir.u(await getDownloadsDirectory());
    } catch (e) {
      if (kDebugMode) print("RawApp.init");
      if (kDebugMode) print("🚧 $e");
    }
    if (Platform.isIOS || Platform.isMacOS) {
      try {
        libraryDir.u(await getLibraryDirectory());
      } catch (e) {
        if (kDebugMode) print("RawApp.init");
        if (kDebugMode) print("🚧 $e");
      }
    }
    try {
      supportDir.u(await getApplicationSupportDirectory());
    } catch (e) {
      if (kDebugMode) print("RawApp.init");
      if (kDebugMode) print("🚧 $e");
    }
    try {
      tempDir.u(await getTemporaryDirectory());
    } catch (e) {
      if (kDebugMode) print("RawApp.init");
      if (kDebugMode) print("🚧 $e");
    }
  }

  Future<void> firstContextGot(BuildContext context) async {
    await Future.delayed(Duration.zero);
    // ignore: use_build_context_synchronously
    contextGot(context);
  }

  void contextGot(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    paddingTop.u(padding.top);
    paddingBottom.u(padding.bottom);
    paddingLeft.u(padding.left);
    paddingRight.u(padding.right);

    quantized33PaddingBottom.u((padding.bottom / 0.33).round() * 0.33);
    quantizedHalfPaddingBottom.u((padding.bottom / 0.5).round() * 0.5);
    quantizedQuarterPaddingBottom.u((padding.bottom / 0.25).round() * 0.25);
    quantizedIntPaddingBottom.u(padding.bottom.round().toDouble());

    final size = MediaQuery.sizeOf(context);
    screenWidth.u(size.width);
    screenHeight.u(size.height);

    final viewPadding = MediaQuery.viewPaddingOf(context);
    viewPaddingTop.u(viewPadding.top);
    viewPaddingBottom.u(viewPadding.bottom);
    viewPaddingLeft.u(viewPadding.left);
    viewPaddingRight.u(viewPadding.right);

    final viewInsets = MediaQuery.viewInsetsOf(context);
    viewInsetBottomIsZero.u(viewInsets.bottom == 0);
    viewInsetsTop.u(viewInsets.top);
    viewInsetsBottom.u(viewInsets.bottom);
    viewInsetsLeft.u(viewInsets.left);
    viewInsetsRight.u(viewInsets.right);

    final brightness = Theme.of(context).brightness;
    light.u(brightness == Brightness.light);

    final orientation = MediaQuery.orientationOf(context);
    isPortrait.u(orientation == Orientation.portrait);
  }
}
