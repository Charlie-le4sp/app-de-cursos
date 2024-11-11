import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:app_firebase_v2/paginaBotonLogin.dart';
import 'package:app_firebase_v2/util/themeModeNotifier.dart';
import 'package:app_firebase_v2/util/themes.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../AnimatedTap.dart';

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
        child: const paginaAjustes(),
      ),
    );
  });
}

class paginaAjustes extends StatefulWidget {
  const paginaAjustes({super.key});

  @override
  State<paginaAjustes> createState() => _paginaAjustesState();
}

class _paginaAjustesState extends State<paginaAjustes> {
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
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //controller texto
  final _textController = TextEditingController();

  void _resetPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const MyHomePage()),
    );
  }

  @override
  void initState() {
    super.initState();

    _getUserInfo();
    checkLoginStatus();
    _future = getUserName(); // inicializa _future con un valor antes de su uso
  }

  Future<void> _refresh() async {
    setState(() {
      _future = getUserName();
    });
  }

  GoogleSignInAccount? _googleUser;
  bool _isLoggedIn = false;
  Future<void> _logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    setState(() {
      _isLoggedIn = false;
      _googleUser = null;
      _userImageUrl = null;
      _userEmail = null;
    });
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
    if (!_isLoggedIn) {
      Future.delayed(const Duration(seconds: 1), () {
        showDialog(
            barrierColor: Colors.black12,
            context: context,
            barrierDismissible: true,
            builder: ((context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: ElasticIn(
                    duration: const Duration(milliseconds: 600),
                    child: AlertDialog(
                      contentPadding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      content: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [
                              0.011, //opacidad
                              0.99
                            ],
                            colors: [
                              Color.fromARGB(255, 156, 107, 255),
                              Color.fromARGB(255, 57, 0, 172),
                            ],
                          ),
                        ),
                        height: 400,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Center(
                              child: Text(
                                "Inicia sesion en Google",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              height: 110,
                              child: Transform.scale(
                                scale: 1.5,
                                child: LottieBuilder.asset(
                                  "assets/lottieAnimations/launchAnimation.json",
                                  frameRate: FrameRate(60),
                                  reverse: true,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 9),
                              child: paginaBotonLogin(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 9),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          // Change your radius here
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      FaIcon(
                                        FontAwesomeIcons.close,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Cerrar',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {});
      if (_isLoggedIn) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      }
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String? _userName;
  String? _userEmail;
  String? _userImageUrl;

  Future<void> _getUserInfo() async {
    final user = _auth.currentUser;
    setState(() {
      if (user != null) {
        _userName = user.displayName;
      }
      _userEmail = user?.email;
      _userImageUrl = user?.photoURL;
    });
  }

  bool _isRefreshing = false;

  // Método para recargar la página
  Future<void> _refreshPage() async {
    setState(() {
      _isRefreshing = true;
    });
    await Future.delayed(const Duration(seconds: 2)); // simulación de carga
    setState(() {
      _isRefreshing = false;
    });
  }

  late Future<String> _future;
  Shader linearGradient2 = const LinearGradient(
    stops: [0.1, 0.9],
    colors: [
      Color.fromARGB(255, 0, 85, 255),
      Color.fromARGB(255, 244, 54, 120)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 280.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              collapsedHeight: 60,
              centerTitle: true,
              title: Text(
                "Ajustes",
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
                  ? Colors.white
                  : Colors.black,
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
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder<SharedPreferences>(
                        future: SharedPreferences.getInstance(),
                        builder: (BuildContext context,
                            AsyncSnapshot<SharedPreferences> snapshot) {
                          if (snapshot.hasData) {
                            String selectedImageName =
                                snapshot.data!.getString('selectedImageName') ??
                                    '';
                            String selectedImageBytesString = snapshot.data!
                                    .getString('selectedImageBytes') ??
                                '';
                            if (selectedImageName.isNotEmpty &&
                                selectedImageBytesString.isNotEmpty) {
                              Uint8List selectedImageBytes =
                                  base64Decode(selectedImageBytesString);
                              final image = MemoryImage(selectedImageBytes);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? const Color.fromARGB(9, 0, 0, 0)
                                              : const Color.fromARGB(
                                                  56, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                            image: image,
                                            fit: BoxFit.contain,
                                          ))),
                                        ),
                                      ),
                                    ),
                                    _isLoggedIn
                                        ? Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: ZoomIn(
                                              duration: const Duration(
                                                  milliseconds: 250),
                                              child: Container(
                                                height: 55,
                                                width: 55,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 3,
                                                    color: Colors.white,
                                                  ),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        _userImageUrl ?? ''),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
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
                      //
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder<String>(
                        future: _future,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              "${snapshot.data}",
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),
                  //            Text(
                  //   'Conectado como : $_userName',
                  //   style: TextStyle(fontSize: 20),
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isLoggedIn
                          ? Text(
                              '$_userEmail',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Roboto",
                                  color: Colors.blue),
                            )
                          : const Text(
                              "Aun no conectado a Google :(",
                              style: TextStyle(
                                  fontFamily: "Poppins", color: Colors.red),
                            )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            FadeInLeft(
              from: 50,
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 350),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color.fromARGB(9, 0, 0, 0)
                          : const Color.fromARGB(56, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20)),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      trailing: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FaIcon(FontAwesomeIcons.angleDown),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.transparent,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 50,
                              width: 50,
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.google,
                                size: 30,
                                color: Color.fromARGB(255, 172, 123, 255),
                              )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Cuenta de google ",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
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
                        SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              _isLoggedIn
                                  ? const SizedBox()
                                  : FadeInLeft(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      from: 30,
                                      delay: const Duration(milliseconds: 200),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 120,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              stops: [
                                                0.011, //opacidad
                                                0.99
                                              ],
                                              colors: [
                                                Color.fromARGB(
                                                    255, 156, 107, 255),
                                                Color.fromARGB(255, 57, 0, 172),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height: 120,
                                                    width: 120,
                                                    child: Transform.scale(
                                                        scale: 1.3,
                                                        child: Image.asset(
                                                            "assets/lottieAnimations/no_google.gif")),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  height: 120,
                                                  child: Center(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const SizedBox(
                                                            width: 170,
                                                            child: Text(
                                                              "¿Aun no estas conectado?",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15,
                                                                  height: 1.2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          ElevatedButton(
                                                              style:
                                                                  ButtonStyle(
                                                                      shape: MaterialStateProperty
                                                                          .all(
                                                                        RoundedRectangleBorder(
                                                                          // Change your radius here
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                      ),
                                                                      backgroundColor: MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .amber)),
                                                              onPressed: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        true,
                                                                    barrierColor:
                                                                        Colors
                                                                            .black12,
                                                                    builder:
                                                                        ((context) =>
                                                                            BackdropFilter(
                                                                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                                                              child: ElasticIn(
                                                                                duration: const Duration(milliseconds: 600),
                                                                                child: AlertDialog(
                                                                                  contentPadding: const EdgeInsets.all(0),
                                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                  content: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                      gradient: const LinearGradient(
                                                                                        begin: Alignment.centerLeft,
                                                                                        end: Alignment.centerRight,
                                                                                        stops: [
                                                                                          0.011, //opacidad
                                                                                          0.99
                                                                                        ],
                                                                                        colors: [
                                                                                          Color.fromARGB(255, 156, 107, 255),
                                                                                          Color.fromARGB(255, 57, 0, 172),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    height: 400,
                                                                                    child: Column(
                                                                                      children: [
                                                                                        const SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        const Center(
                                                                                          child: Text(
                                                                                            "Inicia sesion en Google",
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: "Poppins", fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 40,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 110,
                                                                                          child: Transform.scale(
                                                                                            scale: 1.5,
                                                                                            child: LottieBuilder.asset(
                                                                                              "assets/lottieAnimations/launchAnimation.json",
                                                                                              frameRate: FrameRate(60),
                                                                                              reverse: true,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 20,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 9),
                                                                                          child: paginaBotonLogin(),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 9),
                                                                                          child: SizedBox(
                                                                                            width: MediaQuery.of(context).size.width * 0.75,
                                                                                            height: 60,
                                                                                            child: ElevatedButton(
                                                                                              style: ButtonStyle(
                                                                                                  shape: MaterialStateProperty.all(
                                                                                                    RoundedRectangleBorder(
                                                                                                      // Change your radius here
                                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                                    ),
                                                                                                  ),
                                                                                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: const [
                                                                                                  FaIcon(
                                                                                                    FontAwesomeIcons.close,
                                                                                                    color: Colors.white,
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    width: 10,
                                                                                                  ),
                                                                                                  Text('Cerrar', style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 15, fontWeight: FontWeight.bold)),
                                                                                                ],
                                                                                              ),
                                                                                              onPressed: () {
                                                                                                Navigator.of(context).popUntil((route) => route.isFirst);
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )));
                                                              },
                                                              child: const Text(
                                                                "Iniciar sesion",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  )))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              _isLoggedIn
                                  ? TextButton(
                                      onPressed: () {
                                        showDialog(
                                            barrierColor: Colors.black12,
                                            context: context,
                                            barrierDismissible: true,
                                            builder: ((context) =>
                                                BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaX: 10, sigmaY: 10),
                                                  child: ElasticIn(
                                                    duration: const Duration(
                                                        milliseconds: 600),
                                                    child: AlertDialog(
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      content: SizedBox(
                                                        height: 400,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      _logout();
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: const Text(
                                                                        "Si salir")),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: const Text(
                                                                        "cancelar")),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'cerrar sesion',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 21.0,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const FaIcon(
                                            FontAwesomeIcons.rightFromBracket,
                                            color: Colors.red,
                                          )
                                        ],
                                      ))
                                  : const SizedBox()
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
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 350),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color.fromARGB(9, 0, 0, 0)
                          : const Color.fromARGB(56, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20)),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      trailing: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FaIcon(FontAwesomeIcons.angleDown),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.transparent,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 50,
                              width: 50,
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.google,
                                size: 30,
                                color: Colors.black,
                              )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Notificaciones",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
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
                        Container(height: 200),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            FadeInLeft(
              from: 50,
              delay: const Duration(milliseconds: 450),
              duration: const Duration(milliseconds: 350),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color.fromARGB(9, 0, 0, 0)
                          : const Color.fromARGB(56, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20)),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      trailing: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FaIcon(FontAwesomeIcons.angleDown),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.transparent,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 50,
                              width: 50,
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.google,
                                size: 30,
                                color: Colors.black,
                              )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Almacenamiento",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
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
                            height: 200,
                            child: ElevatedButton(
                              onPressed: () async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                await preferences.clear();

                                // Reiniciar la aplicación
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/', (_) => false);
                              },
                              child: const Text("Eliminar todo"),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? '';
  }
}

class badgeAjustes extends StatefulWidget {
  const badgeAjustes({super.key});

  @override
  State<badgeAjustes> createState() => _badgeAjustesState();
}

class _badgeAjustesState extends State<badgeAjustes> {
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: _isLoggedIn
          ? const SizedBox()
          : Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(50)),
              height: 20,
              width: 20,
              child: const Center(
                  child: Text("1",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)))),
    );
  }
}
