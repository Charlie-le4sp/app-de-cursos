import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_firebase_v2/iintroduction_screen.dart';

import 'package:app_firebase_v2/paginaAjustes.dart';
import 'package:app_firebase_v2/paginaAvatar2/avatar.dart';

import 'package:app_firebase_v2/curso%20HTML/CURSO%20HTML%20DESDE%20CERO/leccion1_CURSOHTMLDESDECERO.dart';
import 'package:app_firebase_v2/paginaBusqueda.dart';
import 'package:app_firebase_v2/paginaMisCursos.dart';
import 'package:app_firebase_v2/paginaPrueba.dart';

import 'package:app_firebase_v2/paginaPrueba4.dart';
import 'package:app_firebase_v2/paginaPrueba5.dart';
import 'package:app_firebase_v2/paginasCursos/paginaCurso1.dart';
import 'package:app_firebase_v2/paginasHistorial%20copy/DatabaseHelper2.dart';
import 'package:app_firebase_v2/paginasHistorial%20copy/VisitedPagesPage2.dart';
import 'package:app_firebase_v2/paginasHistorial/DatabaseHelper.dart';
import 'package:app_firebase_v2/util/paginaLoading.dart';
import 'package:app_firebase_v2/util/themeModeNotifier.dart';
import 'package:app_firebase_v2/util/themes.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import 'AnimatedTap.dart';
import 'curso HTML/CURSO HTML DESDE CERO/lecciones_CURSOHTMLDESDECERO.dart';

import 'curso HTML/CURSO HTML DESDE CERO/paginaPuente.dart';
import 'laboratorioCursos.dart';

import 'paginaInstagram.dart';

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
        child: paginaInicio(),
      ),
    );
  });
}

class paginaInicio extends StatefulWidget {
  const paginaInicio({super.key});

  @override
  State<paginaInicio> createState() => _paginaInicioState();
}

class _paginaInicioState extends State<paginaInicio> {
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
  //GUARDAR POSICION DE SCROLL
  final ScrollController _scrollController = ScrollController();

  //CAROUSEL CONTROLADOR
  CarouselController buttonCarouselController = CarouselController();

  //DRAWER
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //CONTROLADOR DE TEXTO
  final _textController = TextEditingController();

  //GRADIENTE
  Shader linearGradient3 = const LinearGradient(
    stops: [0.1, 0.95],
    colors: [
      Color.fromARGB(255, 229, 255, 0),
      Color.fromARGB(255, 244, 54, 54)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  //CONTROLER DE HORIZONTAL HISTORIAS
  final ScrollController _horizontal2 = ScrollController();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        _visitedPage = _prefs.getBool('visited_page') ?? false;
      });
    });

    _future = getUserName(); // inicializa _future con un valor antes de su uso

    super.initState();

    _scrollController.addListener(() {
      saveScrollPosition();
    });
    getScrollPosition();
  }

