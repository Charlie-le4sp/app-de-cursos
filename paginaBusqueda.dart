// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: camel_case_types, file_names, duplicate_ignore

import 'package:animate_do/animate_do.dart';
import 'package:app_firebase_v2/paginaCursosContenido/paginaCursoContenido1.dart';
import 'package:app_firebase_v2/paginasCursos/paginaCurso1.dart';
import 'package:app_firebase_v2/paginasCursos/paginaCurso2.dart';
import 'package:app_firebase_v2/util/themeModeNotifier.dart';
import 'package:app_firebase_v2/util/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AnimatedTap.dart';

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
        child: const paginaBusqueda(),
      ),
    );
  });
}

class paginaBusqueda extends StatefulWidget {
  const paginaBusqueda({super.key});

  @override
  State<paginaBusqueda> createState() => _paginaBusquedaState();
}

class _paginaBusquedaState extends State<paginaBusqueda> {
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
  //control del texto
  TextEditingController searchController = TextEditingController();

  //lista de productos ,es la lista de objetos que van apareciendo conforme se va escribiendo

  List<Producto> productos = [
    Producto(
        titulo: 'Curso HTML5 conceptos basicos',
        nombre: 'Desarrollo web',
        rutaImagen: 'assets/images/imgs_cursos/fondo_curso_1.jpg'),
    Producto(
        titulo: 'Curso diseño UI conceptos basicos',
        nombre: 'diseño UI',
        rutaImagen: 'assets/images/imgs_cursos/fondo_curso_2.jpg'),
    Producto(
        titulo: 'curso diseño desde cero',
        nombre: 'diseño',
        rutaImagen: 'assets/images/imgs_cursos/fondo_curso_2.jpg'),
  ];
  //esta es la bander que permite ocultar el container de "mas buscados" o recomendados
  bool _isContainerVisible = true;
  //esto es la parte que permite que se pueda agregar el texto desde el container que se puede ocultar
  // ignore: unused_element
  void _addWord(String word) {
    setState(() {
      final currentValue = searchController.value;
      final selection = currentValue.selection;
      final newText =
          currentValue.text.replaceRange(selection.start, selection.end, word);
      searchController.value = currentValue.copyWith(
          text: newText,
          selection:
              TextSelection.collapsed(offset: selection.start + word.length));
      _words.add(word);
    });
  }

  bool mostrarMensaje = false;

  bool _showSuffixIcon = true;

