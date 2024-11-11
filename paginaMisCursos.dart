// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: camel_case_types, file_names, duplicate_ignore, use_build_context_synchronously

// ignore: unused_import
import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:app_firebase_v2/paginaBusqueda.dart';
import 'package:app_firebase_v2/paginaInicio.dart';
import 'package:app_firebase_v2/paginasHistorial%20copy/DatabaseHelper2.dart';
import 'package:app_firebase_v2/util/themes.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'AnimatedTap.dart';
import 'curso HTML/CURSO HTML DESDE CERO/paginaPuente.dart';
import 'paginaInstagram.dart';
import 'util/themeModeNotifier.dart';

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
        child: const paginaMisCursos(),
      ),
    );
  });
}

class paginaMisCursos extends StatefulWidget {
  const paginaMisCursos({super.key});

  @override
  State<paginaMisCursos> createState() => _paginaMisCursosState();
}

class _paginaMisCursosState extends State<paginaMisCursos> {
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  // INICIO INCREMENTADOR DE NUMERO PARA LAS LECCIONES COMPLETADAS

  int _counter = 0;

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  // FIN INCREMENTADOR DE NUMERO PARA LAS LECCIONES COMPLETADAS

  //linear progress______________________
  double progress = 0.0;

  void _setProgress(double value) {
    setState(() {
      progress = value;
      _saveProgress();
    });
  }

  void _saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('progress', progress);
  }

  void _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      progress = prefs.getDouble('progress') ?? 0.0;
    });
  }
  //linear progress______________________
