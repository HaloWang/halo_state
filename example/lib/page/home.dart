import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:example/route/router.dart';
import 'package:example/state/p.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo/halo.dart';
import 'package:halo_state/halo_state.dart';

class PageHome extends ConsumerWidget {
  static final v = qs(0);

  static final _focusNode = FocusNode();

  const PageHome({super.key});

  void _onPressed() {
    v.ua(1);
  }

  void _onTap() {
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = ref.watch(P.app.version);
    final buildNumber = ref.watch(P.app.buildNumber);
    final isPortrait = ref.watch(P.app.isPortrait);
    final screenHeight = ref.watch(P.app.screenHeight);
    final screenWidth = ref.watch(P.app.screenWidth);
    final paddingBottom = ref.watch(P.app.paddingBottom);
    final paddingLeft = ref.watch(P.app.paddingLeft);
    final paddingRight = ref.watch(P.app.paddingRight);
    final paddingTop = ref.watch(P.app.paddingTop);
    final viewInsetBottomIsZero = ref.watch(P.app.viewInsetBottomIsZero);
    final viewInsetsBottom = ref.watch(P.app.viewInsetsBottom);
    final viewInsetsLeft = ref.watch(P.app.viewInsetsLeft);
    final viewInsetsRight = ref.watch(P.app.viewInsetsRight);
    final viewInsetsTop = ref.watch(P.app.viewInsetsTop);
    final viewPaddingBottom = ref.watch(P.app.viewPaddingBottom);
    final viewPaddingLeft = ref.watch(P.app.viewPaddingLeft);
    final viewPaddingRight = ref.watch(P.app.viewPaddingRight);
    final viewPaddingTop = ref.watch(P.app.viewPaddingTop);
    final quantized33PaddingBottom = ref.watch(P.app.quantized33PaddingBottom);
    final quantizedHalfPaddingBottom = ref.watch(P.app.quantizedHalfPaddingBottom);
    final quantizedQuarterPaddingBottom = ref.watch(P.app.quantizedQuarterPaddingBottom);
    final quantizedIntPaddingBottom = ref.watch(P.app.quantizedIntPaddingBottom);
    final light = ref.watch(P.app.light);
    final dark = ref.watch(P.app.dark);
    final qw = ref.watch(P.app.qw);
    final qb = ref.watch(P.app.qb);

    final preferredThemeMode = ref.watch(P.app.preferredThemeMode);
    final systemBrightness = ref.watch(P.app.systemBrightness);

    final children = <Widget>[
      T("systemBrightness".codeToName),
      T(systemBrightness.toString()),
      T("preferredThemeMode".codeToName),
      TextButton(
        onPressed: _onThemeModePressed,
        child: T(preferredThemeMode.name),
      ),
      T("light".codeToName),
      T(light.toString()),
      T("dark".codeToName),
      T(dark.toString()),
      T("qw".codeToName),
      Container(
        decoration: BoxDecoration(
          color: qw,
          border: Border.all(color: kG.q(.5), width: 0.5),
        ),
        height: 12,
        width: 16,
      ),
      T("qb".codeToName),
      Container(
        decoration: BoxDecoration(
          color: qb,
          border: Border.all(color: kG.q(.5), width: 0.5),
        ),
        height: 12,
        width: 16,
      ),
      T("version".codeToName),
      T(version.toString()),
      T("buildNumber".codeToName),
      T(buildNumber.toString()),
      T("isPortrait".codeToName),
      T(isPortrait.toString()),
      T("screenHeight".codeToName),
      T(screenHeight.toString()),
      T("screenWidth".codeToName),
      T(screenWidth.toString()),
      T("paddingBottom".codeToName),
      T(paddingBottom.toString()),
      T("paddingLeft".codeToName),
      T(paddingLeft.toString()),
      T("paddingRight".codeToName),
      T(paddingRight.toString()),
      T("paddingTop".codeToName),
      T(paddingTop.toString()),
      T("viewInsetBottomIsZero".codeToName),
      T(viewInsetBottomIsZero.toString()),
      T("viewInsetsBottom".codeToName),
      T(viewInsetsBottom.toString()),
      T("viewInsetsLeft".codeToName),
      T(viewInsetsLeft.toString()),
      T("viewInsetsRight".codeToName),
      T(viewInsetsRight.toString()),
      T("viewInsetsTop".codeToName),
      T(viewInsetsTop.toString()),
      T("viewPaddingBottom".codeToName),
      T(viewPaddingBottom.toString()),
      T("viewPaddingLeft".codeToName),
      T(viewPaddingLeft.toString()),
      T("viewPaddingRight".codeToName),
      T(viewPaddingRight.toString()),
      T("viewPaddingTop".codeToName),
      T(viewPaddingTop.toString()),
      T("quantized33PaddingBottom".codeToName),
      T(quantized33PaddingBottom.toString()),
      T("quantizedHalfPaddingBottom".codeToName),
      T(quantizedHalfPaddingBottom.toString()),
      T("quantizedQuarterPaddingBottom".codeToName),
      T(quantizedQuarterPaddingBottom.toString()),
      T("quantizedIntPaddingBottom".codeToName),
      T(quantizedIntPaddingBottom.toString()),
      T("TextField".codeToName),
      Expanded(
        flex: 3,
        child: Row(
          children: [
            TextButton(
              onPressed: _onTap,
              child: T("Hide Keyboard"),
            ),
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextField(
                  focusNode: _focusNode,
                  style: TextStyle(fontSize: 12),
                  scrollPadding: EdgeInsets.zero,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];

    late final Color bgColor;
    if (light) {
      bgColor = const Color(0xFFEEEEEE);
    } else {
      bgColor = kB;
    }

    late final Color contentColor;
    if (light) {
      contentColor = kW;
    } else {
      contentColor = qb.q(0.1);
    }

    return Scaffold(
      appBar: AppBar(
        title: T("Halo State"),
        backgroundColor: bgColor,
      ),
      backgroundColor: bgColor,
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EI.o(b: paddingBottom + 100),
        itemCount: children.length ~/ 2,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: contentColor,
              border: Border(
                bottom: BorderSide(
                  color: qb.q(0.1),
                  width: 0.5,
                ),
              ),
            ),
            margin: EI.o(
              l: paddingLeft + 4,
              r: paddingRight + 4,
            ),
            padding: EI.o(
              l: 6,
              r: 6,
              t: 4,
              b: 4,
            ),
            child: Row(
              children: [
                Expanded(child: children[index * 2]),
                children[index * 2 + 1],
              ],
            ),
          );
        },
      ),
    );
  }

  void _onThemeModePressed() async {
    qq;
    final result = await showConfirmationDialog(
      context: getContext()!,
      title: "Theme Mode",
      message: "Select the theme mode",
      okLabel: "Light",
      cancelLabel: "Dark",
      actions: ThemeMode.values.map((e) {
        return AlertDialogAction<ThemeMode>(
          label: e.name,
          key: e,
        );
      }).toList(),
    );
    if (result == null) return;
    P.preference.themeMode.q = result;
  }
}
