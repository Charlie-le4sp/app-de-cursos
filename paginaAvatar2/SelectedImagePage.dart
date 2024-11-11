import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/themeModeNotifier.dart';
import '../util/themes.dart';
import 'avatar.dart';

class SelectedImagePage extends StatefulWidget {
  const SelectedImagePage({super.key});

  @override
  State<SelectedImagePage> createState() => _SelectedImagePageState();

  static Future<Uint8List?> getImageBytes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedImageBytesString =
        prefs.getString('selectedImageBytes') ?? '';
    if (selectedImageBytesString.isNotEmpty) {
      Uint8List selectedImageBytes = base64Decode(selectedImageBytesString);
      return selectedImageBytes;
    }
    return null;
  }
}

class _SelectedImagePageState extends State<SelectedImagePage> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeModeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: themeNotifier.getThemeMode(),
      home: SelectedImagePage2(),
    );
  }
}

class SelectedImagePage2 extends StatelessWidget {
  late String selectedImageName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (BuildContext context,
                AsyncSnapshot<SharedPreferences> snapshot) {
              if (snapshot.hasData) {
                selectedImageName =
                    snapshot.data!.getString('selectedImageName') ?? '';
                String selectedImageBytesString =
                    snapshot.data!.getString('selectedImageBytes') ?? '';
                if (selectedImageName.isNotEmpty &&
                    selectedImageBytesString.isNotEmpty) {
                  Uint8List selectedImageBytes =
                      base64Decode(selectedImageBytesString);
                  final image = MemoryImage(selectedImageBytes);
                  return Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
