// ignore_for_file: file_names

import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../paginasCursos/paginaCurso1.dart';
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
        child: const paginaCategoria1(),
      ),
    );
  });
}

// ignore: camel_case_types
class paginaCategoria1 extends StatefulWidget {
  const paginaCategoria1({super.key});

  @override
  State<paginaCategoria1> createState() => _paginaCategoria1State();
}

// ignore: camel_case_types
class _paginaCategoria1State extends State<paginaCategoria1> {
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
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  late String _userName;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      sized: true,
      value: SystemUiOverlayStyle.dark.copyWith(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white10,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: const Color.fromRGBO(98, 0, 237, 1)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            "assets/images/imgs_inicio/fondo_cursos_3.png")),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber),
                height: 220,
                width: double.infinity,
                child: Center(
                  child: SizedBox(
                      height: 250,
                      width: 250,
                      child: Image.asset(
                        "assets/images/imgs_inicio/fondo_slider.png",
                      )),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 3),
              child: Text("Desarrollo web",
                  style:
                      TextStyle(fontSize: 40.5, fontWeight: FontWeight.bold)),
            ),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                  "El desarrollo web es un conjunto de habilidades tecnicas que te permiten, ilustrar , planear y programar sitios web y aplicaciones",
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 18.5,
                  )),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 3),
              child: Text("Algunos de nuestros cursos son:",
                  style: TextStyle(
                    fontSize: 18.5,
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const paginaCurso1(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(4.0, 0.0);
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
              child: FadeInLeft(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(
                  milliseconds: 550,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/imgs_inicio/fondo_curso_1.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 150,
                          height: 100,
                          child: Stack(
                            children: [
                              Positioned(
                                top: -10,
                                left: 80.7,
                                child: Transform.rotate(
                                  angle: 12 * 3.14 / 180,
                                  child: Container(
                                    width: 80.0,
                                    height: 190.0,
                                    color: Colors.transparent,
                                    child: ClipRRect(
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white
                                                          .withOpacity(0.1)),
                                                  gradient:
                                                      const LinearGradient(
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                          colors: [
                                                        Colors.transparent,
                                                        Colors.transparent,
                                                      ])),
                                              child: Container(
                                                height: 110,
                                                width: 110,
                                                color: Colors.transparent,
                                              ))),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: -24,
                                  left: 18,
                                  child: Container(
                                      height: 155,
                                      width: 155,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/imgs_inicio/estudiante.png"),
                                      ))))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 110,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Curso HTML5 basico para noobs",
                                  style: TextStyle(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  "En este curso, aprenderas los conceptos basicos de HTML5...",
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black54
                                          : Colors.white70)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: FadeInLeft(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(
                  milliseconds: 550,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/imgs_inicio/fondo_curso_1.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 150,
                          height: 100,
                          child: Stack(
                            children: [
                              Positioned(
                                top: -10,
                                left: 80.7,
                                child: Transform.rotate(
                                  angle: 12 * 3.14 / 180,
                                  child: Container(
                                    width: 80.0,
                                    height: 190.0,
                                    color: Colors.transparent,
                                    child: ClipRRect(
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white
                                                          .withOpacity(0.1)),
                                                  gradient:
                                                      const LinearGradient(
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                          colors: [
                                                        Colors.transparent,
                                                        Colors.transparent,
                                                      ])),
                                              child: Container(
                                                height: 110,
                                                width: 110,
                                                color: Colors.transparent,
                                              ))),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: -24,
                                  left: 18,
                                  child: Container(
                                      height: 155,
                                      width: 155,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/imgs_inicio/estudiante.png"),
                                      ))))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 110,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Curso HTML5 basico para noobs",
                                  style: TextStyle(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  "En este curso, aprenderas los conceptos basicos de HTML5...",
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black54
                                          : Colors.white70)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: FadeInLeft(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(
                  milliseconds: 550,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/imgs_inicio/fondo_curso_1.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 150,
                          height: 100,
                          child: Stack(
                            children: [
                              Positioned(
                                top: -10,
                                left: 80.7,
                                child: Transform.rotate(
                                  angle: 12 * 3.14 / 180,
                                  child: Container(
                                    width: 80.0,
                                    height: 190.0,
                                    color: Colors.transparent,
                                    child: ClipRRect(
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white
                                                          .withOpacity(0.1)),
                                                  gradient:
                                                      const LinearGradient(
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                          colors: [
                                                        Colors.transparent,
                                                        Colors.transparent,
                                                      ])),
                                              child: Container(
                                                height: 110,
                                                width: 110,
                                                color: Colors.transparent,
                                              ))),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: -24,
                                  left: 18,
                                  child: Container(
                                      height: 155,
                                      width: 155,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/imgs_inicio/estudiante.png"),
                                      ))))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 110,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Curso HTML5 basico para noobs",
                                  style: TextStyle(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  "En este curso, aprenderas los conceptos basicos de HTML5...",
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black54
                                          : Colors.white70)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: FadeInLeft(
                delay: const Duration(milliseconds: 800),
                duration: const Duration(
                  milliseconds: 550,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/imgs_inicio/fondo_curso_1.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 150,
                          height: 100,
                          child: Stack(
                            children: [
                              Positioned(
                                top: -10,
                                left: 80.7,
                                child: Transform.rotate(
                                  angle: 12 * 3.14 / 180,
                                  child: Container(
                                    width: 80.0,
                                    height: 190.0,
                                    color: Colors.transparent,
                                    child: ClipRRect(
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white
                                                          .withOpacity(0.1)),
                                                  gradient:
                                                      const LinearGradient(
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                          colors: [
                                                        Colors.transparent,
                                                        Colors.transparent,
                                                      ])),
                                              child: Container(
                                                height: 110,
                                                width: 110,
                                                color: Colors.transparent,
                                              ))),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: -24,
                                  left: 18,
                                  child: Container(
                                      height: 155,
                                      width: 155,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/imgs_inicio/estudiante.png"),
                                      ))))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 110,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Curso HTML5 basico para noobs",
                                  style: TextStyle(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  "En este curso, aprenderas los conceptos basicos de HTML5...",
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black54
                                          : Colors.white70)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
