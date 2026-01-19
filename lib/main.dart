import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gastrogo/presentation/pages/home_page.dart';
import 'package:gastrogo/presentation/providers/theme_provider.dart';

import 'package:gastrogo/core/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: GastroGoApp()));
}

class GastroGoApp extends ConsumerWidget {
  const GastroGoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modeAsync = ref.watch(themeModeProvider);
    final mode = modeAsync.value ?? ThemeMode.system;

    return MaterialApp(
      title: 'GastroGo',
      debugShowCheckedModeBanner: false,
      themeMode: mode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}
