import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:walking_app/ViewModel/top_screen_view_model.dart';
import 'package:walking_app/presentation/screens/top_screen.dart';

import 'firebase_options.dart';
import 'presentation/screens/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: TopScreen(TopScreenViewModel()),
    );
  }
}
