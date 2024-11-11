import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class leccion4_CURSOHTMLDESDECERO extends StatefulWidget {
  final Function(double, double) moveContainerCallback;

  leccion4_CURSOHTMLDESDECERO(this.moveContainerCallback);
  @override
  State<leccion4_CURSOHTMLDESDECERO> createState() =>
      _leccion4_CURSOHTMLDESDECEROState();
}

class _leccion4_CURSOHTMLDESDECEROState
    extends State<leccion4_CURSOHTMLDESDECERO> {
  //VARIABLES
  double progress = 0.0;
  double containerPositionX = 170;
  double containerPositionY = 210;
  bool buttonVisibleLeccion4 =
      true; //controla la visibilidad del boton por "COMPLETADO"

  //CARGAR POSICION DE LA IMAGEN

  void loadContainerPosition() async {
    SharedPreferences prefsLeccion4 = await SharedPreferences.getInstance();
    double? savedPositionX = prefsLeccion4.getDouble('containerPositionX');
    double? savedPositionY = prefsLeccion4.getDouble('containerPositionY');
    setState(() {
      containerPositionX = savedPositionX ?? 200;
      containerPositionY = savedPositionY ?? 240;
    });
  }

  void saveContainerPosition() async {
    SharedPreferences prefsLeccion4 = await SharedPreferences.getInstance();
    await prefsLeccion4.setDouble('containerPositionX', containerPositionX);
    await prefsLeccion4.setDouble('containerPositionY', containerPositionY);
  }

  void moveContainerTo(double positionX, double positionY) {
    setState(() {
      containerPositionX = positionX;
      containerPositionY = positionY;
    });
    saveContainerPosition();
  }

  @override
  void initState() {
    super.initState();
    _loadProgress();
    _checkButtonVisibility4();
    loadContainerPosition();
  }

  //INCREMENTAR CIRCULAR PROGRESS

  void _incrementProgress() async {
    SharedPreferences prefsLeccion4 = await SharedPreferences.getInstance();
    setState(() {
      progress += 0.1;
      prefsLeccion4.setDouble('progress', progress);
    });
  }

  void _loadProgress() async {
    SharedPreferences prefsLeccion4 = await SharedPreferences.getInstance();
    setState(() {
      progress = prefsLeccion4.getDouble('progress') ?? 0.0;
    });
  }

  //VISIBILIDAD DEL BOTON

  Future<void> _bottonVisibility4() async {
    SharedPreferences prefsLeccion4 = await SharedPreferences.getInstance();
    await prefsLeccion4.setBool('buttonVisibleLeccion4', false);
    setState(() {
      buttonVisibleLeccion4 = false;
    });
  }

  Future<void> _checkButtonVisibility4() async {
    SharedPreferences prefsLeccion4 = await SharedPreferences.getInstance();
    bool isVisibleLeccion3 =
        prefsLeccion4.getBool('buttonVisibleLeccion4') ?? true;

    setState(() {
      buttonVisibleLeccion4 = isVisibleLeccion3;
    });
  }

  //   INCREMENTADOR DE NUMERO PARA LAS LECCIONES COMPLETADAS
  void _incrementCounter(BuildContext context) async {
    SharedPreferences prefsLeccion4 = await SharedPreferences.getInstance();
    int counter = prefsLeccion4.getInt('counter') ?? 0;
    counter++;
    prefsLeccion4.setInt('counter', counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('leccion 4'),
        ),
        body: buttonVisibleLeccion4
            ? Center(
                child: ElevatedButton(
                  onPressed: () {
                    _incrementProgress();
                    _incrementCounter(context);
                    _bottonVisibility4();
                    //x   //y
                    widget.moveContainerCallback(80, 360);
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> paginaEstudio() ));
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(context, false);
                    });
                    final snackBar = SnackBar(
                      content: Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.transparent,
                          child: Center(
                            child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                child: Center(
                                    child: CupertinoActivityIndicator())),
                          )),
                      backgroundColor: Color.fromARGB(0, 255, 255, 255),
                      duration: const Duration(seconds: 3),
                      elevation: 0,
                      padding: const EdgeInsets.only(bottom: 8),
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text('Activar Boton'),
                ),
              )
            : Text("Leccion Completa"));
  }
}

// PARA CREAR MAS LECCIONES DEBEMOS COPIAR LA PAGINA DE LA LECCION Y RENONBRAR
//Y CREAR LAS SIGUIENTES COSAS

// - buttonVisibleLeccion(X)  ESTO DEFINE LA VISIBILIDAD DEL BOTON PARA QUE NO SE PULSE DE NUEVO

// - prefsLeccion(X) ESTA VARIABLE ES LA QUE SE ALMACENA PARA PARA LA VISIBILIDAD DEL BOTON  Y TODAS SUS VARIANTES EN LAS FUNCIONES

// - RENOMBRAR _checkButtonVisibility(X)  Y _bottonVisibility4(X) SEGUN CORRESPONDA

// - AÑADIR AL INIT STATE _checkButtonVisibility(X) SEGUN CORRESPONDA

//ADEMAS DE ESOS PASOS EN LAS PAGINA DE LAS LECCIONES DEBEMOS
// RENOMBRAR Y CREAR OTRAS COSAS EN LA PAGINA PRINCIPAL DE LAS LECCIONES
//COMO SON :

// - CREAR botonActivadoLeccion(X) para la leccion creadad

// - CREAR UN NUEVO _loadButtonStatus(X) Y UN NUEVO _updateButtonStatus(X) SEGUN CORRESPONDA
//   ESTO ES EL DESBLOQUEDOR DE LAS LECCIONES
// Y EN SECUENCIA CAMBIAR SUS PROPIEDADES COMO LO SON :
// prefsLeccionesCURSOHTMLDESDECEROLecciones(X), botonActivadoLeccion(X) ,(bool activado(X))

//  CREAR EN EL INIS STATE UN _loadButtonStatus(X);
