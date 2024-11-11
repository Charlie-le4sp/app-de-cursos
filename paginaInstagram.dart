// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api

import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import 'package:flutter/material.dart';

class paginaInstagram extends StatefulWidget {
  const paginaInstagram({super.key});

  @override
  _paginaInstagramState createState() => _paginaInstagramState();
}

class _paginaInstagramState extends State<paginaInstagram> {
  final storyController = StoryController();
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        _visitedPage = _prefs.getBool('visited_page') ?? true;
      });
    });
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  late SharedPreferences _prefs;
  // ignore: unused_field
  bool _visitedPage = false;

  // ignore: unused_element
  void _updateVisitedPage() async {
    await _prefs.setBool('visited_page', false);
    setState(() {
      _visitedPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          StoryView(
            storyItems: [
              StoryItem.inlineProviderImage(
                  caption: const Text("Hola mundo"),
                  const AssetImage(
                      "assets/images/imgs_historias/historia_1.png")),
              StoryItem.inlineProviderImage(
                  caption: const Text("Hola mundo"),
                  const AssetImage(
                      "assets/images/imgs_historias/historia_2.png")),
              StoryItem.inlineProviderImage(
                  caption: const Text("Hola mundo"),
                  const AssetImage(
                      "assets/images/imgs_historias/historia_3.png")),
            ],
            onStoryShow: (s) {},
            onComplete: () {
              Navigator.pop(context);
            },
            progressPosition: ProgressPosition.top,
            repeat: true,
            controller: storyController,
          ),

          // AnimatedTap(
          //   onTap: _updateVisitedPage,
          //   child: Container(
          //     height:200,
          //     width:200,
          //     color: Colors.red,
          //   ),
          // ),
        ],
      ),
    );
  }
}
