// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: camel_case_types, file_names, duplicate_ignore, deprecated_member_use

// ignore: unused_import
import 'dart:async';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:app_firebase_v2/paginaMisCursos.dart';

import 'package:app_firebase_v2/paginaInicio.dart';
import 'package:app_firebase_v2/paginaMas.dart';
import 'package:app_firebase_v2/paginaPuenteMisCursos.dart';
import 'package:app_firebase_v2/paginasHistorial%20copy/VisitedPagesPage2.dart';
import 'package:app_firebase_v2/paginasHistorial/VisitedPagesPage.dart';
import 'package:app_firebase_v2/util/themeChoice.dart';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AnimatedTap.dart';
import 'curso HTML/CURSO HTML DESDE CERO/paginaPuente.dart';
import 'util/themeModeNotifier.dart';
import 'util/themes.dart';

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
        child: const paginaHome(),
      ),
    );
  });
}

class paginaHome extends StatefulWidget {
  const paginaHome({super.key});

  @override
  State<paginaHome> createState() => _paginaHomeState();
}

class _paginaHomeState extends State<paginaHome> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeModeNotifier>(context);
    final brightness = MediaQuery.of(context).platformBrightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarIconBrightness:
          brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      statusBarIconBrightness:
          brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      statusBarColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white12
          : const Color.fromARGB(255, 0, 5, 9),
    ));
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
  List<TabItem> items = [
    const TabItem(
      icon: IconlyLight.setting,
      title: 'Inicio',
    ),
    const TabItem(
      icon: FontAwesomeIcons.bookOpen,
      title: 'Cursos',
    ),
    const TabItem(
      icon: FontAwesomeIcons.bars,
      title: 'Mas',
    ),
    const TabItem(
      icon: FontAwesomeIcons.user,
      title: 'Estudio',
    ),
  ];

  final List<Widget> _paginas = [
    const paginaInicio(),
    const paginaPuenteMisCursos(),
    const paginaMas(),
    const paginaPuente()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: _paginas[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: NavigationBar(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? const Color.fromARGB(210, 255, 255, 255)
                : const Color.fromARGB(197, 0, 13, 24),
            animationDuration: const Duration(milliseconds: 800),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            selectedIndex: currentIndex,
            onDestinationSelected: (index) => {
              setState(
                () => currentIndex = index,
              )
            },

            // ignore: prefer_const_literals_to_create_immutables
            destinations: [
              NavigationDestination(
                  selectedIcon: FadeIn(
                      child: const Icon(
                    IconlyBold.home,
                    size: 25,
                    color: Colors.white,
                  )),
                  icon: const Icon(
                    IconlyLight.home,
                    size: 25,
                  ),
                  label: "Inicio"),
              NavigationDestination(
                  selectedIcon: FadeIn(
                      child: const FaIcon(
                    color: Colors.white,
                    FontAwesomeIcons.graduationCap,
                    size: 25,
                  )),
                  icon: const FaIcon(
                    FontAwesomeIcons.graduationCap,
                    size: 25,
                  ),
                  label: "Mis Cursos"),
              NavigationDestination(
                  selectedIcon: FadeIn(
                      child: const Icon(
                    IconlyBold.category,
                    size: 25,
                    color: Colors.white,
                  )),
                  icon: const Icon(
                    IconlyLight.category,
                    size: 25,
                  ),
                  label: "Mas"),
              NavigationDestination(
                  selectedIcon: FadeIn(
                      child: const Icon(
                    IconlyBold.bookmark,
                    size: 25,
                    color: Colors.white,
                  )),
                  icon: const Icon(
                    IconlyLight.bookmark,
                    size: 25,
                  ),
                  label: "Estudio"),
            ],
          ),
        ),
      ),
      floatingActionButton: Hero(
        tag: "broo",
        child: AnimatedTap(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              barrierColor: Colors.black12,
              backgroundColor: Colors.transparent,
              useRootNavigator: true,
              builder: (context) => FadeIn(
                duration: const Duration(milliseconds: 200),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Stack(
                    children: [
                      FadeInUp(
                        from: 50,
                        duration: const Duration(milliseconds: 250),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 0, 8, 15),
                                child: DraggableScrollableSheet(
                                  initialChildSize: 0.6,
                                  minChildSize: 0.6,
                                  maxChildSize: 0.6,
                                  expand: false,
                                  builder: (_, controller) => ListView(
                                    physics: const BouncingScrollPhysics(),
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 5,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.black12
                                                    : Colors.white),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Mas opciones",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 26.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 70,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.81,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color?>(Theme.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Color.fromARGB(255,
                                                              255, 255, 255)
                                                          : Color.fromARGB(
                                                              224,
                                                              0,
                                                              8,
                                                              15)), // Cambia el color del botón aquí
                                                  elevation:
                                                      MaterialStateProperty.all<
                                                              double>(
                                                          0.0), // Cambia la elevación del botón aquí

                                                  overlayColor:
                                                      MaterialStateProperty
                                                          .resolveWith<Color?>(
                                                    (Set<MaterialState>
                                                        states) {
                                                      if (states.contains(
                                                          MaterialState
                                                              .pressed))
                                                        return Color.fromARGB(
                                                            255,
                                                            190,
                                                            143,
                                                            255); //<-- SEE HERE
                                                      return null; // Defer to the widget's default.
                                                    },
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 300),
                                                      () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      isDismissible: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      barrierColor:
                                                          Colors.transparent,
                                                      useRootNavigator: true,
                                                      builder: (context) =>
                                                          Stack(
                                                        children: [
                                                          FadeInUp(
                                                            from: 50,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        200),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 15,
                                                                  horizontal:
                                                                      20),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                child:
                                                                    BackdropFilter(
                                                                  filter: ImageFilter
                                                                      .blur(
                                                                          sigmaX:
                                                                              8,
                                                                          sigmaY:
                                                                              8),
                                                                  child:
                                                                      Container(
                                                                    color: Theme.of(context).brightness ==
                                                                            Brightness
                                                                                .light
                                                                        ? Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)
                                                                        : Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            8,
                                                                            15),
                                                                    child:
                                                                        DraggableScrollableSheet(
                                                                      initialChildSize:
                                                                          0.6,
                                                                      minChildSize:
                                                                          0.6,
                                                                      maxChildSize:
                                                                          0.6,
                                                                      expand:
                                                                          false,
                                                                      builder: (_,
                                                                              controller) =>
                                                                          ListView(
                                                                        physics:
                                                                            const BouncingScrollPhysics(),
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                8,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                height: 5,
                                                                                width: 50,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).brightness == Brightness.light ? Colors.black12 : Colors.white),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(
                                                                                  "Apariencia",
                                                                                  style: TextStyle(fontFamily: "Poppins", fontSize: 25, fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                25,
                                                                          ),
                                                                          const ThemeChoice()
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            child: SizedBox(
                                                              height: 110,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  1.0,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  AnimatedTap(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        ZoomIn(
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              400),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            68,
                                                                        width:
                                                                            68,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                                color: Colors.black12,
                                                                                blurRadius: 10,
                                                                                offset: Offset(0, 0),
                                                                                spreadRadius: 2)
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(100),
                                                                          color: const Color.fromRGBO(
                                                                              255,
                                                                              17,
                                                                              0,
                                                                              0.931),
                                                                        ),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.close,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 55,
                                                      width: 55,
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              255, 232, 163),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Center(
                                                        child: const FaIcon(
                                                            FontAwesomeIcons
                                                                .solidMoon,
                                                            size: 25,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.44,
                                                      child: Text(
                                                        "Apariencia",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontSize: 17,
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors.black
                                                                : Colors.white),
                                                      ),
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons
                                                            .arrowRight,
                                                        size: 25,
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? Colors.black
                                                            : Colors.white),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 70,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.81,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color?>(Theme.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Color.fromARGB(255,
                                                              255, 255, 255)
                                                          : Color.fromARGB(
                                                              224,
                                                              0,
                                                              8,
                                                              15)), // Cambia el color del botón aquí
                                                  elevation:
                                                      MaterialStateProperty.all<
                                                              double>(
                                                          0.0), // Cambia la elevación del botón aquí

                                                  overlayColor:
                                                      MaterialStateProperty
                                                          .resolveWith<Color?>(
                                                    (Set<MaterialState>
                                                        states) {
                                                      if (states.contains(
                                                          MaterialState
                                                              .pressed))
                                                        return Color.fromARGB(
                                                            255,
                                                            190,
                                                            143,
                                                            255); //<-- SEE HERE
                                                      return null; // Defer to the widget's default.
                                                    },
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 300),
                                                      () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      isDismissible: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      barrierColor:
                                                          Colors.transparent,
                                                      useRootNavigator: true,
                                                      builder: (context) =>
                                                          Stack(
                                                        children: [
                                                          FadeInUp(
                                                            from: 50,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        250),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 15,
                                                                  horizontal:
                                                                      20),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                child:
                                                                    BackdropFilter(
                                                                  filter: ImageFilter
                                                                      .blur(
                                                                          sigmaX:
                                                                              8,
                                                                          sigmaY:
                                                                              8),
                                                                  child:
                                                                      Container(
                                                                    color: Theme.of(context).brightness ==
                                                                            Brightness
                                                                                .light
                                                                        ? const Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)
                                                                        : const Color.fromARGB(
                                                                            224,
                                                                            0,
                                                                            8,
                                                                            15),
                                                                    child:
                                                                        DraggableScrollableSheet(
                                                                      initialChildSize:
                                                                          0.76,
                                                                      minChildSize:
                                                                          0.76,
                                                                      maxChildSize:
                                                                          0.76,
                                                                      expand:
                                                                          false,
                                                                      builder: (_, controller) => SizedBox(
                                                                          width: MediaQuery.of(context).size.width *
                                                                              0.9,
                                                                          height: MediaQuery.of(context).size.height *
                                                                              0.9,
                                                                          child:
                                                                              const VisitedPagesPage2()),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            child: SizedBox(
                                                              height: 110,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  1.0,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  AnimatedTap(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        ZoomIn(
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              400),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            68,
                                                                        width:
                                                                            68,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                                color: Colors.black12,
                                                                                blurRadius: 10,
                                                                                offset: Offset(0, 0),
                                                                                spreadRadius: 2)
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(100),
                                                                          color: const Color.fromRGBO(
                                                                              255,
                                                                              17,
                                                                              0,
                                                                              0.931),
                                                                        ),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.close,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 55,
                                                      width: 55,
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              255, 232, 163),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Center(
                                                        child: const FaIcon(
                                                            FontAwesomeIcons
                                                                .star,
                                                            size: 25,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.44,
                                                      child: Text(
                                                        "Favoritos",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontSize: 17,
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors.black
                                                                : Colors.white),
                                                      ),
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons
                                                            .arrowRight,
                                                        size: 25,
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? Colors.black
                                                            : Colors.white),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 70,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.81,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color?>(Theme.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Color.fromARGB(255,
                                                              255, 255, 255)
                                                          : Color.fromARGB(
                                                              224,
                                                              0,
                                                              8,
                                                              15)), // Cambia el color del botón aquí
                                                  elevation:
                                                      MaterialStateProperty.all<
                                                              double>(
                                                          0.0), // Cambia la elevación del botón aquí

                                                  overlayColor:
                                                      MaterialStateProperty
                                                          .resolveWith<Color?>(
                                                    (Set<MaterialState>
                                                        states) {
                                                      if (states.contains(
                                                          MaterialState
                                                              .pressed))
                                                        return Color.fromARGB(
                                                            255,
                                                            190,
                                                            143,
                                                            255); //<-- SEE HERE
                                                      return null; // Defer to the widget's default.
                                                    },
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 300),
                                                      () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      isDismissible: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      barrierColor:
                                                          Colors.transparent,
                                                      useRootNavigator: true,
                                                      builder: (context) =>
                                                          Stack(
                                                        children: [
                                                          FadeInUp(
                                                            from: 50,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        250),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 15,
                                                                  horizontal:
                                                                      20),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                                child:
                                                                    BackdropFilter(
                                                                  filter: ImageFilter
                                                                      .blur(
                                                                          sigmaX:
                                                                              8,
                                                                          sigmaY:
                                                                              8),
                                                                  child:
                                                                      Container(
                                                                    color: Theme.of(context).brightness ==
                                                                            Brightness
                                                                                .light
                                                                        ? const Color.fromARGB(
                                                                            216,
                                                                            255,
                                                                            255,
                                                                            255)
                                                                        : const Color.fromARGB(
                                                                            224,
                                                                            0,
                                                                            8,
                                                                            15),
                                                                    child:
                                                                        DraggableScrollableSheet(
                                                                      initialChildSize:
                                                                          0.76,
                                                                      minChildSize:
                                                                          0.76,
                                                                      maxChildSize:
                                                                          0.76,
                                                                      expand:
                                                                          false,
                                                                      builder: (_, controller) => SizedBox(
                                                                          width: MediaQuery.of(context).size.width *
                                                                              0.9,
                                                                          height: MediaQuery.of(context).size.height *
                                                                              0.9,
                                                                          child:
                                                                              const VisitedPagesPage()),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            child: SizedBox(
                                                              height: 110,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  1.0,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  AnimatedTap(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        ZoomIn(
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              400),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            68,
                                                                        width:
                                                                            68,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                                color: Colors.black12,
                                                                                blurRadius: 10,
                                                                                offset: Offset(0, 0),
                                                                                spreadRadius: 2)
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.circular(100),
                                                                          color: const Color.fromRGBO(
                                                                              255,
                                                                              17,
                                                                              0,
                                                                              0.931),
                                                                        ),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.close,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 55,
                                                      width: 55,
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              255, 232, 163),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Center(
                                                        child: const FaIcon(
                                                            FontAwesomeIcons
                                                                .timeline,
                                                            size: 25,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.44,
                                                      child: Text(
                                                        "Historial",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontSize: 17,
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors.black
                                                                : Colors.white),
                                                      ),
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons
                                                            .arrowRight,
                                                        size: 25,
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? Colors.black
                                                            : Colors.white),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: SizedBox(
                          height: 110,
                          width: MediaQuery.of(context).size.width * 1.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedTap(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: ZoomIn(
                                  duration: const Duration(milliseconds: 400),
                                  child: Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10,
                                            offset: Offset(0, 0),
                                            spreadRadius: 2)
                                      ],
                                      borderRadius: BorderRadius.circular(100),
                                      color: Color.fromARGB(236, 255, 255, 255),
                                    ),
                                    child: const Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.close,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(31, 0, 0, 0),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                      spreadRadius: 3)
                ],
                borderRadius: BorderRadius.circular(100),
                color: const Color.fromARGB(255, 124, 57, 240),
              ),
              child: Center(
                  child: FaIcon(
                FontAwesomeIcons.bars,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.white,
              ))),
        ),
      ),
    );
  }

  // acceder al nombre del usuario desde SharedPreferences
  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? '';
  }
}
