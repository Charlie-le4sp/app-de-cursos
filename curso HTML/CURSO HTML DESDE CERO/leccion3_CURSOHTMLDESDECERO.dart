import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class leccion3_CURSOHTMLDESDECERO extends StatefulWidget {
  final Function(double, double) moveContainerCallback;

  leccion3_CURSOHTMLDESDECERO(this.moveContainerCallback);
  @override
  State<leccion3_CURSOHTMLDESDECERO> createState() =>
      _leccion3_CURSOHTMLDESDECEROState();
}

class _leccion3_CURSOHTMLDESDECEROState
    extends State<leccion3_CURSOHTMLDESDECERO> {
  //VARIABLES
  double progress = 0.0;
  double containerPositionX = 170;
  double containerPositionY = 210;
  bool buttonVisibleLeccion3 =
      true; //controla la visibilidad del boton por "COMPLETADO"

  //CARGAR POSICION DE LA IMAGEN

  void loadContainerPosition() async {
    SharedPreferences prefsLeccion3 = await SharedPreferences.getInstance();
    double? savedPositionX = prefsLeccion3.getDouble('containerPositionX');
    double? savedPositionY = prefsLeccion3.getDouble('containerPositionY');
    setState(() {
      containerPositionX = savedPositionX ?? 200;
      containerPositionY = savedPositionY ?? 240;
    });
  }

  void saveContainerPosition() async {
    SharedPreferences prefsLeccion3 = await SharedPreferences.getInstance();
    await prefsLeccion3.setDouble('containerPositionX', containerPositionX);
    await prefsLeccion3.setDouble('containerPositionY', containerPositionY);
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
    _checkButtonVisibility3();
    loadContainerPosition();
  }

  //INCREMENTAR CIRCULAR PROGRESS

  void _incrementProgress() async {
    SharedPreferences prefsLeccion3 = await SharedPreferences.getInstance();
    setState(() {
      progress += 0.1;
      prefsLeccion3.setDouble('progress', progress);
    });
  }

  void _loadProgress() async {
    SharedPreferences prefsLeccion3 = await SharedPreferences.getInstance();
    setState(() {
      progress = prefsLeccion3.getDouble('progress') ?? 0.0;
    });
  }

  //VISIBILIDAD DEL BOTON

  Future<void> _bottonVisibility3() async {
    SharedPreferences prefsLeccion3 = await SharedPreferences.getInstance();
    await prefsLeccion3.setBool('buttonVisibleLeccion3', false);
    setState(() {
      buttonVisibleLeccion3 = false;
    });
  }

  Future<void> _checkButtonVisibility3() async {
    SharedPreferences prefsLeccion3 = await SharedPreferences.getInstance();
    bool isVisibleLeccion3 =
        prefsLeccion3.getBool('buttonVisibleLeccion3') ?? true;

    setState(() {
      buttonVisibleLeccion3 = isVisibleLeccion3;
    });
  }

  //   INCREMENTADOR DE NUMERO PARA LAS LECCIONES COMPLETADAS
  void _incrementCounter(BuildContext context) async {
    SharedPreferences prefsLeccion3 = await SharedPreferences.getInstance();
    int counter = prefsLeccion3.getInt('counter') ?? 0;
    counter++;
    prefsLeccion3.setInt('counter', counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('leccion 3'),
        ),
        body: buttonVisibleLeccion3
            ? Center(
                child: ElevatedButton(
                  onPressed: () {
                    _incrementProgress();
                    _incrementCounter(context);
                    _bottonVisibility3();
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
