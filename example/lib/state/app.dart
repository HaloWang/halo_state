part of 'p.dart';

class _App extends RawApp {
  @override
  BuildContext? get context => getContext();
}

/// Public methods
extension $App on _App {}

/// Private methods
extension _$App on _App {
  Future<void> _init() async {
    qq;
    await init();
    light.lv(_onLightChanged, fireImmediately: true);
  }

  void _onLightChanged() {
    qq;
    if (light.q) {
    } else {}
  }
}
