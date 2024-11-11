// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: camel_case_types, file_names, file_names, duplicate_ignore, deprecated_member_use

import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '''
package:font_awesome_flutter/font_awesome_flutter.dart''';
import 'package:iconly/iconly.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../AnimatedTap.dart';
import '../curso HTML/CURSO HTML DESDE CERO/lecciones_CURSOHTMLDESDECERO.dart';
import '../util/themeModeNotifier.dart';
import '../util/themes.dart';

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
        child: const paginaCurso2(),
      ),
    );
  });
}

class paginaCurso2 extends StatefulWidget {
  const paginaCurso2({super.key});

  @override
  State<paginaCurso2> createState() => _paginaCurso2State();
}

class _paginaCurso2State extends State<paginaCurso2> {
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
  bool _isVisible = false;

  bool _isLiked = false;
  ScrollController _scrollController = ScrollController();

  bool _isVisible2 = true;
  double _bottomBarPosition = 0.0;
  @override
  void initState() {
    super.initState();
    _loadLikesState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // Scroll hacia abajo
        if (!_isVisible2) {
          setState(() {
            _isVisible2 = true;
            _bottomBarPosition = 0.0;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // Scroll hacia arriba
        if (_isVisible2) {
          setState(() {
            _isVisible2 = false;
            _bottomBarPosition = kBottomNavigationBarHeight;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadLikesState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLiked = prefs.getBool('isLiked') ?? false;
    });
  }

  Future<void> _saveLikesState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLiked', _isLiked);
  }

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color.fromARGB(0, 225, 176, 112))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          const CircularProgressIndicator();
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(
        Uri.parse('https://carlosmariodeveloper.github.io/comentarios-/'));

  Shader linearGradient = const LinearGradient(
    stops: [0.3, 0.5],
    colors: [
      Colors.red,
      Color.fromARGB(255, 243, 205, 33),
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final ScrollController _horizontal = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        //solucion pantalla negra
                        final snackBar = SnackBar(
                          content: FadeInUp(
                            duration: Duration(milliseconds: 250),
                            from: 50,
                            child: Container(
                                height: 50,
                                width: double.infinity,
                                color: Colors.transparent,
                                child: Center(
                                  child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      child: Center(
                                          child: Text("Marcaste este curso"))),
                                )),
                          ),
                          backgroundColor: Color.fromARGB(0, 255, 255, 255),
                          duration: const Duration(seconds: 3),
                          elevation: 0,
                          padding: const EdgeInsets.only(bottom: 8),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: Icon(
                        size: 30,
                        IconlyBold.heart,
                        color: _isLiked ? Colors.red : Colors.black,
                      )),
                )
              ],
              centerTitle: true,
              title: Text(
                "Descripcion",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              pinned: true,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : const Color.fromARGB(255, 0, 0, 0),
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                  icon: Icon(
                    IconlyLight.arrow_left,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    size: 30,
                  )),
            ),
          ];
        },
        body: Scrollbar(
          scrollbarOrientation: ScrollbarOrientation.right,
          radius: const Radius.circular(10),
          child: ListView(
            padding: EdgeInsets.zero,
            controller: _scrollController,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    child: Container(
                      height: 210,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/images/imgs_cursos/fondo_curso_1.jpg")),
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 255, 191, 187),
                      ),

                      // Contenido del container
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                //  color: Colors.red,
                width: MediaQuery.of(context).size.width * 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Curso HTML5 desde cero basico",
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color.fromARGB(252, 0, 0, 0)
                            : const Color.fromARGB(255, 255, 255, 255),
                        fontFamily: "BowlbyOne",
                        fontWeight: FontWeight.w500,
                        fontSize: 26,
                        height: 1.2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      // color:Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(50),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/imgs_instructores/img_ins_1.png'),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              "Carlos Alvarez",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 15.5,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Instructor",
                                                style: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? const TextStyle(
                                                        fontFamily: "Poppins",
                                                        color: Color.fromARGB(
                                                            255, 104, 104, 104),
                                                        fontSize: 13.5,
                                                        fontWeight:
                                                            FontWeight.w500)
                                                    : const TextStyle(
                                                        fontFamily: "Poppins",
                                                        color: Color.fromARGB(
                                                            255, 203, 203, 203),
                                                        fontSize: 13.5,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              AnimatedTap(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    isDismissible: true,
                                    backgroundColor: Colors.transparent,
                                    barrierColor: Colors.black12,
                                    useRootNavigator: true,
                                    builder: (context) => FadeIn(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 8, sigmaY: 8),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 20),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Container(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? const Color.fromARGB(
                                                          255, 255, 255, 255)
                                                      : const Color.fromARGB(
                                                          255, 0, 5, 9),
                                                  child:
                                                      DraggableScrollableSheet(
                                                    initialChildSize: 0.85,
                                                    minChildSize: 0.85,
                                                    maxChildSize: 0.85,
                                                    expand: false,
                                                    builder: (_, controller) =>
                                                        ListView(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: const [
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        child: Center(
                                                                            child:
                                                                                FaIcon(FontAwesomeIcons.share)),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        child: Center(
                                                                            child:
                                                                                Icon(CupertinoIcons.share)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  width: 150,
                                                                  height: 150,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .amber,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                  ),
                                                                  child: Center(
                                                                      child: FadeIn(
                                                                          delay: const Duration(
                                                                              milliseconds:
                                                                                  200),
                                                                          duration: const Duration(
                                                                              milliseconds:
                                                                                  400),
                                                                          child:
                                                                              Image.asset("assets/images/imgs_instructores/img_ins_1.png"))),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        "Carlos Alvarez",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                26,
                                                                            color: Theme.of(context).brightness == Brightness.light
                                                                                ? Colors.black
                                                                                : Colors.white,
                                                                            fontWeight: FontWeight.bold)),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 3,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      "Desarrollador y diseñador",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Theme.of(context).brightness == Brightness.light
                                                                            ? const Color.fromARGB(
                                                                                255,
                                                                                181,
                                                                                181,
                                                                                181)
                                                                            : Colors.white60,
                                                                        fontSize:
                                                                            14.9,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.99,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            20,
                                                                        vertical:
                                                                            15),
                                                                    child: Text(
                                                                        "Carlos Alvarez es un desarrollador y diseñador frontend desde hace mas de 3 años , ha venido trabajando en multiples trabajos , tanto personales como comerciales.",
                                                                        style: Theme.of(context).brightness ==
                                                                                Brightness.light
                                                                            ? const TextStyle(
                                                                                height: 1.4,
                                                                                color: Color.fromARGB(185, 0, 0, 0),
                                                                                fontSize: 17,
                                                                              )
                                                                            : const TextStyle(
                                                                                height: 1.4,
                                                                                color: Colors.white,
                                                                                fontSize: 17,
                                                                              )),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.99,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            20,
                                                                        vertical:
                                                                            15),
                                                                    child: Text(
                                                                        "Carlos  es un desarrollador de aplicaciones y páginas web. Apasionado por la tecnología desde temprana edad, se sumergió en el mundo de la programación para convertir su pasión en su carrera. Con una sólida formación en informática y programación, Carlos ha adquirido habilidades en diversos lenguajes de programación y marcos de trabajo. Su enfoque principal se encuentra en el desarrollo de aplicaciones móviles y páginas web, donde combina su creatividad y conocimiento técnico para crear productos digitales innovadores y funcionales. Carlos disfruta de enfrentar nuevos desafíos, mantenerse actualizado con las últimas tendencias tecnológicas y trabajar en equipo para lograr resultados excepcionales. Su dedicación y compromiso lo convierten en un desarrollador altamente efectivo y confiable.",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .justify,
                                                                        style: Theme.of(context).brightness ==
                                                                                Brightness.light
                                                                            ? const TextStyle(
                                                                                height: 1.4,
                                                                                color: Color.fromARGB(185, 0, 0, 0),
                                                                                fontSize: 17,
                                                                              )
                                                                            : const TextStyle(
                                                                                height: 1.4,
                                                                                color: Colors.white,
                                                                                fontSize: 17,
                                                                              )),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              child: SizedBox(
                                                height: 110,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
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
                                                                          0, 0),
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
                                                          child: const Center(
                                                            child: FaIcon(
                                                              FontAwesomeIcons
                                                                  .close,
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
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.22,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? const Color.fromARGB(9, 0, 0, 0)
                                          : const Color.fromARGB(
                                              56, 255, 255, 255)),
                                  child: Center(
                                    child: Text(
                                      "Ver",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins",
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? const Color.fromARGB(252, 0, 0, 0)
                                            : const Color.fromARGB(
                                                255, 255, 255, 255),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              DefaultTabController(
                length: 3,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 42,
                      width: double.infinity,
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: const TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        labelColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : Colors.black,
                        unselectedLabelStyle: const TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        indicatorPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        indicator: BoxDecoration(
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Color.fromARGB(0, 0, 0, 0)
                                    : Color.fromARGB(0, 255, 255, 255),
                            width: 2,
                          ),
                          color: Color.fromARGB(255, 255, 239, 116),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        unselectedLabelColor:
                            Theme.of(context).brightness == Brightness.light
                                ? const Color.fromARGB(252, 140, 140, 140)
                                : const Color.fromARGB(255, 170, 170, 170),
                        indicatorColor: Colors.black,
                        tabs: const <Widget>[
                          Tab(
                            child: Text(
                              "Contenido",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Temario",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Comentarios",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 3500,
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 23,
                                      width: 23,
                                      child: Icon(
                                        IconlyBold.star,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                        size: 23,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text("16 Lecciones",
                                          style: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? const TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: Colors.black,
                                                  fontSize: 15.5,
                                                )
                                              : const TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: Colors.white,
                                                  fontSize: 15.5,
                                                )),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 23,
                                      width: 23,
                                      child: Icon(
                                        IconlyBold.chart,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                        size: 23,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Row(
                                        children: [
                                          Text("Nivel",
                                              style: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.black,
                                                      fontSize: 15.5,
                                                    )
                                                  : const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.white,
                                                      fontSize: 15.5,
                                                    )),
                                          Text(" • Basico",
                                              style: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Color.fromARGB(
                                                          255, 106, 106, 106),
                                                      fontSize: 15.5,
                                                    )
                                                  : const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Color.fromARGB(
                                                          255, 214, 214, 214),
                                                      fontSize: 15.5,
                                                    )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 23,
                                      width: 23,
                                      child: Icon(
                                        IconlyBold.editSquare,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                        size: 23,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Row(
                                        children: [
                                          Text("Ultima actualizacion",
                                              style: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.black,
                                                      fontSize: 15.5,
                                                    )
                                                  : const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.white,
                                                      fontSize: 15.5,
                                                    )),
                                          Text(" • Enero 2023",
                                              style: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Color.fromARGB(
                                                          255, 106, 106, 106),
                                                      fontSize: 15.5,
                                                    )
                                                  : const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Color.fromARGB(
                                                          255, 214, 214, 214),
                                                      fontSize: 15.5,
                                                    )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 23,
                                      width: 23,
                                      child: FaIcon(
                                        FontAwesomeIcons.handFist,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                        size: 23,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Row(
                                        children: [
                                          Text("Proyectos",
                                              style: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.black,
                                                      fontSize: 15.5,
                                                    )
                                                  : const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.white,
                                                      fontSize: 15.5,
                                                    )),
                                          Text(" • 1",
                                              style: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 106, 106, 106),
                                                      fontSize: 15.5,
                                                    )
                                                  : const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 214, 214, 214),
                                                      fontSize: 15.5,
                                                    )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 29,
                                ),
                                Row(
                                  children: [
                                    Text("Descripcion",
                                        style: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? const TextStyle(
                                                fontFamily: "Poppins",
                                                color: Colors.black,
                                                fontSize: 20.5,
                                                fontWeight: FontWeight.bold)
                                            : const TextStyle(
                                                fontFamily: "Poppins",
                                                color: Colors.white,
                                                fontSize: 20.5,
                                                fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  children: [
                                    Text(
                                        "En este curso, aprenderás los conceptos básicos de HTML5, desde cómo crear etiquetas y elementos hasta cómo estructurar páginas web, agregar enlaces y crear formularios. ",
                                        style: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? const TextStyle(
                                                fontFamily: "Poppins",
                                                height: 1.4,
                                                fontSize: 18.5,
                                                color: Colors.black,
                                              )
                                            : const TextStyle(
                                                fontFamily: "Poppins",
                                                height: 1.4,
                                                color: Colors.white,
                                                fontSize: 18.5,
                                              )),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    if (_isVisible)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                              "HTML5 suele ser un buen punto de partida para aprender a crear sitios web. HTML5 es el lenguaje de marcado que se utiliza para crear la estructura y el contenido de un sitio web, y es una de las tecnologías fundamentales en el desarrollo web.",
                                              style: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? const TextStyle(
                                                      fontFamily: "Poppins",
                                                      height: 1.4,
                                                      color: Colors.black,
                                                      fontSize: 18.5,
                                                    )
                                                  : const TextStyle(
                                                      fontFamily: "Poppins",
                                                      height: 1.4,
                                                      color: Colors.white,
                                                      fontSize: 18.5,
                                                    )),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text("Crear sitios web  dinamicos",
                                              style: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.black,
                                                      fontSize: 18.5,
                                                      fontWeight:
                                                          FontWeight.w600)
                                                  : const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.white,
                                                      fontSize: 18.5,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                              "Además, el curso probablemente te enseñará cómo crear sitios web responsivos, lo que significa que tus páginas web se ajustarán automáticamente al tamaño de la pantalla en la que se están visualizando, ya sea en un ordenador de escritorio, una tableta o un teléfono móvil. ",
                                              style: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? const TextStyle(
                                                      fontFamily: "Poppins",
                                                      height: 1.4,
                                                      color: Colors.black,
                                                      fontSize: 18.5,
                                                    )
                                                  : const TextStyle(
                                                      fontFamily: "Poppins",
                                                      height: 1.4,
                                                      color: Colors.white,
                                                      fontSize: 18.5,
                                                    )),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isVisible = !_isVisible;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? const Color.fromARGB(
                                                        255, 214, 214, 214)
                                                    : Colors.white24,
                                                width: 2,
                                                style: BorderStyle.solid)),
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    _isVisible
                                                        ? "Ver menos"
                                                        : "Ver más",
                                                    style: Theme.of(
                                                                    context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? const TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            color:
                                                                Color
                                                                    .fromARGB(
                                                                        255,
                                                                        98,
                                                                        0,
                                                                        237),
                                                            fontSize: 17.5,
                                                            fontWeight:
                                                                FontWeight.w700)
                                                        : const TextStyle(
                                                            fontFamily:
                                                                "Poppins",
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    149,
                                                                    73,
                                                                    255),
                                                            fontSize: 17.5,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: FaIcon(
                                                    _isVisible
                                                        ? FontAwesomeIcons
                                                            .angleRight
                                                        : FontAwesomeIcons
                                                            .angleDown,
                                                    size: 20,
                                                    color: const Color.fromARGB(
                                                        255, 149, 73, 255),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Proyectos",
                                              style: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.black,
                                                      fontSize: 20.5,
                                                      fontWeight:
                                                          FontWeight.bold)
                                                  : const TextStyle(
                                                      fontFamily: "Poppins",
                                                      color: Colors.white,
                                                      fontSize: 20.5,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      RawScrollbar(
                                        mainAxisMargin: 20,
                                        trackBorderColor: Colors.transparent,
                                        radius: const Radius.circular(10),
                                        thumbVisibility: true,
                                        trackColor: Colors.transparent,
                                        trackVisibility: true,
                                        thumbColor:
                                            Theme.of(context).brightness ==
                                                    Brightness.light
                                                ? const Color.fromARGB(
                                                    255, 230, 230, 230)
                                                : Colors.white30,
                                        controller: _horizontal,
                                        child: SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          controller: _horizontal,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.amber,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      height: 120,
                                                      width: 120,
                                                      child: Stack(
                                                        children: const [],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.amber,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      height: 120,
                                                      width: 120,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.amber,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      height: 120,
                                                      width: 120,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 95)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          //temario
                          Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Column(
                                children: [
                                  FadeInLeft(
                                    from: 50,
                                    delay: const Duration(milliseconds: 180),
                                    duration: const Duration(milliseconds: 350),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color.fromARGB(
                                                        9, 0, 0, 0)
                                                    : const Color.fromARGB(
                                                        56, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            trailing: Column(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: FaIcon(FontAwesomeIcons
                                                      .angleDown),
                                                ),
                                              ],
                                            ),
                                            backgroundColor: Colors.transparent,
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child: Center(
                                                        child: FaIcon(
                                                      FontAwesomeIcons
                                                          .locationDot,
                                                      size: 25,
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                    )),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Introduccion",
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            children: <Widget>[
                                              Container(
                                                height: 110,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Text(
                                                              "• ¿Que es HTML5?",
                                                              style: TextStyle(
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
                                                                fontSize: 16,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            child: Text(
                                                                "• Estructura básica de un documento HTML5",
                                                                style:
                                                                    TextStyle(
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
                                                                  fontSize: 16,
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            child: Text(
                                                                "•  Etiquetas principales de HTML5",
                                                                style:
                                                                    TextStyle(
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
                                                                  fontSize: 16,
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  FadeInLeft(
                                    from: 50,
                                    delay: const Duration(milliseconds: 180),
                                    duration: const Duration(milliseconds: 350),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color.fromARGB(
                                                        9, 0, 0, 0)
                                                    : const Color.fromARGB(
                                                        56, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            trailing: Column(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: FaIcon(FontAwesomeIcons
                                                      .angleDown),
                                                ),
                                              ],
                                            ),
                                            backgroundColor: Colors.transparent,
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child: Center(
                                                        child: FaIcon(
                                                      FontAwesomeIcons.code,
                                                      size: 25,
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                    )),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Etiquetas de texto",
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            children: <Widget>[
                                              Container(
                                                height: 95,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Text(
                                                              "• Encabezados (h1-h6)",
                                                              style: TextStyle(
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
                                                                fontSize: 16,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            child: Text(
                                                                "• Párrafos (p)",
                                                                style:
                                                                    TextStyle(
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
                                                                  fontSize: 16,
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            child: Text(
                                                                "•  Saltos de línea (br)",
                                                                style:
                                                                    TextStyle(
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
                                                                  fontSize: 16,
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  FadeInLeft(
                                    from: 50,
                                    delay: const Duration(milliseconds: 180),
                                    duration: const Duration(milliseconds: 350),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color.fromARGB(
                                                        9, 0, 0, 0)
                                                    : const Color.fromARGB(
                                                        56, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            trailing: Column(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: FaIcon(FontAwesomeIcons
                                                      .angleDown),
                                                ),
                                              ],
                                            ),
                                            backgroundColor: Colors.transparent,
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child: Center(
                                                        child: FaIcon(
                                                      FontAwesomeIcons.link,
                                                      size: 25,
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                    )),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Enlaces",
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            children: <Widget>[
                                              Container(
                                                height: 110,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Text(
                                                              "• Etiqueta de enlace (a)",
                                                              style: TextStyle(
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
                                                                fontSize: 16,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            child: Text(
                                                                "• Hipervínculos a otras páginas",
                                                                style:
                                                                    TextStyle(
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
                                                                  fontSize: 16,
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            child: Text(
                                                                "•  Hipervínculos a secciones en la misma página",
                                                                style:
                                                                    TextStyle(
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
                                                                  fontSize: 16,
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  FadeInLeft(
                                    from: 50,
                                    delay: const Duration(milliseconds: 180),
                                    duration: const Duration(milliseconds: 350),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color.fromARGB(
                                                        9, 0, 0, 0)
                                                    : const Color.fromARGB(
                                                        56, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            trailing: Column(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: FaIcon(FontAwesomeIcons
                                                      .angleDown),
                                                ),
                                              ],
                                            ),
                                            backgroundColor: Colors.transparent,
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child: Center(
                                                        child: FaIcon(
                                                      FontAwesomeIcons.image,
                                                      size: 30,
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                    )),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Imágenes",
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            children: <Widget>[
                                              Container(
                                                height: 140,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Text(
                                                              "• Etiqueta de imagen (img)",
                                                              style: TextStyle(
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
                                                                fontSize: 16,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            child: Text(
                                                                "• Inserción de imágenes en una página",
                                                                style:
                                                                    TextStyle(
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
                                                                  fontSize: 16,
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            child: Text(
                                                                "•  Atributos de imagen (src, alt, width, height)",
                                                                style:
                                                                    TextStyle(
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
                                                                  fontSize: 16,
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          //comenta
                          Stack(children: [
                            SizedBox(
                                height: 1000,
                                child: WebViewWidget(controller: controller)),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  useRootNavigator: true,
                                  builder: (context) =>
                                      DraggableScrollableSheet(
                                    initialChildSize: 0.42,
                                    minChildSize: 0.42,
                                    maxChildSize: 0.75,
                                    expand: false,
                                    builder: (_, controller) => ListView(
                                      physics: const BouncingScrollPhysics(),
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 2, top: 9),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 4.5,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  5),
                                                          color: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  214,
                                                                  214,
                                                                  214)
                                                              : Colors.white24),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 0,
                                                        left: 10,
                                                        right: 10),
                                                    child: Text(
                                                      "primero debes iniciar sesion",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: const [
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FadeInUp(
        from: 50,
        duration: const Duration(milliseconds: 250),
        delay: const Duration(milliseconds: 400),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(0.0, _bottomBarPosition, 0.0),
            child: OpenContainer(
              transitionDuration: const Duration(milliseconds: 600),
              closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              closedColor: const Color.fromARGB(255, 107, 21, 255),
              closedElevation: 0,
              openBuilder: (context, _) => Container(
                  color: Colors.amber, child: lecciones_CURSOHTMLDESDECERO()),
              closedBuilder: (context, _) => const SizedBox(
                  height: 70,
                  child: Center(
                    child: Text("Ir al curso",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