//CONTROL DE TABBAR========================================

  int _currentIndex = 0;
  late TabController _tabController;

  late SharedPreferences _prefsTodos;

  Future<void> _initprefsTodos() async {
    _prefsTodos = await SharedPreferences.getInstance();
    setState(() {
      _currentIndex = _prefsTodos.getInt('tabIndex') ?? 0;
      _tabController.index = _currentIndex;
    });
  }

  void _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController.index;
      _prefsTodos.setInt('tabIndex', _currentIndex);
    });
  }

  //CONTROL DE SCROLL========================================

  final ScrollController _scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadVisibility();
    _loadVisibility1();
    _loadProgress();
    _loadCounter();
    _loadSavedState();
    //guardar posicion pagina
    _scrollController2.addListener(() {
      saveScrollPosition2();
    });
    getScrollPosition2();
    super.initState();
    _initprefsTodos();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _scrollController2.dispose();
    _tabController.dispose();
    super.dispose();
  }

  //CONTROL DE CATEGORIAS HORIZONTAL========================================

  final ScrollController _horizontal = ScrollController();

  //CONTROLADOR DE PAGE VIEW========================================

  PageController controller2 = PageController(
    viewportFraction: 0.65,
    keepPage: true,
    initialPage: 0,
  );

  //SHADER DE TEXTO========================================
  // Personaliza las dimensiones del degradado aquí
  Shader linearGradient2 = const LinearGradient(
    stops: [0.1, 0.95],
    colors: [
      Color.fromARGB(255, 255, 166, 0),
      Color.fromARGB(255, 244, 54, 120)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  Shader linearGradient3 = const LinearGradient(
    stops: [0.1, 0.95],
    colors: [
      Color.fromARGB(255, 229, 255, 0),
      Color.fromARGB(255, 244, 54, 54)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  //CONTAINER DE INTRODUCCION========================================

  bool isContainerVisible = true;

  Future<void> _loadSavedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isContainerVisible = prefs.getBool('isContainerVisible') ?? true;
    });
  }

  Future<void> _saveState(bool isVisible) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isContainerVisible', isVisible);
  }

  //ANIMACION DE LEADER BOARD========================================

  late SharedPreferences _prefsStatus;
  bool _isVisible1 = false;
  bool _isVisible2 = false;
  bool _isVisible3 = false;

  _loadVisibility() async {
    _prefsStatus = await SharedPreferences.getInstance();
    setState(() {
      _isVisible1 = _prefsStatus.getBool('isVisible1') ?? false;
      _isVisible2 = _prefsStatus.getBool('isVisible2') ?? false;
      _isVisible3 = _prefsStatus.getBool('isVisible3') ?? false;
    });
  }

  _saveVisibility() async {
    await _prefsStatus.setBool('isVisible1', _isVisible1);
    await _prefsStatus.setBool('isVisible2', _isVisible2);
    await _prefsStatus.setBool('isVisible3', _isVisible3);
  }

  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  //FUNCIONALIDAD PARA HACER VISIBLE EL ESTADO DEL CURSO EN LA PAGINA "MIS CURSOS" TAB FAVORITOS
  bool _isVisible_1 = false;
  late SharedPreferences _prefsStatus1;

  _loadVisibility1() async {
    _prefsStatus1 = await SharedPreferences.getInstance();
    setState(() {
      _isVisible_1 = _prefsStatus.getBool('isVisible_1') ?? false;
    });
  }

  _saveVisibility1() async {
    await _prefsStatus1.setBool('isVisible_1', _isVisible_1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              floating: true,
              leadingWidth: 32,
              bottom: PreferredSize(
                child: SizedBox(
                  height: 80,
                  child: TabBar(
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: const TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    labelColor: Colors.black,
                    labelPadding: const EdgeInsets.all(15),
                    unselectedLabelStyle: const TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 19),
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.greenAccent),
                    unselectedLabelColor:
                        Theme.of(context).brightness == Brightness.light
                            ? const Color.fromARGB(252, 140, 140, 140)
                            : const Color.fromARGB(255, 170, 170, 170),
                    indicatorColor: Colors.black,
                    controller: _tabController,
                    tabs: [
                      FadeInLeft(
                        from: 10,
                        duration: Duration(milliseconds: 180),
                        delay: Duration(milliseconds: 150),
                        child: Tab(
                          text: 'Todos',
                        ),
                      ),
                      FadeInLeft(
                        from: 10,
                        duration: Duration(milliseconds: 200),
                        delay: Duration(milliseconds: 310),
                        child: Tab(
                          text: 'Marcados Como favoritos ❤️',
                        ),
                      ),
                    ],
                  ),
                ),
                preferredSize: const Size.fromHeight(80.0),
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
                    "Mis Cursos",
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
            ),
          ];
        },
        body: FadeIn(
          duration: const Duration(milliseconds: 150),
          child: RefreshIndicator(
            displacement: 0,
            edgeOffset: 50,
            key: refreshKey,
            onRefresh: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    paginaMisCursos(),
                transitionDuration: Duration(
                    milliseconds:
                        500), // Duración de la transición (ejemplo: 500 milisegundos)
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0.0, 1.0),
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
              padding: const EdgeInsets.only(top: 0),
              physics: const BouncingScrollPhysics(),
              controller: _scrollController2,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: isContainerVisible
                        ? Container(
                            height: 220,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black12
                                      : Colors.white12,
                                  width: 1.2,
                                )),
                            child: Stack(
                              children: [
                                FadeInUp(
                                  from: 30,
                                  duration: Duration(milliseconds: 350),
                                  delay: Duration(milliseconds: 280),
                                  child: SizedBox(
                                      height: 150,
                                      width: double.infinity,
                                      child: Transform.scale(
                                          scale: 1.1,
                                          child: Image.asset(
                                              "assets/images/imgs_cursos/img_descubrir.png"))),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: AnimatedTap(
                                            onTap: () async {
                                              setState(() {
                                                isContainerVisible =
                                                    !isContainerVisible;
                                              });
                                              await _saveState(
                                                  isContainerVisible);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  color: Color.fromARGB(
                                                      255, 255, 113, 113)),
                                              child: const Center(
                                                  child: FaIcon(
                                                      FontAwesomeIcons.xmark,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            "Aqui encontraras los cursos a lo que ingresastes",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : null),
                Container(
                  height: 500,
                  width: double.infinity,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      //============================INICIO TAB 1=================================
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: _isVisible1,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromARGB(20, 0, 0, 0),
                                        blurRadius: 10,
                                        offset: Offset(0, 0),
                                        spreadRadius: 2)
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    height: 130,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<
                                            Color?>(Theme.of(context)
                                                    .brightness ==
                                                Brightness.light
                                            ? Colors.white
                                            : Color.fromARGB(255, 15, 25,
                                                34)), // Cambia el color del botón aquí
                                        elevation: MaterialStateProperty.all<
                                                double>(
                                            0.0), // Cambia la elevación del botón aquí

                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.pressed))
                                              return Color.fromARGB(255, 190,
                                                  143, 255); //<-- SEE HERE
                                            return null; // Defer to the widget's default.
                                          },
                                        ),
                                      ),
                                      onPressed: () {
                                        Future.delayed(
                                            const Duration(milliseconds: 300),
                                            () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .push(
                                            PageRouteBuilder(
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 500),
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  paginaPuente(),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                var begin =
                                                    const Offset(0.0, 1.0);
                                                var end = Offset.zero;
                                                var curve = Curves
                                                    .easeInOutCubicEmphasized;

                                                var tween = Tween(
                                                        begin: begin, end: end)
                                                    .chain(CurveTween(
                                                        curve: curve));

                                                return SlideTransition(
                                                  position:
                                                      animation.drive(tween),
                                                  child: child,
                                                );
                                              },
                                            ),
                                          );
                                        });
                                      },
                                      child: Row(children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: const DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    "assets/images/imgs_cursos/fondo_curso_1.jpg")),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              child: Text(
                                                  "Curso html desde cero",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 17.5,
                                                      height: 1.2,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.black
                                                          : Colors.white)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              child: Text(
                                                "Lecciones completadas:  $_counter",
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Row(
                                                  children: [
                                                    LinearPercentIndicator(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.45,
                                                      curve: Curves
                                                          .easeInOutCubicEmphasized,
                                                      lineHeight: 15,
                                                      percent: progress,
                                                      barRadius:
                                                          Radius.circular(10),
                                                      progressColor:
                                                          Colors.blue,
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              230, 230, 230),
                                                      animation: true,
                                                      animationDuration: 2000,
                                                    ),
                                                    Text(
                                                      '${(progress * 100).toStringAsFixed(0)}%',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? Colors.black
                                                              : Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: _isVisible2,
                            child: Container(
                              color: Colors.green,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: _isVisible3,
                            child: Container(
                              color: Colors.blue,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                      //============================INICIO TAB 2=================================
                      Column(
                        children: [
                          Visibility(
                            visible: _isVisible_1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                color: Colors.green,
                                height: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveScrollPosition2() async {
    SharedPreferences prefsTodos2 = await SharedPreferences.getInstance();
    await prefsTodos2.setDouble('scroll_position2', _scrollController2.offset);
  }

  void getScrollPosition2() async {
    SharedPreferences prefsTodos2 = await SharedPreferences.getInstance();
    double? position = prefsTodos2.getDouble('scroll_position2');
    if (position != null) {
      _scrollController2.jumpTo(position);
    }
  }
}
