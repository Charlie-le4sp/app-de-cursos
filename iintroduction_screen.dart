// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: camel_case_types, file_names, duplicate_ignore, unnecessary_import, unused_element

import 'dart:async';
import 'dart:convert';
import 'dart:ui' show Color, FontWeight, ImageFilter, Offset, TextAlign;

import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart'
    show AnimatedTextKit, TyperAnimatedText;
import 'package:app_firebase_v2/paginaBotonLogin.dart';
import 'package:app_firebase_v2/paginaHome.dart';
import 'package:app_firebase_v2/util/themeModeNotifier.dart';
import 'package:app_firebase_v2/util/themes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vibration/vibration.dart';

import 'AnimatedTap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
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
        child: const IntroScreen(),
      ),
    );
  });
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
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
  ///Changed a little bit of buttons styling and text for the thumbnail lol
  ///Thanks for coming here :-)
  final controller = PageController();

  bool isLastPage = false;

  bool canProceed = false;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  double _buttonSize = 100;

  void _handlePress() {
    setState(() {
      _buttonSize = _buttonSize == 100 ? 50 : 100;
    });
  }

  double _progressValue = 0;
  final List<String> imageNames = [
    "images/avatars/avatar_1.png",
    "images/avatars/avatar_2.png",
    "images/avatars/avatar_3.png",
    "images/avatars/avatar_4.png",
    "images/avatars/avatar_5.png",
    "images/avatars/avatar_6.png",
    "images/avatars/avatar_7.png",
    "images/avatars/avatar_8.png",
    "images/avatars/avatar_9.png",
    "images/avatars/avatar_10.png",
    "images/avatars/avatar_11.png",
    "images/avatars/avatar_12.png",
    "images/avatars/avatar_13.png",
    "images/avatars/avatar_14.png",
    "images/avatars/avatar_15.png",
    "images/avatars/avatar_16.png",
    "images/avatars/avatar_17.png",
    "images/avatars/avatar_18.png",
    "images/avatars/avatar_19.png",
    "images/avatars/avatar_20.png",
    "images/avatars/avatar_21.png",
    "images/avatars/avatar_22.png",
    "images/avatars/avatar_23.png",
    "images/avatars/avatar_24.png",
    "images/avatars/avatar_25.png",
    "images/avatars/avatar_26.png",
  ];
  bool _isSelected = false;
  String selectedImageName = '';
  final _formKey = GlobalKey<FormState>();
  late String _userName;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Color.fromARGB(255, 0, 5, 9),
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
              collapsedHeight: 60,
              elevation: 0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 300,
                        height: 10,
                        color: Colors.amber,
                        child: TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          tween: Tween<double>(
                            begin: 0,
                            end: 100,
                          ),
                          builder: (context, value, _) =>
                              LinearProgressIndicator(
                            value: _progressValue,
                            minHeight: 20,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color.fromARGB(255, 99, 0, 237)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: Stack(
            children: [
              PageView(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    isLastPage = index == 4;
                    _progressValue = (index + 1) / 5;
                  });
                },
                controller: controller,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: AnimatedTextKit(
                              pause: const Duration(seconds: 1),
                              repeatForever: false,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(
                                    textAlign: TextAlign.center,
                                    textStyle: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27.5,
                                    ),
                                    speed: const Duration(milliseconds: 50),
                                    curve: Curves.easeOutSine,
                                    "Bienvenido a University Learn App"),
                              ]),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        SizedBox(
                          height: 180,
                          child: Transform.scale(
                            scale: 1.6,
                            child: LottieBuilder.asset(
                              "assets/lottieAnimations/mujer_estudiando.json",
                              frameRate: FrameRate(60),
                              reverse: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeInUp(
                              from: 40,
                              duration: const Duration(milliseconds: 600),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.88,
                                child: Text(
                                  "Únete a nuestra app y descubre todo lo que podemos ofrecerte",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * 1.4,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 120,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: AnimatedTextKit(
                                    pause: const Duration(seconds: 1),
                                    repeatForever: false,
                                    totalRepeatCount: 1,
                                    animatedTexts: [
                                      TyperAnimatedText(
                                          textAlign: TextAlign.center,
                                          textStyle: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 27.5,
                                          ),
                                          speed:
                                              const Duration(milliseconds: 50),
                                          curve: Curves.easeOutSine,
                                          "Tu compañero de camino hacia el éxito"),
                                    ]),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          SizedBox(
                            height: 180,
                            child: Transform.scale(
                              scale: 1.5,
                              child: LottieBuilder.asset(
                                "assets/lottieAnimations/exitoso.json",
                                frameRate: FrameRate(60),
                                reverse: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FadeInUp(
                                from: 40,
                                duration: const Duration(milliseconds: 600),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.84,
                                  child: Text(
                                    "Encuentra el camino hacia tus metas en nuestra app",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: AnimatedTextKit(
                              pause: const Duration(seconds: 1),
                              repeatForever: false,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(
                                    textAlign: TextAlign.center,
                                    textStyle: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27.5,
                                    ),
                                    speed: const Duration(milliseconds: 50),
                                    curve: Curves.easeOutSine,
                                    "Comparte con una gran comunidad"),
                              ]),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        SizedBox(
                          height: 180,
                          child: Transform.scale(
                            scale: 1.1,
                            child: LottieBuilder.asset(
                              "assets/lottieAnimations/hombre_estudiando.json",
                              frameRate: FrameRate(60),
                              reverse: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeInUp(
                              from: 40,
                              duration: const Duration(milliseconds: 600),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.88,
                                child: Text(
                                  "Unidos hacemos mas con nuestros cursos",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : const Color.fromARGB(255, 0, 5, 9),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text(
                                "Personalicemos tu experiencia",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 15),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: Text(
                                  "Selecciona un avatar ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontFamily: "Poppins",
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 420,
                          child: CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            slivers: [
                              SliverGrid.count(
                                crossAxisCount: 2,
                                children: imageNames.map((imageName) {
                                  return FadeInUp(
                                    duration: const Duration(milliseconds: 500),
                                    child: GestureDetector(
                                      onTapDown: (_) {
                                        setState(() {});
                                      },
                                      onTapUp: (_) {
                                        setState(() {});
                                      },
                                      onTap: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        ByteData imageData = await rootBundle
                                            .load('assets/$imageName');
                                        Uint8List imageBytes =
                                            imageData.buffer.asUint8List();
                                        String imageBytesString =
                                            base64Encode(imageBytes);
                                        setState(() {
                                          selectedImageName = imageName;
                                          _isSelected = true;
                                        });
                                        prefs.setString(
                                            'selectedImageName', imageName);
                                        prefs.setString('selectedImageBytes',
                                            imageBytesString);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FadeIn(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: _isSelected &&
                                                      imageName ==
                                                          selectedImageName
                                                  ? Border.all(
                                                      color: Colors.blue,
                                                      style: BorderStyle.solid,
                                                      width: 6)
                                                  : Border.all(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? const Color
                                                                  .fromARGB(
                                                              12, 0, 0, 0)
                                                          : const Color
                                                                  .fromARGB(11,
                                                              255, 255, 255),
                                                      style: BorderStyle.solid,
                                                      width: 4),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 150,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: AssetImage(
                                                          "assets/$imageName")),
                                                ),
                                                child: _isSelected &&
                                                        imageName ==
                                                            selectedImageName
                                                    ? Stack(
                                                        children: [
                                                          Container(
                                                            height: 150,
                                                            width: 150,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100)),
                                                          ),
                                                          Positioned(
                                                              left: 0,
                                                              child: ZoomIn(
                                                                  duration: const Duration(
                                                                      milliseconds:
                                                                          200),
                                                                  child:
                                                                      const FaIcon(
                                                                    FontAwesomeIcons
                                                                        .solidCircleCheck,
                                                                    color: Colors
                                                                        .lightGreen,
                                                                    size: 32,
                                                                  )))
                                                        ],
                                                      )
                                                    : Container(
                                                        height: 150,
                                                        width: 150,
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : const Color.fromARGB(255, 0, 5, 9),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text(
                                "Un ultimo paso",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: Text(
                                  "Escribe tu nombre o un apodo ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontFamily: "Poppins",
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromARGB(
                                        255, 255, 230, 155)),
                                height: 110,
                                width: double.infinity,
                                child: Form(
                                  key: _formKey,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          errorStyle: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Poppins",
                                              color: Color.fromARGB(
                                                  255, 255, 17, 0),
                                              fontWeight: FontWeight.bold),
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  230, 117, 117, 117),
                                              fontSize: 18),
                                          counterStyle: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 15),
                                          labelText: 'Nombre de Usuario',
                                        ),
                                        maxLength: 15,
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontFamily: "Poppins",
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.bold),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Introduce un nombre';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) => _userName = value!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            child: Text(
                              "Conecta tu cuenta de google para disfrutar de todas ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [paginaBotonLogin()],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 38,
                  ),
                ],
              )
            ],
          ),
          bottomNavigationBar: isLastPage
              ? Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    height: 80,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AnimatedTap(
                            scale: 0.7,
                            onTap: () => controller.jumpToPage(0),
                            child: FadeIn(
                              child: Container(
                                height: 72,
                                width: 72,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.arrowLeft,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AnimatedTap(
                            scale: 0.8,
                            onTap: () {
                              if (_isSelected) {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  saveUserName(_userName);
                                  onDone(context);
                                }
                              } else {
                                controller.animateToPage(3,
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              }
                            },
                            child: FadeIn(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                height: 72,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Center(
                                  child: Text(
                                    "Vamos!",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                      child: Container(
                        height: 80,
                        color: const Color.fromARGB(255, 241, 241, 241),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SmoothPageIndicator(
                                    controller: controller,
                                    effect: const ExpandingDotsEffect(
                                        activeDotColor: Colors.black,
                                        dotHeight: 13,
                                        expansionFactor: 2.5,
                                        dotColor: Colors.black12,
                                        dotWidth: 13),
                                    onDotClicked: (index) => controller
                                        .animateToPage(index,
                                            duration: const Duration(
                                                milliseconds: 700),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn),
                                    count: 5),
                              ),
                              AnimatedTap(
                                scale: 0.8,
                                onTap: () {
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 700),
                                      curve: Curves.fastLinearToSlowEaseIn);
                                  Vibration.vibrate(duration: 20);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color:
                                          const Color.fromARGB(255, 99, 0, 237),
                                    ),
                                    height: 70,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      child: Row(
                                        children: const [
                                          Text(
                                            "Siguiente",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.arrowRight,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ));
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const paginaHome(),
        transitionDuration: const Duration(
            milliseconds:
                500), // Duración de la transición (ejemplo: 500 milisegundos)
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
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
    );
  }

  Future<void> saveUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userName);
  }
}
