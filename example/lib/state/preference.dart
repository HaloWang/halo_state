part of 'p.dart';

class _Preference {
  final themeMode = qs(ThemeMode.system);
}

/// Private methods
extension _$Preference on _Preference {
  FV _init() async {
    qq;

    final sp = await SharedPreferences.getInstance();

    final themeMode = sp.getString("halo_state.themeMode");

    if (themeMode != null) {
      this.themeMode.q = ThemeMode.values.firstWhereOrNull((e) => e.name == themeMode) ?? ThemeMode.system;
    } else {
      this.themeMode.q = ThemeMode.system;
    }

    P.app.preferredThemeMode.q = this.themeMode.q;

    this.themeMode.lv(_onThemeModeChanged);
  }
}

/// Public methods
extension $Preference on _Preference {
  void _onThemeModeChanged() {
    switch (themeMode.q) {
      case ThemeMode.light:
        P.app.preferredThemeMode.q = ThemeMode.light;
      case ThemeMode.dark:
        P.app.preferredThemeMode.q = ThemeMode.dark;
      case ThemeMode.system:
        P.app.preferredThemeMode.q = ThemeMode.system;
    }
  }
}
