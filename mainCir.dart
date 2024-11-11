import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'curso HTML/CURSO HTML DESDE CERO/CIRCULAR_PROGRESS_CURSOHTMLDESDECERO.dart';
import 'page_b.dart';

void main() => runApp(const hola());

class hola extends StatelessWidget {
  const hola({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/pageB') {
          return MaterialPageRoute(
            builder: (context) => const PageB(),
          );
        }
        return null;
      },
      routes: {
        '/': (context) => const CIRCULAR_PROGRESS_CURSOHTMLDESDECERO(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const CIRCULAR_PROGRESS_CURSOHTMLDESDECERO(),
        );
      },
    );
  }
}
