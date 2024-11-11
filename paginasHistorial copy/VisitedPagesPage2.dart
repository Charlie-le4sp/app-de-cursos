import 'dart:async';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AnimatedTap.dart';
import '../util/themeModeNotifier.dart';
import '../util/themes.dart';
import 'DatabaseHelper2.dart';

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
        child: const VisitedPagesPage2(),
      ),
    );
  });
}

class VisitedPagesPage2 extends StatefulWidget {
  const VisitedPagesPage2({super.key});

  @override
  State<VisitedPagesPage2> createState() => _VisitedPagesPage2State();
}

class _VisitedPagesPage2State extends State<VisitedPagesPage2> {
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
  final dbHelper = DatabaseHelper2();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Color.fromARGB(255, 255, 255, 255)
          : const Color.fromARGB(225, 0, 13, 24),
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: true,
                          backgroundColor: Colors.transparent,
                          useRootNavigator: true,
                          builder: (context) => Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 21),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                    child: Container(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? const Color.fromARGB(
                                              255, 255, 255, 255)
                                          : const Color.fromARGB(
                                              225, 0, 13, 24),
                                      child: DraggableScrollableSheet(
                                        initialChildSize: 0.35,
                                        minChildSize: 0.35,
                                        maxChildSize: 0.35,
                                        expand: false,
                                        builder: (_, controller) => ListView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(15.0),
                                                  child: Text(
                                                    "Estas seguro de esto ",
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.bold),
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
                              Positioned(
                                bottom: 0,
                                child: SizedBox(
                                  height: 125,
                                  width:
                                      MediaQuery.of(context).size.width * 1.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AnimatedTap(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 65,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: const Color.fromARGB(
                                                  255, 64, 169, 255)),
                                          child: const Center(
                                            child: Text(
                                              "Cancelar ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      AnimatedTap(
                                        onTap: () {
                                          Navigator.pop(context);
                                          dbHelper.deleteAllpages2();
                                          showCupertinoDialog(
                                              barrierDismissible: true,
                                              context: context,
                                              builder: ((context) =>
                                                  AlertDialog(
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    content: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Container(
                                                          height: 200,
                                                          color: Colors.white,
                                                          child: Center(
                                                              child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                Transform.scale(
                                                              scale: 1.2,
                                                              child:
                                                                  LottieBuilder
                                                                      .asset(
                                                                "assets/lottieAnimations/animacionBien.json",
                                                                frameRate:
                                                                    FrameRate(
                                                                        60),
                                                                reverse: true,
                                                              ),
                                                            ),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  )));
                                        },
                                        child: Container(
                                          height: 65,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.red),
                                          child: const Center(
                                            child: Text(
                                              "Borrar",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold),
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
                      },
                      icon: Icon(
                        IconlyBold.delete,
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color.fromARGB(255, 255, 0, 0)
                            : const Color.fromARGB(255, 255, 0, 0),
                        size: 30,
                      )),
                )
              ],
              centerTitle: true,
              title: Text(
                "Guardados",
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
                  : const Color.fromARGB(225, 0, 13, 24),
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.angleLeft,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    size: 25,
                  )),
            ),
          ];
        },
        body: FutureBuilder<List<String>>(
          future: dbHelper.getVisitedpages2(),
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final pages = snapshot.data!;
              if (pages.isEmpty) {
                // Muestra un mensaje cuando la lista de páginas visitadas está vacía
                return Center(
                    child: Stack(
                  children: [
                    Column(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: LottieBuilder.asset(
                            "assets/lottieAnimations/notfound.json",
                            frameRate: FrameRate(60),
                            reverse: true,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        top: 290,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Sin pagina visitadas ,o se encuentran borradas.",
                                  style: TextStyle(
                                      fontFamily: "Poppins", fontSize: 13),
                                ),
                              ],
                            )))
                  ],
                ));
              } else {
                // Muestra la lista de páginas visitadas cuando hay páginas visitadas
                return Stack(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Total guardados : ",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? const Color.fromARGB(251, 241, 241, 241)
                                  : const Color.fromARGB(255, 0, 20, 36),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              "${pages.length}",
                              style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: pages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 300),
                              child: AnimatedTap(
                                onTap: () {},
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? const Color.fromARGB(
                                            255, 242, 242, 242)
                                        : const Color.fromARGB(
                                            14, 255, 255, 255),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          IconlyBold.heart,
                                          size: 27,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.red
                                              : Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          pages[index],
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
