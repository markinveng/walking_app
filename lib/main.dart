import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'screens/app.dart';



void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      title: 'アプリ名',
      theme: FlexThemeData.light(scheme: FlexScheme.bigStone),
      darkTheme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
      themeMode: ThemeMode.system,
      home: const App(),
    );
  }
}
