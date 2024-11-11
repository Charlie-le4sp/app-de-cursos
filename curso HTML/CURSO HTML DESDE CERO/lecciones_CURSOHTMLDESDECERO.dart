// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: camel_case_types, file_names, duplicate_ignore

//=====================PAGINA LECCIONES CURSO HTML DESDE CERO BASICO=======================

// ignore: unused_import
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:app_firebase_v2/curso%20HTML/CURSO%20HTML%20DESDE%20CERO/leccion1_CURSOHTMLDESDECERO.dart';
import 'package:app_firebase_v2/curso%20HTML/CURSO%20HTML%20DESDE%20CERO/leccion4_CURSOHTMLDESDECERO.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../AnimatedTap.dart';
import 'CIRCULAR_PROGRESS_CURSOHTMLDESDECERO.dart';
import '../../page_b.dart';
import '../../util/themeChoice.dart';
import '../../util/themeModeNotifier.dart';
import '../../util/themes.dart';
import 'leccion2_CURSOHTMLDESDECERO.dart';
import 'leccion3_CURSOHTMLDESDECERO.dart';

void main() {
  SharedPreferences.getInstance().then((prefs) {
    var themeMode = prefs.getInt('themeMode') ?? 0;
    /* 0 = ThemeMode.system
       1 = ThemeMode.light
       2 = ThemeMode.dark
    */
    runApp(
      ChangeNotifierProvider<ThemeModeNotifier>(
        create: (_) => ThemeModeNotifier(ThemeMode.values[themeMode]),
        child: MyHomePage((p0, p1) => null),
      ),
    );
  });
}

class lecciones_CURSOHTMLDESDECERO extends StatefulWidget {
  const lecciones_CURSOHTMLDESDECERO({super.key});
  @override
  State<lecciones_CURSOHTMLDESDECERO> createState() =>
      _lecciones_CURSOHTMLDESDECEROState();
}

