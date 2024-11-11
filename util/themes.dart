import 'package:flutter/material.dart';

class Themes {
  // ignore: constant_identifier_names
  static const double APPBAR_ELEVATION = 0;

  //MODO CLARO____________________________

  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: const Color.fromARGB(255, 144, 79, 255),
      labelTextStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontSize: 12.5, fontFamily: "Poppins")),
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
    ),
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(background: Colors.white)
        .copyWith(secondary: const Color.fromARGB(255, 0, 22, 43)),
  );

  //MODO OSCURO____________________________

  static ThemeData darkTheme = ThemeData(
    //TEMA DEL NAVIGATION BAR
    navigationBarTheme: NavigationBarThemeData(
      surfaceTintColor: Colors.transparent,
      indicatorColor: const Color.fromARGB(255, 124, 57, 240),
      backgroundColor: const Color.fromARGB(255, 0, 13, 24),
      labelTextStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontSize: 12.5, fontFamily: "Poppins")),
    ),
    brightness: Brightness.dark,
    //TEMA DE LOS ICONOS

    //EL COMPORTAMIENTO DE LOS ELEMENTOS EN LA PANTALLA
    visualDensity: VisualDensity.adaptivePlatformDensity,
    //COLOR DE FONDO DE TODA LA APLICACION
    scaffoldBackgroundColor: const Color.fromARGB(255, 0, 5, 9),
    colorScheme:
        const ColorScheme.dark(background: Color.fromARGB(255, 0, 0, 0))
            .copyWith(secondary: Colors.cyan),
    //TEMA DE EL APPBAR
  );
}
