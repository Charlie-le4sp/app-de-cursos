// ignore_for_file: unused_import

import 'package:app_firebase_v2/paginaHome.dart';
import 'package:app_firebase_v2/util/themeModeNotifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'iintroduction_screen.dart';

bool show = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefsMain = await SharedPreferences.getInstance();
  show = prefsMain.getBool('ON_BOARDING') ?? true;

  SharedPreferences.getInstance().then((prefsMain) {
    var themeMode = prefsMain.getInt('themeMode') ?? 0;
    /* 0 = ThemeMode.system
       1 = ThemeMode.light
       2 = ThemeMode.dark
    */

    runApp(
      ChangeNotifierProvider<ThemeModeNotifier>(
        create: (_) => ThemeModeNotifier(ThemeMode.values[themeMode]),
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter On Boarding',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: show ? const IntroScreen() : const paginaHome(),
    );
  }
}
