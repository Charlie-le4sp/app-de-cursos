import 'dart:async';
import 'dart:ui';

import 'package:app_firebase_v2/curso%20HTML/CURSO%20HTML%20DESDE%20CERO/lecciones_CURSOHTMLDESDECERO.dart';
import 'package:app_firebase_v2/paginasCursos/paginaCurso1.dart';
import 'package:app_firebase_v2/util/themeModeNotifier.dart';
import 'package:app_firebase_v2/util/themes.dart';
import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        child: const paginaPuente(),
      ),
    );
  });
}

class paginaPuente extends StatefulWidget {
  const paginaPuente({Key? key}) : super(key: key);

  @override
  _paginaPuenteState createState() => _paginaPuenteState();
}

class _paginaPuenteState extends State<paginaPuente> {
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Simular tiempo de carga
    _timer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        // Navegar a la siguiente página después de un breve retraso
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const lecciones_CURSOHTMLDESDECERO(),
                transitionDuration: const Duration(
                    milliseconds:
                        500), // Duración de la transición (ejemplo: 500 milisegundos)
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
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
        });
        
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancelar el temporizador al salir de la página
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const lecciones_CURSOHTMLDESDECERO(),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                    height: 50,
                    width: 50,
                    child: CurvedCircularProgressIndicator(
                      strokeWidth: 7,
                    )),
                SizedBox(
                  height: 30,
                ),
                Text("Cargando...")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