class _lecciones_CURSOHTMLDESDECEROState
    extends State<lecciones_CURSOHTMLDESDECERO> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeModeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: themeNotifier.getThemeMode(),
      home: MyHomePage((p0, p1) => null),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function(double, double) moveContainerCallback;

  const MyHomePage(this.moveContainerCallback, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  //VARIABLES

  int _counter = 0;
  bool botonActivadoLeccion1 = true;
  bool botonActivadoLeccion2 = true;
  bool botonActivadoLeccion3 = true;
  bool botonActivadoLeccion4 = true;
  double containerPositionX = 170;
  double containerPositionY = 210;

  final ScrollController _scrollController3 = ScrollController();

  // INCREMENTADOR DE NUMERO PARA LAS LECCIONES COMPLETADAS

  void _loadCounter() async {
    SharedPreferences prefsLeccionesCURSOHTMLDESDECERO =
        await SharedPreferences.getInstance();
    setState(() {
      _counter = prefsLeccionesCURSOHTMLDESDECERO.getInt('counter') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadCounter();
    _loadButtonStatus();
    loadContainerPosition();
    _loadButtonStatus2();
    _loadButtonStatus3();
    _loadButtonStatus4();
    _scrollController3.addListener(() {
      saveScrollPosition3();
    });
    getScrollPosition3();
  }

  //FUNCIONALIDAD DESBLOQUEADOR DE BOTONES LECCION 1

  Future<void> _loadButtonStatus() async {
    SharedPreferences prefsLeccionesCURSOHTMLDESDECEROLecciones =
        await SharedPreferences.getInstance();
    setState(() {
      botonActivadoLeccion1 = prefsLeccionesCURSOHTMLDESDECEROLecciones
              .getBool('botonActivadoLeccion1') ??
          true;
    });
  }

  Future<void> _updateButtonStatus(bool activado) async {
    SharedPreferences prefsLeccionesCURSOHTMLDESDECEROLecciones =
        await SharedPreferences.getInstance();
    await prefsLeccionesCURSOHTMLDESDECEROLecciones.setBool(
        'botonActivadoLeccion1', activado);
    setState(() {
      botonActivadoLeccion1 = activado;
    });
  }

  //FUNCIONALIDAD DESBLOQUEADOR DE BOTONES LECCION 2

  Future<void> _loadButtonStatus2() async {
    SharedPreferences prefsLeccionesCURSOHTMLDESDECEROLecciones2 =
        await SharedPreferences.getInstance();
    setState(() {
      botonActivadoLeccion2 = prefsLeccionesCURSOHTMLDESDECEROLecciones2
              .getBool('botonActivadoLeccion2') ??
          true;
    });
  }

  Future<void> _updateButtonStatus2(bool activado2) async {
    SharedPreferences prefsLeccionesCURSOHTMLDESDECEROLecciones2 =
        await SharedPreferences.getInstance();
    await prefsLeccionesCURSOHTMLDESDECEROLecciones2.setBool(
        'botonActivadoLeccion2', activado2);
    setState(() {
      botonActivadoLeccion2 = activado2;
    });
  }

  //FUNCIONALIDAD DESBLOQUEADOR DE BOTONES LECCION 3

  Future<void> _loadButtonStatus3() async {
    SharedPreferences prefsLeccionesCURSOHTMLDESDECEROLecciones3 =
        await SharedPreferences.getInstance();
    setState(() {
      botonActivadoLeccion3 = prefsLeccionesCURSOHTMLDESDECEROLecciones3
              .getBool('botonActivadoLeccion3') ??
          true;
    });
  }

  Future<void> _updateButtonStatus3(bool activado3) async {
    SharedPreferences prefsLeccionesCURSOHTMLDESDECEROLecciones3 =
        await SharedPreferences.getInstance();
    await prefsLeccionesCURSOHTMLDESDECEROLecciones3.setBool(
        'botonActivadoLeccion3', activado3);
    setState(() {
      botonActivadoLeccion3 = activado3;
    });
  }

  //FUNCIONALIDAD DESBLOQUEADOR DE BOTONES LECCION 4

  Future<void> _loadButtonStatus4() async {
    SharedPreferences prefsLeccionesCURSOHTMLDESDECEROLecciones4 =
        await SharedPreferences.getInstance();
    setState(() {
      botonActivadoLeccion3 = prefsLeccionesCURSOHTMLDESDECEROLecciones4
              .getBool('botonActivadoLeccion3') ??
          true;
    });
  }

  Future<void> _updateButtonStatus4(bool activado4) async {
    SharedPreferences prefsLeccionesCURSOHTMLDESDECEROLecciones4 =
        await SharedPreferences.getInstance();
    await prefsLeccionesCURSOHTMLDESDECEROLecciones4.setBool(
        'botonActivadoLeccion4', activado4);
    setState(() {
      botonActivadoLeccion4 = activado4;
    });
  }

  //CARGAR POSICION DEL CONTANER

  void loadContainerPosition() async {
    SharedPreferences prefsLeccionesCURSOHTMLDESDECERO =
        await SharedPreferences.getInstance();
    double? savedPositionX =
        prefsLeccionesCURSOHTMLDESDECERO.getDouble('containerPositionX');
    double? savedPositionY =
        prefsLeccionesCURSOHTMLDESDECERO.getDouble('containerPositionY');
    setState(() {
      containerPositionX = savedPositionX ?? 170;
      containerPositionY = savedPositionY ?? 210;
    });
  }

  void saveContainerPosition() async {
    SharedPreferences prefsLeccionesCURSOHTMLDESDECERO =
        await SharedPreferences.getInstance();
    await prefsLeccionesCURSOHTMLDESDECERO.setDouble(
        'containerPositionX', containerPositionX);
    await prefsLeccionesCURSOHTMLDESDECERO.setDouble(
        'containerPositionY', containerPositionY);
  }

  void moveContainerTo(double positionX, double positionY) {
    setState(() {
      containerPositionX = positionX;
      containerPositionY = positionY;
    });
    saveContainerPosition();
  }

  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        displacement: 60,
        edgeOffset: 230,
        key: refreshKey,
        onRefresh: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const lecciones_CURSOHTMLDESDECERO(),
            transitionDuration: const Duration(
                milliseconds:
                    500), // Duración de la transición (ejemplo: 500 milisegundos)
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves
                          .easeInOutCubicEmphasized, // Curva de animación personalizada (ejemplo: easeInOut)
                    ),
                  ),
                  child: child,
                ),
              );
            },
          ),
        ),
        child: CustomScrollView(
          controller: _scrollController3,
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PageB()));
                    },
                    icon: Icon(
                      IconlyLight.info_circle,
                      size: 30,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ))
              ],
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : const Color.fromARGB(255, 0, 5, 9), // <-- SEE HERE
                statusBarIconBrightness: Theme.of(context).brightness ==
                        Brightness.light
                    ? Brightness.dark
                    : Brightness.light, //<-- For Android SEE HERE (dark icons)
                statusBarBrightness:
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.light
                        : Brightness.dark, //<-- For iOS SEE HERE (dark icons)
              ),
              elevation: 0,
              floating: true,
              pinned: true,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color.fromARGB(255, 0, 5, 9),
              centerTitle: true,

              title: Text(
                "Lecciones",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 25,
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                  icon: Icon(
                    IconlyLight.arrow_left,
                    size: 30,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  )),
              expandedHeight: 210, // Altura expandida de la barra de aplicación
              flexibleSpace: FlexibleSpaceBar(
                // Título de la barra de aplicación
                background: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                        height: 130,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 107, 21, 255),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: CIRCULAR_PROGRESS_CURSOHTMLDESDECERO(),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        "Progreso del curso",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Lecciones completadas:  $_counter",
                                        style: const TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        "Tiempo:",
                                        style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : const Color.fromARGB(255, 0, 5, 9),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35),
                        )),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.amber),
                                child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        isDismissible: true,
                                        backgroundColor: Colors.transparent,
                                        barrierColor: Colors.black26,
                                        useRootNavigator: true,
                                        builder: (context) => FadeIn(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 15, sigmaY: 15),
                                            child: Stack(
                                              children: [
                                                FadeInUp(
                                                  from: 50,
                                                  duration: const Duration(
                                                      milliseconds: 250),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 15,
                                                        horizontal: 20),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      child: Container(
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? const Color
                                                                    .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255)
                                                            : const Color
                                                                    .fromARGB(
                                                                255, 0, 8, 15),
                                                        child:
                                                            DraggableScrollableSheet(
                                                          initialChildSize:
                                                              0.57,
                                                          minChildSize: 0.57,
                                                          maxChildSize: 0.57,
                                                          expand: false,
                                                          builder:
                                                              (_, controller) =>
                                                                  ListView(
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            children: [
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    height: 5,
                                                                    width: 50,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        color: Theme.of(context).brightness ==
                                                                                Brightness.light
                                                                            ? Colors.black12
                                                                            : Colors.white),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "Apariencia",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: Theme.of(context).brightness == Brightness.light
                                                                              ? Colors.black
                                                                              : Colors.white),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 25,
                                                              ),
                                                              const ThemeChoice()
                                                            ],
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
                                                    width:
                                                        MediaQuery.of(context)
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
                                                          child: ZoomIn(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        400),
                                                            child: Container(
                                                              height: 68,
                                                              width: 68,
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .black12,
                                                                      blurRadius:
                                                                          10,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0),
                                                                      spreadRadius:
                                                                          2)
                                                                ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    255,
                                                                    17,
                                                                    0,
                                                                    0.931),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .close,
                                                                  color: Colors
                                                                      .white,
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
                                    icon: const Center(
                                      child: FaIcon(FontAwesomeIcons.solidMoon,
                                          size: 25, color: Colors.black),
                                    )),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeInUp(
                              from: 30,
                              duration: const Duration(milliseconds: 570),
                              delay: const Duration(milliseconds: 400),
                              child: Text(
                                "Curso",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "BowlbyOne",
                                    fontSize: 28,
                                    height: 1.2,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            FadeInUp(
                              from: 30,
                              duration: const Duration(milliseconds: 570),
                              delay: const Duration(milliseconds: 600),
                              child: Text(
                                "HTML5",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "BowlbyOne",
                                    fontSize: 28,
                                    height: 1.2,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeInUp(
                              from: 30,
                              duration: const Duration(milliseconds: 570),
                              delay: const Duration(milliseconds: 900),
                              child: Text(
                                "desde",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "BowlbyOne",
                                    fontSize: 28,
                                    height: 1.2,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            FadeInUp(
                              from: 30,
                              duration: const Duration(milliseconds: 570),
                              delay: const Duration(milliseconds: 1050),
                              child: Text(
                                "cero ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "BowlbyOne",
                                    fontSize: 28,
                                    height: 1.2,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                            FadeInUp(
                              from: 30,
                              duration: const Duration(milliseconds: 570),
                              delay: const Duration(milliseconds: 1150),
                              child: Text(
                                "basico ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "BowlbyOne",
                                    fontSize: 28,
                                    height: 1.2,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              leccion1_CURSOHTMLDESDECERO(
                                                  moveContainerTo),
                                          transitionDuration: Duration(
                                              milliseconds:
                                                  500), // Duración de la transición (ejemplo: 500 milisegundos)
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: SlideTransition(
                                                position: Tween<Offset>(
                                                  begin: Offset(1.0, 0.0),
                                                  end: Offset.zero,
                                                ).animate(
                                                  CurvedAnimation(
                                                    parent: animation,
                                                    curve: Curves
                                                        .easeInOutCubicEmphasized, // Curva de animación personalizada (ejemplo: easeInOut)
                                                  ),
                                                ),
                                                child: child,
                                              ),
                                            );
                                          },
                                        ),
                                      ).then((value) {
                                        if (value == false) {
                                          _updateButtonStatus(false);
                                        }
                                      }),
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                  height: 120,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),

                                                      //color grey es que esta desactivado y el otro color es que esta activo aña
                                                      color: Colors.amber),
                                                  child: Icon(Icons.add)),
                                              botonActivadoLeccion1
                                                  ? Container()
                                                  : Container(
                                                      height: 120,
                                                      width: 120,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              ZoomIn(
                                                                child:
                                                                    Container(
                                                                  height: 35,
                                                                  width: 35,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                      color: Colors
                                                                          .green),
                                                                  child: Center(
                                                                      child:
                                                                          Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: const Text(
                                                    "INTRODUCCION",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),

                                //DESDE AQUI
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () => botonActivadoLeccion1
                                          ? null
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      leccion2_CURSOHTMLDESDECERO(
                                                          moveContainerTo)),
                                            ).then((value) {
                                              if (value == false) {
                                                _updateButtonStatus2(false);
                                              }
                                            }),
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                  height: 120,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),

                                                      //color grey es que esta desactivado y el otro color es que esta activo aña
                                                      color:
                                                          botonActivadoLeccion1
                                                              ? Colors.grey
                                                              : Colors.amber),
                                                  child: botonActivadoLeccion1
                                                      ? Icon(Icons.add)
                                                      : null),
                                              botonActivadoLeccion2
                                                  ? Container()
                                                  : Container(
                                                      height: 120,
                                                      width: 120,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              ZoomIn(
                                                                child:
                                                                    Container(
                                                                  height: 35,
                                                                  width: 35,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                      color: Colors
                                                                          .green),
                                                                  child: Center(
                                                                      child:
                                                                          Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: const Text(
                                                    "Etiquetas de texto",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                //DESDE AQUI
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          botonActivadoLeccion2 //DESBLOQUEDOR QUE DECIDE QUE HACER
                                              ? null
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          leccion3_CURSOHTMLDESDECERO(
                                                              // IR A LA PAGINA CORRESPONDIENTE SIGUIENTE
                                                              moveContainerTo)),
                                                ).then((value) {
                                                  if (value == false) {
                                                    _updateButtonStatus3(
                                                        false); // ACTUALIZAR EL ESTADO DEL WIDGET
                                                  }
                                                }),
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 120,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),

                                                  //color grey es que esta desactivado y el otro color es que esta activo aña
                                                  color:
                                                      botonActivadoLeccion2 // ES EL DEL DESBLOQUEADOR POR QUE ES EL QUE DECIDE
                                                          ? Colors.grey
                                                          : Colors.amber),
                                              child:
                                                  botonActivadoLeccion2 // AL IGUAL ACA
                                                      ? Icon(Icons.add)
                                                      : null),
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: const Text("enlaces",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                                //HASTA ACA
                                //DESDE AQUI
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () => botonActivadoLeccion3
                                          ? null
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      leccion4_CURSOHTMLDESDECERO(
                                                          moveContainerTo)),
                                            ).then((value) {
                                              if (value == false) {
                                                _updateButtonStatus4(false);
                                              }
                                            }),
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 120,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),

                                                  //color grey es que esta desactivado y el otro color es que esta activo aña
                                                  color: botonActivadoLeccion3
                                                      ? Colors.grey
                                                      : Colors.amber),
                                              child: botonActivadoLeccion3
                                                  ? Icon(Icons.add)
                                                  : null),
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: const Text("numeros",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                //HASTA ACA
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: containerPositionY,
                      left: containerPositionX,
                      child: ZoomIn(
                        duration: Duration(milliseconds: 250),
                        delay: Duration(milliseconds: 350),
                        child: AvatarGlow(
                          glowColor: Color.fromARGB(255, 99, 0, 237),
                          endRadius: 50.0,
                          duration: const Duration(milliseconds: 2000),
                          repeat: true,
                          showTwoGlows: true,
                          repeatPauseDuration:
                              const Duration(milliseconds: 100),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? const Color.fromARGB(255, 246, 246, 246)
                                  : const Color.fromARGB(56, 255, 255, 255),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            width: 45,
                            child: FutureBuilder<SharedPreferences>(
                              future: SharedPreferences.getInstance(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<SharedPreferences> snapshot) {
                                if (snapshot.hasData) {
                                  String selectedImageName = snapshot.data!
                                          .getString('selectedImageName') ??
                                      '';
                                  String selectedImageBytesString = snapshot
                                          .data!
                                          .getString('selectedImageBytes') ??
                                      '';
                                  if (selectedImageName.isNotEmpty &&
                                      selectedImageBytesString.isNotEmpty) {
                                    Uint8List selectedImageBytes =
                                        base64Decode(selectedImageBytesString);
                                    final image =
                                        MemoryImage(selectedImageBytes);
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                          image: image,
                                          fit: BoxFit.contain,
                                        ))),
                                      ),
                                    );
                                  } else {
                                    return const Text('No image selected');
                                  }
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController3.dispose();

    super.dispose();
  }

  void saveScrollPosition3() async {
    SharedPreferences prefsTodos3 = await SharedPreferences.getInstance();
    await prefsTodos3.setDouble('scroll_position3', _scrollController3.offset);
  }

  void getScrollPosition3() async {
    SharedPreferences prefsTodos3 = await SharedPreferences.getInstance();
    double? position = prefsTodos3.getDouble('scroll_position3');
    if (position != null) {
      _scrollController3.jumpTo(position);
    }
  }
}
