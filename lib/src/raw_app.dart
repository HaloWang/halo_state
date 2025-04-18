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

  // TODO: Check latest values
  void contextGot(BuildContext context) {
    final window = View.of(context);
    final dpi = window.devicePixelRatio;
    final rawViewPadding = window.viewPadding;
    final rawViewInsets = window.viewInsets;
    final rawPadding = window.padding;

    final size = window.physicalSize / dpi;
    final height = window.physicalSize.height / dpi;
    final width = window.physicalSize.width / dpi;
    final isPortrait = height > width;

    final paddingTop = rawPadding.top / dpi;
    final paddingBottom = rawPadding.bottom / dpi;
    final paddingLeft = rawPadding.left / dpi;
    final paddingRight = rawPadding.right / dpi;

    this.paddingTop.u(paddingTop);
    this.paddingBottom.u(paddingBottom);
    this.paddingLeft.u(paddingLeft);
    this.paddingRight.u(paddingRight);

    quantized33PaddingBottom.u((paddingBottom / 0.33).round() * 0.33);
    quantizedHalfPaddingBottom.u((paddingBottom / 0.5).round() * 0.5);
    quantizedQuarterPaddingBottom.u((paddingBottom / 0.25).round() * 0.25);
    quantizedIntPaddingBottom.u(paddingBottom.round().toDouble());

    screenWidth.u(size.width);
    screenHeight.u(size.height);

    final viewPaddingTop = rawViewPadding.top / dpi;
    final viewPaddingBottom = rawViewPadding.bottom / dpi;
    final viewPaddingLeft = rawViewPadding.left / dpi;
    final viewPaddingRight = rawViewPadding.right / dpi;

    this.viewPaddingTop.u(viewPaddingTop);
    this.viewPaddingBottom.u(viewPaddingBottom);
    this.viewPaddingLeft.u(viewPaddingLeft);
    this.viewPaddingRight.u(viewPaddingRight);

    final viewInsetsTop = rawViewInsets.top / dpi;
    final viewInsetsBottom = rawViewInsets.bottom / dpi;
    final viewInsetsLeft = rawViewInsets.left / dpi;
    final viewInsetsRight = rawViewInsets.right / dpi;

    viewInsetBottomIsZero.u(viewInsetsBottom == 0);

    this.viewInsetsTop.u(viewInsetsTop);
    this.viewInsetsBottom.u(viewInsetsBottom);
    this.viewInsetsLeft.u(viewInsetsLeft);
    this.viewInsetsRight.u(viewInsetsRight);

    final brightness = Theme.of(context).brightness;
    light.u(brightness == Brightness.light);

    this.isPortrait.u(isPortrait);
  }
}
