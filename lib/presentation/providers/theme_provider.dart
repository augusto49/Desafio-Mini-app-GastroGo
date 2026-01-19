import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeModeProvider = AsyncNotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    final sp = await SharedPreferences.getInstance();
    final s = sp.getString('theme_mode') ?? 'system';
    if (s == 'light') return ThemeMode.light;
    if (s == 'dark') return ThemeMode.dark;
    return ThemeMode.system;
  }

  Future<void> toggle() async {
    final current = state.value ?? ThemeMode.system;
    final newMode =
        current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    state = AsyncValue.data(newMode);

    final sp = await SharedPreferences.getInstance();
    await sp.setString(
      'theme_mode',
      newMode == ThemeMode.dark ? 'dark' : 'light',
    );
  }
}
