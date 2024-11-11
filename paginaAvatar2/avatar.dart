import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';
import 'package:app_firebase_v2/paginaInicio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AnimatedTap.dart';
import '../iintroduction_screen.dart';
import 'SelectedImagePage.dart';

class avatar extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  IconlyBold.info_circle,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  size: 30,
                ),
              )
            ],
            centerTitle: true,
            title: Text(
              "Cambiar Avatar",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Poppins",
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            pinned: true,
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  IconlyLight.arrow_left,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  size: 30,
                )),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color.fromARGB(255, 0, 5, 9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Selecciona Tu Avatar",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Climate", fontSize: 30),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Usaremos este avatar para hacerte sentir mas familiar al usar la apps",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Divider(
                    indent: 25,
                    height: 2,
                    color: Theme.of(context).dividerColor,
                    thickness: 1,
                    endIndent: 25,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverGrid.count(
            crossAxisCount: 2,
            children: imageNames.map((imageName) {
              return FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: AnimatedTap(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    ByteData imageData =
                        await rootBundle.load('assets/$imageName');
                    Uint8List imageBytes = imageData.buffer.asUint8List();
                    String imageBytesString = base64Encode(imageBytes);
                    prefs.setString('selectedImageName', imageName);
                    prefs.setString('selectedImageBytes', imageBytesString);

                    Navigator.of(context, rootNavigator: false).pushReplacement(
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
                    padding: const EdgeInsets.all(8.0),
                    child: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? const Color.fromARGB(12, 0, 0, 0)
                                  : const Color.fromARGB(11, 255, 255, 255),
                              style: BorderStyle.solid,
                              width: 4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 94, 182, 255),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                  image: AssetImage("assets/$imageName"),
                                  fit: BoxFit.contain,
                                ))),
                              ),
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
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 90,
            ),
          )
        ],
      ),
    );
  }
}