//FUNCION NOMBRE DE USUARIO
  Future<void> _refresh() async {
    setState(() {
      _future = getUserName();
    });
  }

  late Future<String> _future;

  //FORMULARIO DE USUARIO
  final _formKey = GlobalKey<FormState>();
  late String _userName;

  //PAGE CONTROLER DE CURSOS
  final controller = PageController(
    viewportFraction: 0.65,
    keepPage: true,
    initialPage: 0,
  );

  //GRADIENTE
  Shader linearGradient = const LinearGradient(
    stops: [0.1, 0.55],
    colors: [
      Color.fromARGB(255, 51, 255, 0),
      Color.fromARGB(255, 54, 146, 244)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  //BORDER DE HISTORIA__________________________________________

  late SharedPreferences _prefs;
  bool _visitedPage = false;

  void _updateVisitedPage() async {
    await _prefs.setBool('visited_page', true);
    setState(() {
      _visitedPage = true;
    });
  }

  //CHECKEAR ESTADO DE LOGIN

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  bool _isLoggedIn = false;

  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
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
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Color.fromARGB(255, 0, 5, 9),
              leadingWidth: 80,
              toolbarHeight: 80,
              title: FadeInDown(
                from: 10,
                duration: const Duration(milliseconds: 280),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Hola de nuevo",
                            style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Color.fromARGB(255, 255, 110, 7)
                                    : Color.fromARGB(255, 255, 110, 7),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      ],
                    ),
                    FutureBuilder<String>(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return FutureBuilder<String>(
                            future: _future,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: [
                                    Text(
                                      "${snapshot.data}",
                                      style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23),
                                    ),
                                  ],
                                );
                              }
                              return const CircularProgressIndicator();
                            },
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              leading: FadeInDown(
                from: 20,
                duration: const Duration(milliseconds: 280),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? const Color.fromARGB(9, 0, 0, 0)
                                    : const Color.fromARGB(56, 255, 255, 255),
                              ),
                              width: 50,
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
                                          base64Decode(
                                              selectedImageBytesString);
                                      final image =
                                          MemoryImage(selectedImageBytes);
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
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
                            _isLoggedIn
                                ? SizedBox()
                                : Container(
                                    height: 14,
                                    width: 14,
                                    child: ZoomIn(
                                      child: Badge(
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(IconlyLight.activity,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white)),
                )
              ],
            )
          ];
        },
        body: FadeIn(
          duration: const Duration(milliseconds: 150),
          child: RefreshIndicator(
            displacement: 20,
            edgeOffset: 00,
            key: refreshKey,
            onRefresh: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    paginaInicio(),
                transitionDuration: Duration(
                    milliseconds:
                        500), // Duración de la transición (ejemplo: 500 milisegundos)
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0.0, 0.0),
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
            child: ListView(
              padding: const EdgeInsets.only(top: 8),
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Column(
                    children: [
                      CarouselSlider(
                        items: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 0, 140, 255),
                                  ),
                                  child: Stack(children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                  width: double.infinity,
                                                  height: 80,
                                                  color: const Color.fromARGB(
                                                      255, 0, 129, 234),
                                                  child: Row(children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 8),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                        child: const Text(
                                                          "¿Que aprenderas hoy ?",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 24,
                                                              height: 1.2,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                  ])),
                                              SizedBox(
                                                  width: double.infinity,
                                                  height: 80,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 8),
                                                          child: Container(
                                                              width: 70,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))),
                                                        )
                                                      ]))
                                            ],
                                          )
                                        ]),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 185,
                                          width: double.infinity,
                                          child: Image.asset(
                                              "assets/images/imgs_inicio/gif_desarrollo.gif"),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 10),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: const paginaLoading()),
                                        ),
                                      ],
                                    )
                                  ])),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 119, 0),
                                  ),
                                  child: Stack(children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                  width: double.infinity,
                                                  height: 80,
                                                  color: const Color.fromARGB(
                                                      255, 255, 149, 0),
                                                  child: Row(children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 8),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                        child: const Text(
                                                          "No olvides compartir la app",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 24,
                                                              height: 1.2,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                  ])),
                                              SizedBox(
                                                  width: double.infinity,
                                                  height: 80,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 8),
                                                          child: Container(
                                                              width: 70,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))),
                                                        )
                                                      ]))
                                            ],
                                          )
                                        ]),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 23,
                                        ),
                                        SizedBox(
                                          height: 160,
                                          width: double.infinity,
                                          child: Image.asset(
                                              "assets/images/imgs_inicio/gif_1.gif"),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 10),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: const paginaLoading()),
                                        ),
                                      ],
                                    )
                                  ])),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 0, 207, 24),
                                  ),
                                  child: Stack(children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                  width: double.infinity,
                                                  height: 80,
                                                  color: const Color.fromARGB(
                                                      255, 0, 231, 27),
                                                  child: Row(children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 8),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                        child: const Text(
                                                          "Si te gusta la app calificanos",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 24,
                                                              height: 1.2,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                  ])),
                                              SizedBox(
                                                  width: double.infinity,
                                                  height: 80,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 8),
                                                          child: Container(
                                                              width: 70,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))),
                                                        )
                                                      ]))
                                            ],
                                          )
                                        ]),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 150,
                                          width: double.infinity,
                                          child: Image.asset(
                                              "assets/images/imgs_inicio/gif_diseño.gif"),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 10),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: const paginaLoading()),
                                        ),
                                      ],
                                    )
                                  ])),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 236, 0, 169),
                                  ),
                                  child: Stack(children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                  width: double.infinity,
                                                  height: 80,
                                                  color: const Color.fromARGB(
                                                      255, 255, 0, 183),
                                                  child: Row(children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 8),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                        child: const Text(
                                                          "Disfruta  mejores cursos online",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 24,
                                                              height: 1.2,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                  ])),
                                              SizedBox(
                                                  width: double.infinity,
                                                  height: 80,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 8),
                                                          child: Container(
                                                              width: 70,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))),
                                                        )
                                                      ]))
                                            ],
                                          )
                                        ]),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 185,
                                          width: double.infinity,
                                          child: Image.asset(
                                              "assets/images/imgs_inicio/gif_desarrollo.gif"),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 10),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: const paginaLoading()),
                                        ),
                                      ],
                                    )
                                  ])),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 153, 0, 255),
                                  ),
                                  child: Stack(children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                  width: double.infinity,
                                                  height: 80,
                                                  color: const Color.fromARGB(
                                                      255, 175, 55, 255),
                                                  child: Row(children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 8),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        child: const Text(
                                                          "Lo mejor del mundo sabes",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 24,
                                                              height: 1.2,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    )
                                                  ])),
                                              SizedBox(
                                                  width: double.infinity,
                                                  height: 80,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 8),
                                                          child: Container(
                                                              width: 70,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))),
                                                        )
                                                      ]))
                                            ],
                                          )
                                        ]),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 185,
                                          width: double.infinity,
                                          child: Image.asset(
                                              "assets/images/imgs_inicio/gif_desarrollo.gif"),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 10),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: const paginaLoading()),
                                        ),
                                      ],
                                    )
                                  ])),
                            ),
                          ),
                        ],
                        carouselController: buttonCarouselController,
                        options: CarouselOptions(
                            height: 250,
                            autoPlay: true,
                            enlargeCenterPage: false,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 750),
                            autoPlayCurve: Curves.easeInOutCubicEmphasized,
                            viewportFraction: 1,
                            initialPage: 0,
                            autoPlayInterval:
                                const Duration(milliseconds: 2800),
                            enlargeStrategy: CenterPageEnlargeStrategy.height),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 99, 0, 237)),
                        onPressed: () {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Navigator.of(context, rootNavigator: true).push(
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const paginaBusqueda(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var begin = const Offset(0.0, 1.0);
                                  var end = Offset.zero;
                                  var curve = Curves.easeInOutCubic;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Buscar...",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Color.fromARGB(94, 255, 255, 255)
                                        : Color.fromARGB(94, 255, 255, 255)),
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.magnifyingGlass,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.white
                                        : Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Container1(),
                const SizedBox(height: 10),
                InkWell(
                  splashColor: const Color.fromARGB(255, 192, 192, 192),
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 50));
                    Navigator.of(context, rootNavigator: true).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            VisitedPagesPage2(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = const Offset(0.0, 1.0);
                          var end = Offset.zero;
                          var curve = Curves.easeInOutCubicEmphasized;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text("Recomendado",
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                                fontFamily: "Pacifico",
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              )),
                        ),
                        Container(
                            height: 40,
                            width: 40,
                            child: Center(
                                child: Icon(CupertinoIcons.arrow_right,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white))),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: _horizontal2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    const Color.fromARGB(255, 255, 219, 112)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: const Center(
                                        child: FaIcon(FontAwesomeIcons.html5,
                                            color: Colors.black, size: 35))),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "HTML 5 ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: 13,
                                    height: 1.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    const Color.fromARGB(255, 255, 202, 202)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: const Center(
                                        child: FaIcon(FontAwesomeIcons.css3,
                                            color: Colors.black, size: 31))),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "CSS ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: 13,
                                    height: 1.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    const Color.fromARGB(255, 202, 203, 255)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: const Center(
                                        child: FaIcon(FontAwesomeIcons.figma,
                                            color: Colors.black, size: 35))),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "FIGMA",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: 13,
                                    height: 1.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    const Color.fromARGB(255, 203, 255, 185)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: const Center(
                                        child: FaIcon(
                                            FontAwesomeIcons.fileExcel,
                                            color: Colors.black,
                                            size: 35))),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "EXCEL",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: 13,
                                    height: 1.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text("Categorias Populares",
                            style: TextStyle(
                              fontFamily: "Pacifico",
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  AnimatedTap(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Stack(
                        children: [
                          Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width * 0.435,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/images/imgs_inicio/habilidades.jpg")),
                                  borderRadius: BorderRadius.circular(15))),
                          Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width * 0.435,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(105, 4, 4, 4),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 0, left: 8),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: const Text(
                                              "Desarrollo de Habilidades",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: Colors.white,
                                                  height: 1.1,
                                                  fontSize: 17.5,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      )
                                    ]),
                                    Row(children: const [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(bottom: 4, left: 8),
                                        child: Text("15 Cursos",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white,
                                              fontSize: 13.5,
                                            )),
                                      )
                                    ]),
                                  ])),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Stack(
                      children: [
                        Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.435,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/imgs_inicio/tecnologia.jpg")),
                                borderRadius: BorderRadius.circular(15))),
                        Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.435,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(105, 4, 4, 4),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 0, left: 8),
                                      child: Text("Tecnologia",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white,
                                              fontSize: 18.5,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  ]),
                                  Row(children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 4, left: 8),
                                      child: Text("15 Cursos",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.white,
                                            fontSize: 13.5,
                                          )),
                                    )
                                  ]),
                                ])),
                      ],
                    ),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Stack(
                      children: [
                        Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.435,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/imgs_inicio/ilustracion.jpg")),
                                borderRadius: BorderRadius.circular(15))),
                        Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.435,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(105, 4, 4, 4),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 0, left: 8),
                                      child: Text("Ilustracion",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white,
                                              fontSize: 18.5,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  ]),
                                  Row(children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 4, left: 8),
                                      child: Text("15 Cursos",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.white,
                                            fontSize: 13.5,
                                          )),
                                    )
                                  ]),
                                ])),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Stack(
                      children: [
                        Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.435,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/imgs_inicio/idiomas.jpg")),
                                borderRadius: BorderRadius.circular(15))),
                        Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.435,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(105, 4, 4, 4),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 0, left: 8),
                                      child: Text("Idiomas",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white,
                                              fontSize: 18.5,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  ]),
                                  Row(children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 4, left: 8),
                                      child: Text("15 Cursos",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.white,
                                            fontSize: 13.5,
                                          )),
                                    )
                                  ]),
                                ])),
                      ],
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  splashColor: const Color.fromARGB(255, 192, 192, 192),
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 50));
                    Navigator.of(context, rootNavigator: true).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const VisitedPagesPage2(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = const Offset(0.0, 1.0);
                          var end = Offset.zero;
                          var curve = Curves.easeInOutCubicEmphasized;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text("De los Editores",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  foreground: Paint()..shader = linearGradient,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const Icon(CupertinoIcons.arrow_right),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Color.fromARGB(255, 0, 5, 9),
        width: MediaQuery.of(context).size.width * 0.7,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: SizedBox(
                height: 150,
                child: Center(
                  child: FutureBuilder<SharedPreferences>(
                    future: SharedPreferences.getInstance(),
                    builder: (BuildContext context,
                        AsyncSnapshot<SharedPreferences> snapshot) {
                      if (snapshot.hasData) {
                        String selectedImageName =
                            snapshot.data!.getString('selectedImageName') ?? '';
                        String selectedImageBytesString =
                            snapshot.data!.getString('selectedImageBytes') ??
                                '';
                        if (selectedImageName.isNotEmpty &&
                            selectedImageBytesString.isNotEmpty) {
                          Uint8List selectedImageBytes =
                              base64Decode(selectedImageBytesString);
                          final image = MemoryImage(selectedImageBytes);
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? const Color.fromARGB(9, 0, 0, 0)
                                    : const Color.fromARGB(56, 255, 255, 255),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                  image: image,
                                  fit: BoxFit.contain,
                                ))),
                              ),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Future.delayed(const Duration(milliseconds: 330), () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: true,
                            barrierColor: Colors.black12,
                            backgroundColor: Colors.transparent,
                            useRootNavigator: true,
                            builder: (context) => BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Stack(
                                children: [
                                  FadeInUp(
                                    duration: const Duration(milliseconds: 200),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 8, sigmaY: 8),
                                          child: Container(
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? const Color.fromARGB(
                                                    255, 255, 255, 255)
                                                : Color.fromARGB(255, 0, 8, 15),
                                            child: DraggableScrollableSheet(
                                              initialChildSize: 0.75,
                                              minChildSize: 0.75,
                                              maxChildSize: 0.75,
                                              expand: false,
                                              builder: (_, controller) =>
                                                  ListView(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                children: [
                                                  SizedBox(
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
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
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
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Cambiar nombre ",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors.black
                                                                : Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15,
                                                        vertical: 8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? Colors.black38
                                                              : Colors.white30,
                                                          width: 1.2,
                                                        ),
                                                      ),
                                                      height: 100,
                                                      width: 250,
                                                      child: Form(
                                                        key: _formKey,
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                TextFormField(
                                                              decoration:
                                                                  const InputDecoration(
                                                                errorStyle:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                labelStyle:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          230,
                                                                          117,
                                                                          117,
                                                                          117),
                                                                  fontSize: 18,
                                                                ),
                                                                counterStyle:
                                                                    TextStyle(
                                                                  fontSize: 13,
                                                                ),
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            12,
                                                                        vertical:
                                                                            8),
                                                                labelText:
                                                                    'Nombre de Usuario',
                                                              ),
                                                              maxLength: 15,
                                                              style: TextStyle(
                                                                fontSize: 24,
                                                                fontFamily:
                                                                    "Poppins",
                                                                color: Theme.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .light
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Introduce un nombre';
                                                                }
                                                                return null;
                                                              },
                                                              onSaved: (value) =>
                                                                  _userName =
                                                                      value!,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 80,
                                                        vertical: 8),
                                                    child: Container(
                                                      height: 50,
                                                      width: double.infinity,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<
                                                                        Color?>(
                                                              Color.fromARGB(
                                                                  255,
                                                                  99,
                                                                  0,
                                                                  237), // Cambia el color del botón aquí
                                                            ),
                                                            elevation:
                                                                MaterialStateProperty
                                                                    .all<
                                                                        double>(
                                                              0.0, // Cambia la elevación del botón aquí
                                                            ),
                                                            overlayColor:
                                                                MaterialStateProperty
                                                                    .resolveWith<
                                                                        Color?>(
                                                              (Set<MaterialState>
                                                                  states) {
                                                                if (states.contains(
                                                                    MaterialState
                                                                        .pressed))
                                                                  return Color
                                                                      .fromARGB(
                                                                          255,
                                                                          190,
                                                                          143,
                                                                          255); //<-- SEE HERE
                                                                return null; // Defer to the widget's default.
                                                              },
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              _formKey
                                                                  .currentState!
                                                                  .save();
                                                              saveUserName(
                                                                  _userName);
                                                              _refresh();
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          },
                                                          child: Text(
                                                            "Guardar",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins",
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                      width: MediaQuery.of(context).size.width *
                                          1.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AnimatedTap(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: ZoomIn(
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              child: Container(
                                                height: 68,
                                                width: 68,
                                                decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 10,
                                                        offset: Offset(0, 0),
                                                        spreadRadius: 2)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: const Color.fromRGBO(
                                                      255, 17, 0, 0.931),
                                                ),
                                                child: const Center(
                                                  child: FaIcon(
                                                    FontAwesomeIcons.close,
                                                    color: Colors.white,
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
                          );
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            Theme.of(context).brightness == Brightness.light
                                ? Color.fromARGB(255, 246, 246, 246)
                                : Color.fromARGB(255, 15, 25,
                                    34)), // Cambia el color del botón aquí
                        elevation: MaterialStateProperty.all<double>(
                            0.0), // Cambia la elevación del botón aquí

                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Color.fromARGB(
                                  255, 190, 143, 255); //<-- SEE HERE
                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(IconlyBold.edit,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                          SizedBox(width: 10),
                          Text("Cambiar nombre",
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins",
                                  fontSize: 16))
                        ],
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            Future.delayed(const Duration(milliseconds: 330),
                                () {
                              Navigator.of(context, rootNavigator: true).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      paginaAjustes(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(0.0, 1.0);
                                    var end = Offset.zero;
                                    var curve = Curves.easeInOutCubicEmphasized;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color?>(
                                Theme.of(context).brightness == Brightness.light
                                    ? Color.fromARGB(255, 246, 246, 246)
                                    : Color.fromARGB(255, 15, 25,
                                        34)), // Cambia el color del botón aquí
                            elevation: MaterialStateProperty.all<double>(
                                0.0), // Cambia la elevación del botón aquí

                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Color.fromARGB(
                                      255, 190, 143, 255); //<-- SEE HERE
                                return null; // Defer to the widget's default.
                              },
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(IconlyBold.setting,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white),
                              SizedBox(width: 10),
                              Text("Configuracion",
                                  style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins",
                                      fontSize: 16))
                            ],
                          ),
                        )),
                  ),
                  _isLoggedIn
                      ? SizedBox()
                      : Container(
                          height: 14,
                          width: 14,
                          child: ZoomIn(
                            child: Badge(
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: false).push(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        avatar(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(0.0, 1.0);
                      var end = Offset.zero;
                      var curve = Curves.easeInOutCubicEmphasized;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          Future.delayed(const Duration(milliseconds: 330), () {
                            Navigator.of(context, rootNavigator: false).push(
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        avatar(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var begin = const Offset(0.0, 1.0);
                                  var end = Offset.zero;
                                  var curve = Curves.easeInOutCubicEmphasized;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                              Theme.of(context).brightness == Brightness.light
                                  ? Color.fromARGB(255, 246, 246, 246)
                                  : Color.fromARGB(255, 15, 25,
                                      34)), // Cambia el color del botón aquí
                          elevation: MaterialStateProperty.all<double>(
                              0.0), // Cambia la elevación del botón aquí

                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Color.fromARGB(
                                    255, 190, 143, 255); //<-- SEE HERE
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(IconlyBold.user_2,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white),
                            SizedBox(width: 10),
                            Text("Cambiar avatar",
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins",
                                    fontSize: 16))
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // acceder al nombre del usuario desde SharedPreferences
  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? '';
  }

  Future<void> saveUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userName);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();

    super.dispose();
  }

  void saveScrollPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('scroll_position', _scrollController.offset);
  }

  void getScrollPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? position = prefs.getDouble('scroll_position');
    if (position != null) {
      _scrollController.jumpTo(position);
    }
  }
}

class Container1 extends StatefulWidget {
  const Container1({super.key});

  @override
  State<Container1> createState() => _Container1State();
}

class _Container1State extends State<Container1> {
  //VARIABLES  DE ESTADO PARA CADA CURSO
  bool _isLiked = false;
  bool _isLiked2 = false;
  bool _isLiked3 = false;

  @override
  void initState() {
    super.initState();
    cargarEstadoMostrarPaginaY();

    _loadLikesState();
    _loadLikesState2();
    _loadLikesState3();

    _loadVisibility1();
  }

  Future<void> _loadLikesState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLiked = prefs.getBool('isLiked') ?? false;
    });
  }

  Future<void> _loadLikesState2() async {
    final prefs2 = await SharedPreferences.getInstance();
    setState(() {
      _isLiked2 = prefs2.getBool('isLiked2') ?? false;
    });
  }

  Future<void> _loadLikesState3() async {
    final prefs3 = await SharedPreferences.getInstance();
    setState(() {
      _isLiked3 = prefs3.getBool('isLiked3') ?? false;
    });
  }

  Future<void> _saveLikesState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLiked', _isLiked);
  }

  Future<void> _saveLikesState2() async {
    final prefs2 = await SharedPreferences.getInstance();
    await prefs2.setBool('isLiked2', _isLiked2);
  }

  Future<void> _saveLikesState3() async {
    final prefs3 = await SharedPreferences.getInstance();
    await prefs3.setBool('isLiked3', _isLiked3);
  }

  void _toggleLikeState() {
    setState(() {
      if (_isLiked) {
        _isLiked = false;
      } else {
        _isLiked = true;
      }
      _saveLikesState();
    });
  }

  void _toggleLikeState2() {
    setState(() {
      if (_isLiked2) {
        _isLiked2 = false;
      } else {
        _isLiked2 = true;
      }
      _saveLikesState2();
    });
  }

  void _toggleLikeState3() {
    setState(() {
      if (_isLiked3) {
        _isLiked3 = false;
      } else {
        _isLiked3 = true;
      }
      _saveLikesState3();
    });
  }

  //CONTROLADOR DE PAGE VIEW DE LOS CURSOS

  PageController controller2 = PageController(
    viewportFraction: 0.85,
    keepPage: true,
    initialPage: 0,
  );

  //FUNCIONALIDAD PARA HACER VISIBLE EL ESTADO DEL CURSO EN LA PAGINA "MIS CURSOS"
  bool visibilidadFavoritos1 = false;
  late SharedPreferences _prefsStatus1;

  _saveVisibility1() async {
    await _prefsStatus1.setBool('isVisible_1', visibilidadFavoritos1);
  }

  _loadVisibility1() async {
    _prefsStatus1 = await SharedPreferences.getInstance();
    setState(() {
      visibilidadFavoritos1 = _prefsStatus1.getBool('isVisible_1') ?? false;
    });
  }

//SISTEMA DE NAVEGACION ENTRE PAGINAS
  bool mostrarPaginaY = true;

  void cargarEstadoMostrarPaginaY() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mostrarPaginaY = prefs.getBool('mostrarPaginaY') ?? true;
    });
  }

  void guardarEstadoMostrarPaginaY() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('mostrarPaginaY', mostrarPaginaY);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          splashColor: const Color.fromARGB(255, 192, 192, 192),
          onTap: () async {
            await Future.delayed(const Duration(milliseconds: 50));
            Navigator.of(context, rootNavigator: true).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    paginaPrueba5(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var curve = Curves.easeInOutCubicEmphasized;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text("Recomendado",
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        fontFamily: "Pacifico",
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      )),
                ),
                Container(
                    height: 40,
                    width: 40,
                    child: Center(
                        child: Icon(CupertinoIcons.arrow_right,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white))),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 286,
          child: PageView(
            physics: const BouncingScrollPhysics(),
            controller: controller2,
            children: [
              InkWell(
                radius: 20,
                onTap: () async {
                  if (mostrarPaginaY) {
                    bool? result =
                        await Navigator.of(context, rootNavigator: true)
                            .push<bool?>(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const paginaCurso1(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = const Offset(0.0, 1.0);
                          var end = Offset.zero;
                          var curve = Curves.easeInOutCubic;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                    if (result != null && result == true) {
                      setState(() {
                        mostrarPaginaY = false;
                      });
                      guardarEstadoMostrarPaginaY();
                    }
                  } else {
                    Navigator.of(context, rootNavigator: true).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            paginaPuente(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = const Offset(0.0, 1.0);
                          var end = Offset.zero;
                          var curve = Curves.easeInOutCubicEmphasized;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, top: 8, left: 8, right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : const Color.fromARGB(255, 15, 25, 34),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(20, 0, 0, 0),
                              blurRadius: 10,
                              offset: Offset(0, 0),
                              spreadRadius: 2)
                        ]),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/imgs_instructores/img_ins_1.png")),
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.48,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Curso HTML5 desde cero basico",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          height: 1.1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.5),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.12,
                                child: IconButton(
                                  iconSize: 30,
                                  icon: _isLiked
                                      ? ZoomIn(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: const Icon(IconlyBold.heart,color: Colors.red,))
                                      : FadeIn(
                                          child: const Icon(
                                          IconlyLight.heart,
                                          
                                        )),
                                  onPressed: () async {
                                    //PONERLO VISIBLE
                                    setState(() {
                                      visibilidadFavoritos1 =
                                          !visibilidadFavoritos1;
                                      _saveVisibility1();
                                    });

                                    //PONERLO OCULTO
                                    // setState(() {
                                    //   _isVisible1 = false;
                                    //   _saveVisibility();
                                    // });
                                    _toggleLikeState();
                                    Vibration.vibrate(duration: 10);
                                  },
                                ),
                              ),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width * 0.72,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/images/imgs_cursos/fondo_curso_1.jpg")),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? const Color.fromARGB(9, 0, 0, 0)
                                    : const Color.fromARGB(56, 255, 255, 255)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "5 lecciones",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                SizedBox(
                                  height: 45,
                                  child: Center(
                                    child: Text(
                                      "Basico",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 190, 11, 255),
                                      borderRadius: BorderRadius.circular(15)),
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "Go!",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                        SizedBox(width: 5),
                                        FaIcon(
                                          FontAwesomeIcons.angleRight,
                                          size: 15,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        )
                                      ],
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
              ),
              InkWell(
                radius: 20,
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const paginaInicio(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.easeInOutCubicEmphasized;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, top: 8, left: 8, right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : const Color.fromARGB(255, 0, 17, 31),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(20, 0, 0, 0),
                              blurRadius: 10,
                              offset: Offset(0, 0),
                              spreadRadius: 2)
                        ]),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/imgs_instructores/img_ins_2.png")),
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.48,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Curso diseño web desde cero",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          height: 1.1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.5),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.12,
                                child: IconButton(
                                  iconSize: 30,
                                  icon: _isLiked2
                                      ? ZoomIn(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: const Icon(IconlyBold.heart))
                                      : FadeIn(
                                          child: const Icon(IconlyLight.heart)),
                                  color: _isLiked2
                                      ? Colors.red
                                      : Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                  onPressed: () async {
                                    _toggleLikeState2();
                                  },
                                ),
                              ),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width * 0.72,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/images/imgs_cursos/fondo_curso_2.jpg")),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? const Color.fromARGB(9, 0, 0, 0)
                                    : const Color.fromARGB(56, 255, 255, 255)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 3),
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "10 lecciones",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                SizedBox(
                                  height: 45,
                                  child: Center(
                                    child: Text(
                                      "Basico",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : const Color.fromARGB(
                                                  56, 255, 255, 255)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 190, 11, 255),
                                      borderRadius: BorderRadius.circular(15)),
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "Go!",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                        SizedBox(width: 5),
                                        FaIcon(
                                          FontAwesomeIcons.angleRight,
                                          size: 15,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        )
                                      ],
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
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 10, top: 8, left: 8, right: 8),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : const Color.fromARGB(255, 0, 17, 31),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(20, 0, 0, 0),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            spreadRadius: 2)
                      ]),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/imgs_instructores/img_ins_3.png")),
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.48,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Curso gestion de proyectos ",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        height: 1.1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.5),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.12,
                              child: IconButton(
                                iconSize: 30,
                                icon: _isLiked3
                                    ? ZoomIn(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: const Icon(IconlyBold.heart))
                                    : FadeIn(
                                        child: const Icon(IconlyLight.heart)),
                                color: _isLiked3
                                    ? Colors.red
                                    : Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                onPressed: () async {
                                  _toggleLikeState3();
                                },
                              ),
                            ),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width * 0.72,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/imgs_cursos/fondo_curso_3.jpg")),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? const Color.fromARGB(9, 0, 0, 0)
                                  : const Color.fromARGB(56, 255, 255, 255)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 3),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      "12 lecciones",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              SizedBox(
                                height: 45,
                                child: Center(
                                  child: Text(
                                    "Intermedio",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : const Color.fromARGB(
                                                56, 255, 255, 255)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 190, 11, 255),
                                    borderRadius: BorderRadius.circular(15)),
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Go!",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                      SizedBox(width: 5),
                                      FaIcon(
                                        FontAwesomeIcons.angleRight,
                                        size: 15,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      )
                                    ],
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
            ],
          ),
        )
      ],
    );
  }
}

class animatedContainer extends StatefulWidget {
  const animatedContainer({super.key});

  @override
  State<animatedContainer> createState() => _animatedContainerState();
}

class _animatedContainerState extends State<animatedContainer> {
  double _currentPage = 0.0;
  PageController controller2 = PageController(
    viewportFraction: 0.85,
    keepPage: true,
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();

    controller2.addListener(() {
      setState(() {
        _currentPage = controller2.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        color: _getColor(),
      ),
    );
  }

  Color? _getColor() {
    ColorTween colorTween = ColorTween(
      begin: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      end: Color.fromARGB(255, 255, 141, 92),
    );
    double scrollPosition = _currentPage / 2.0;
    return colorTween.transform(scrollPosition);
  }
}
