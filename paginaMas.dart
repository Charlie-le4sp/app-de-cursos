// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: camel_case_types, file_names, duplicate_ignore

// ignore: unused_import
import 'dart:async';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:app_firebase_v2/util/themeModeNotifier.dart';
import 'package:app_firebase_v2/util/themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AnimatedTap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var themeMode = prefs.getInt('themeMode') ?? 0;
    /* 0 = ThemeMode.system
       1 = ThemeMode.light
       2 = ThemeMode.dark
    */
    runApp(
      ChangeNotifierProvider<ThemeModeNotifier>(
        create: (_) => ThemeModeNotifier(ThemeMode.values[themeMode]),
        child: const paginaMas(),
      ),
    );
  });
}

class paginaMas extends StatefulWidget {
  const paginaMas({super.key});

  @override
  State<paginaMas> createState() => _paginaMasState();
}

class _paginaMasState extends State<paginaMas> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeModeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: themeNotifier.getThemeMode(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double _height = 100.0;

  void _onTap() {
    setState(() {
      _height = _height == 100.0 ? 100.0 : 100.0;
    });
  }

  Shader linearGradient = const LinearGradient(
    stops: [0.1, 1.8],
    colors: [
      Color.fromARGB(255, 137, 0, 186),
      Color.fromARGB(255, 230, 148, 255)
    ],
  ).createShader(const Rect.fromLTWH(
      0.0, 0.0, 200.0, 70.0)); // Personaliza las dimensiones del degradado aquí

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              leadingWidth: 32,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Color.fromARGB(255, 0, 5, 9), // <-- SEE HERE
                statusBarIconBrightness: Theme.of(context).brightness ==
                        Brightness.light
                    ? Brightness.dark
                    : Brightness.light, //<-- For Android SEE HERE (dark icons)
                statusBarBrightness:
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.light
                        : Brightness.dark, //<-- For iOS SEE HERE (dark icons)
              ),
              leading: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FadeInDown(
                    from: 10,
                    duration: const Duration(milliseconds: 280),
                    child: const Icon(
                      IconlyLight.category,
                      color: Colors.black,
                      size: 28,
                    )),
              ),
              toolbarHeight: 65,
              collapsedHeight: 65,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: FadeInDown(
                  from: 10,
                  duration: const Duration(milliseconds: 280),
                  child: Text(
                    "Explora",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ),
              ),
              pinned: true,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : const Color.fromARGB(255, 0, 5, 9),
              elevation: 0,
              bottom: PreferredSize(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black12
                            : Colors.white30,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                preferredSize: const Size.fromHeight(1.0),
              ),
            ),
          ];
        },
        body: Container(),
      ),
    );
  }
}
