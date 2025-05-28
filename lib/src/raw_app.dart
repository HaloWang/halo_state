import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:halo_state/halo_state.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

abstract class RawApp with WidgetsBindingObserver {
  final version = qs("");
  final buildNumber = qs("");

  final isPortrait = qs(true);

  final screenHeight = qs(0.0);
  final screenWidth = qs(0.0);

  /// 当前操作系统的主题模式
  late final systemBrightness = qp((ref) {
    return ref.watch(_systemBrightness);
  });

  /// App 当前是否是 light mode, 而非 dark mode
  late final light = qp((ref) {
    final preferredThemeMode = ref.watch(this.preferredThemeMode);
    if (preferredThemeMode == ThemeMode.light) return true;
    if (preferredThemeMode == ThemeMode.dark) return false;
    return ref.watch(systemBrightness) == Brightness.light;
  });

  /// App 当前是否是 dark mode, 而非 light mode
  late final dark = qp((ref) {
    return !ref.watch(light);
  });

  /// 如果 [RawApp.light] 为 true, 该值为 0xFFFFFFFF, 否则为 0xFF000000
  final qw = qs(const Color(0xFFFFFFFF));

  /// 如果 [RawApp.light] 为 true, 该值为 0xFF000000, 否则为 0xFFFFFFFF
  final qb = qs(const Color(0xFF000000));

  late final lifecycleState = qp((ref) {
    return ref.watch(_lifecycleState);
  });
  final _lifecycleState = qs(AppLifecycleState.resumed);

  /// App 所偏好的主题模式, 默认为 system, 即跟随系统, 是一个内存状态
  ///
  /// 如果不手动设置, 则默认跟随系统主题模式
  final preferredThemeMode = qs(ThemeMode.system);
  final _systemBrightness = qs(Brightness.light);

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

  late final cacheDir = qs<Directory?>(null);
  late final documentsDir = qs<Directory?>(null);
  late final downloadsDir = qs<Directory?>(null);
  late final libraryDir = qs<Directory?>(null);
  late final supportDir = qs<Directory?>(null);
  late final tempDir = qs<Directory?>(null);

  Future<void> init() async {
    WidgetsBinding.instance.addObserver(this);

    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;
    this.version.q = version;
    this.buildNumber.q = buildNumber;

    if (kDebugMode) {
      Future.delayed(const Duration(seconds: 1), () {
        final context = this.context;
        if (context == null) return;
        if (context.mounted) FocusScope.of(context).unfocus();
      });
    }

    light.lv(_onLightChanged);

    await _syncAllDir();
  }

  void _onLightChanged() {
    final isLight = light.q;
    qw.q = isLight ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
    qb.q = isLight ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  }

  Future<void> _syncAllDir() async {
    try {
      cacheDir.q = await getApplicationCacheDirectory();
    } catch (e) {
      if (kDebugMode) print("RawApp.init");
      if (kDebugMode) print("🚧 $e");
    }
    try {
      documentsDir.q = await getApplicationDocumentsDirectory();
    } catch (e) {
      if (kDebugMode) print("RawApp.init");
      if (kDebugMode) print("🚧 $e");
    }
    try {
      downloadsDir.q = await getDownloadsDirectory();
    } catch (e) {
      if (kDebugMode) print("RawApp.init");
      if (kDebugMode) print("🚧 $e");
    }
    if (Platform.isIOS || Platform.isMacOS) {
      try {
        libraryDir.q = await getLibraryDirectory();
      } catch (e) {
        if (kDebugMode) print("RawApp.init");
        if (kDebugMode) print("🚧 $e");
      }
    }
    try {
      supportDir.q = await getApplicationSupportDirectory();
    } catch (e) {
      if (kDebugMode) print("RawApp.init");
      if (kDebugMode) print("🚧 $e");
    }
    try {
      tempDir.q = await getTemporaryDirectory();
    } catch (e) {
      if (kDebugMode) print("RawApp.init");
      if (kDebugMode) print("🚧 $e");
    }
  }

  Future<void> firstContextGot(BuildContext context) async {
    await Future.delayed(Duration.zero);
    // ignore: use_build_context_synchronously
    _contextGot(context);
  }

  void _contextGot(BuildContext? context) {
    if (context == null) return;
    if (!context.mounted) return;

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

    this.paddingTop.q = paddingTop;
    this.paddingBottom.q = paddingBottom;
    this.paddingLeft.q = paddingLeft;
    this.paddingRight.q = paddingRight;

    quantized33PaddingBottom.q = (paddingBottom / 0.33).round() * 0.33;
    quantizedHalfPaddingBottom.q = (paddingBottom / 0.5).round() * 0.5;
    quantizedQuarterPaddingBottom.q = (paddingBottom / 0.25).round() * 0.25;
    quantizedIntPaddingBottom.q = paddingBottom.round().toDouble();

    screenWidth.q = size.width;
    screenHeight.q = size.height;

    final viewPaddingTop = rawViewPadding.top / dpi;
    final viewPaddingBottom = rawViewPadding.bottom / dpi;
    final viewPaddingLeft = rawViewPadding.left / dpi;
    final viewPaddingRight = rawViewPadding.right / dpi;

    this.viewPaddingTop.q = viewPaddingTop;
    this.viewPaddingBottom.q = viewPaddingBottom;
    this.viewPaddingLeft.q = viewPaddingLeft;
    this.viewPaddingRight.q = viewPaddingRight;

    final viewInsetsTop = rawViewInsets.top / dpi;
    final viewInsetsBottom = rawViewInsets.bottom / dpi;
    final viewInsetsLeft = rawViewInsets.left / dpi;
    final viewInsetsRight = rawViewInsets.right / dpi;

    viewInsetBottomIsZero.q = viewInsetsBottom == 0;

    this.viewInsetsTop.q = viewInsetsTop;
    this.viewInsetsBottom.q = viewInsetsBottom;
    this.viewInsetsLeft.q = viewInsetsLeft;
    this.viewInsetsRight.q = viewInsetsRight;

    final brightness = View.of(context).platformDispatcher.platformBrightness;
    _systemBrightness.q = brightness;

    _onLightChanged();

    this.isPortrait.q = isPortrait;
  }

  BuildContext? get context;

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _contextGot(context);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    _contextGot(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _lifecycleState.q = state;
  }
}