  final List<String> _words = [];
//esta es la lista con la que se va llenado
  List<Producto> filteredProductos = [];
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            collapsedHeight: 85,
            toolbarHeight: 65,
            pinned: true,
            floating: true,
            elevation: 0,
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? const Color.fromARGB(255, 255, 255, 255)
                : const Color.fromARGB(255, 0, 5, 9),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 68,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color.fromARGB(255, 99, 0, 237)
                            : const Color.fromARGB(255, 99, 0, 237),
                      ),
                      child: Center(
                        child: TextFormField(
                          autofocus: true,
                          decoration: InputDecoration(
                            suffixIcon: _showSuffixIcon
                                ? null
                                : Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: FadeIn(
                                      child: InkWell(
                                        onTap: () {
                                          searchController.clear();
                                        },
                                        child: SizedBox(
                                          height: 55,
                                          width: 55,
                                          child: Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.xmark,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            hintText: "Buscar...",
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : Colors.white,
                              fontSize: 19,
                            ),
                            errorStyle: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                color: Color.fromARGB(255, 255, 53, 39),
                                fontWeight: FontWeight.w500),
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 19),
                            counterStyle: const TextStyle(fontSize: 13),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: "Poppins",
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Introduce un nombre';
                            }
                            return null;
                          },
                          controller: searchController,
                          onChanged: (value) {
                            filterData(value);

                            _isContainerVisible = value.isEmpty;
                            _showSuffixIcon = value.isEmpty;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
        ];
      },
      body: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Visibility(
                  visible: _isContainerVisible,
                  child: FadeIn(
                    child: Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 40,
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 8),
                                    child: Text(
                                      "Recomendado",
                                      style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black38
                                              : Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all<double>(
                                                0),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red.withOpacity(0.0)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            // Change your radius here
                                            side: BorderSide(
                                                width: 1.5,
                                                style: BorderStyle.solid,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.black12
                                                    : Colors.white24),

                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        // Agregar la palabra "manzana" al campo de búsqueda
                                        searchController.text =
                                            'desarrollo web';
                                        searchController.selection =
                                            TextSelection.fromPosition(
                                          TextPosition(
                                              offset:
                                                  searchController.text.length),
                                        );
                                        // Llamar a la función de filtrado con el texto actual del campo de búsqueda
                                        filterData(searchController.text);
                                        if (_isContainerVisible) {
                                          _isContainerVisible = false;
                                        } else {
                                          _isContainerVisible = true;
                                        }
                                      },
                                      child: Text(
                                        "desarrollo web",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 14),
                                      )),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all<double>(
                                                0),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red.withOpacity(0.0)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            // Change your radius here
                                            side: BorderSide(
                                                width: 1.5,
                                                style: BorderStyle.solid,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.black12
                                                    : Colors.white24),

                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        // Agregar la palabra "manzana" al campo de búsqueda
                                        searchController.text = 'diseño';
                                        searchController.selection =
                                            TextSelection.fromPosition(
                                          TextPosition(
                                              offset:
                                                  searchController.text.length),
                                        );
                                        // Llamar a la función de filtrado con el texto actual del campo de búsqueda
                                        filterData(searchController.text);
                                        if (_isContainerVisible) {
                                          _isContainerVisible = false;
                                        } else {
                                          _isContainerVisible = true;
                                        }
                                      },
                                      child: Text(
                                        "diseño",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 14),
                                      )),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all<double>(
                                                0),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red.withOpacity(0.0)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            // Change your radius here
                                            side: BorderSide(
                                                width: 1.5,
                                                style: BorderStyle.solid,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.black12
                                                    : Colors.white24),

                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        // Agregar la palabra "manzana" al campo de búsqueda
                                        searchController.text =
                                            'programacion web';
                                        searchController.selection =
                                            TextSelection.fromPosition(
                                          TextPosition(
                                              offset:
                                                  searchController.text.length),
                                        );
                                        // Llamar a la función de filtrado con el texto actual del campo de búsqueda
                                        filterData(searchController.text);
                                        if (_isContainerVisible) {
                                          _isContainerVisible = false;
                                        } else {
                                          _isContainerVisible = true;
                                        }
                                      },
                                      child: Text(
                                        "diseño",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 14),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 5, bottom: 5, right: 8),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all<double>(
                                                  0),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.red.withOpacity(0.0)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              // Change your radius here
                                              side: BorderSide(
                                                  width: 1.5,
                                                  style: BorderStyle.solid,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Colors.black12
                                                      : Colors.white24),

                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          // Agregar la palabra "manzana" al campo de búsqueda
                                          searchController.text =
                                              'programacion web';
                                          searchController.selection =
                                              TextSelection.fromPosition(
                                            TextPosition(
                                                offset: searchController
                                                    .text.length),
                                          );
                                          // Llamar a la función de filtrado con el texto actual del campo de búsqueda
                                          filterData(searchController.text);
                                          if (_isContainerVisible) {
                                            _isContainerVisible = false;
                                          } else {
                                            _isContainerVisible = true;
                                          }
                                        },
                                        child: Text(
                                          "programacion web",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontSize: 14),
                                        )),
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all<double>(
                                                0),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red.withOpacity(0.0)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            // Change your radius here
                                            side: BorderSide(
                                                width: 1.5,
                                                style: BorderStyle.solid,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.black12
                                                    : Colors.white24),

                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        // Agregar la palabra "manzana" al campo de búsqueda
                                        searchController.text =
                                            'programacion web';
                                        searchController.selection =
                                            TextSelection.fromPosition(
                                          TextPosition(
                                              offset:
                                                  searchController.text.length),
                                        );
                                        // Llamar a la función de filtrado con el texto actual del campo de búsqueda
                                        filterData(searchController.text);
                                        if (_isContainerVisible) {
                                          _isContainerVisible = false;
                                        } else {
                                          _isContainerVisible = true;
                                        }
                                      },
                                      child: Text(
                                        "hola mundo",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 14),
                                      )),
                                  //aqui
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 40,
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 8),
                                    child: Text(
                                      "Categorias",
                                      style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black38
                                              : Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                                height: 200,
                                color: Colors.blue,
                                width: double.infinity),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 40,
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 8),
                                    child: Text(
                                      "Todos",
                                      style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black45
                                              : Colors.white,
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                if (mostrarMensaje)
                  Center(
                      child: Column(
                    children: [
                      FadeIn(
                        child: Container(
                          height: 180,
                          width: 180,
                          decoration: const BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/imgs_cursos/buscando_2.png"))),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'No se encontraron resultados',
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                            fontSize: 18),
                      ),
                    ],
                  )),
                Container(
                  height: 500,
                  child: Scrollbar(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredProductos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            // Navegar a una página diferente dependiendo del producto seleccionado
                            if (index == 0) {
                              Navigator.of(context, rootNavigator: false).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 600),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const paginaCurso1(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
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
                            }
                            if (index == 1) {
                              Navigator.of(context, rootNavigator: false).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 600),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const paginaCurso2(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
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
                            }
                            if (index == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const paginaCursoContenido1()));
                            }

                            // Agregar más condiciones para más elementos de la lista según sea necesario
                          },
                          child: FadeInLeft(
                            duration: const Duration(milliseconds: 250),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: 90,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              filteredProductos[index]
                                                  .rutaImagen),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            255, 255, 191, 187),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Stack(
                                        children: const [],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 95,
                                  width:
                                      MediaQuery.of(context).size.width * 0.57,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.57,
                                          child: Text(
                                            filteredProductos[index].titulo,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.57,
                                          child: Text(
                                            filteredProductos[index].nombre,
                                            style: const TextStyle(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Hero(
          tag: "broo",
          child: AnimatedTap(
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(31, 0, 0, 0),
                        blurRadius: 10,
                        offset: Offset(0, 0),
                        spreadRadius: 3)
                  ],
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 124, 57, 240),
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.angleLeft,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop(context);
              }),
        ),
      ),
    );
  }

  //esto es el funcionamiento de la barra de busqueda para quu funcione bien
  void filterData(String query) {
    setState(() {
      filteredProductos = productos
          .where((element) =>
              element.nombre.toLowerCase().contains(query.toLowerCase()) ||
              element.titulo.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (filteredProductos.isEmpty && query.isNotEmpty) {
        mostrarMensaje = true;
      } else {
        mostrarMensaje = false;
      }
    });
  }
}

//esta parte del codigo  es la clase que define los parametros de la lista productos
class Producto {
  final String nombre;
  final String rutaImagen;
  final String titulo;

  Producto({
    required this.nombre,
    required this.rutaImagen,
    required this.titulo,
  });
}
