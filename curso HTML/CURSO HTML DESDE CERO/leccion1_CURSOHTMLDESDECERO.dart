import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class leccion1_CURSOHTMLDESDECERO extends StatefulWidget {
  final Function(double, double) moveContainerCallback;

  leccion1_CURSOHTMLDESDECERO(this.moveContainerCallback);
  @override
  State<leccion1_CURSOHTMLDESDECERO> createState() =>
      _leccion1_CURSOHTMLDESDECEROState();
}

class _leccion1_CURSOHTMLDESDECEROState
    extends State<leccion1_CURSOHTMLDESDECERO> {
  //VARIABLES
  double progress = 0.0;
  double containerPositionX = 170;
  double containerPositionY = 210;
  bool buttonVisibleLeccion1 =
      true; //controla la visibilidad del boton por "COMPLETADO"

  //CARGAR POSICION DE LA IMAGEN

  void loadContainerPosition() async {
    SharedPreferences prefsLeccion1 = await SharedPreferences.getInstance();
    double? savedPositionX = prefsLeccion1.getDouble('containerPositionX');
    double? savedPositionY = prefsLeccion1.getDouble('containerPositionY');
    setState(() {
      containerPositionX = savedPositionX ?? 200;
      containerPositionY = savedPositionY ?? 240;
    });
  }

  void saveContainerPosition() async {
    SharedPreferences prefsLeccion1 = await SharedPreferences.getInstance();
    await prefsLeccion1.setDouble('containerPositionX', containerPositionX);
    await prefsLeccion1.setDouble('containerPositionY', containerPositionY);
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
    _checkButtonVisibility();
    loadContainerPosition();
  }

  //INCREMENTAR CIRCULAR PROGRESS

  void _incrementProgress() async {
    SharedPreferences prefsLeccion1 = await SharedPreferences.getInstance();
    setState(() {
      progress += 0.1;
      prefsLeccion1.setDouble('progress', progress);
    });
  }

  void _loadProgress() async {
    SharedPreferences prefsLeccion1 = await SharedPreferences.getInstance();
    setState(() {
      progress = prefsLeccion1.getDouble('progress') ?? 0.0;
    });
  }

  //VISIBILIDAD DEL BOTON

  Future<void> _bottonVisibility() async {
    SharedPreferences prefsLeccion1 = await SharedPreferences.getInstance();
    await prefsLeccion1.setBool('buttonVisibleLeccion1', false);
    setState(() {
      buttonVisibleLeccion1 = false;
    });
  }

  Future<void> _checkButtonVisibility() async {
    SharedPreferences prefsLeccion1 = await SharedPreferences.getInstance();
    bool isVisibleLeccion1 =
        prefsLeccion1.getBool('buttonVisibleLeccion1') ?? true;

    setState(() {
      buttonVisibleLeccion1 = isVisibleLeccion1;
    });
  }

  //   INCREMENTADOR DE NUMERO PARA LAS LECCIONES COMPLETADAS
  void _incrementCounter(BuildContext context) async {
    SharedPreferences prefsLeccion1 = await SharedPreferences.getInstance();
    int counter = prefsLeccion1.getInt('counter') ?? 0;
    counter++;
    prefsLeccion1.setInt('counter', counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('leccion 1'),
        ),
        body: buttonVisibleLeccion1
            ? Center(
                child: ElevatedButton(
                  onPressed: () {
                    _incrementProgress();
                    _incrementCounter(context);

                    // _bottonVisibility();
                    //x   //y
                    widget.moveContainerCallback(80, 360);
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> paginaEstudio() ));
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(context, false);
                    });
                    final snackBar = SnackBar(
                      content: Container(
                          height: 65,
                          width: double.infinity,
                          color: Colors.transparent,
                          child: Center(
                            child: Container(
                                height: 65,
                                width: MediaQuery.of(context).size.width * 0.95,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(255, 8, 220, 15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        'Guardando',
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )),
                          )),
                      backgroundColor: Colors.transparent,
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
