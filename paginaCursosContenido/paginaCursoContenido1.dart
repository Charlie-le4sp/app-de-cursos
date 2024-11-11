// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: paginaCursoContenido1(),
    );
  }
}

class paginaCursoContenido1 extends StatefulWidget {
  const paginaCursoContenido1({super.key});

  @override
  _paginaCursoContenido1State createState() => _paginaCursoContenido1State();
}

class _paginaCursoContenido1State extends State<paginaCursoContenido1> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                    if (_currentPage == 2) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Has llegado a la última página"),
                            content: const Text("¡Felicidades!"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Cerrar"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
                },
                children: [
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                  Container(
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
              child: LinearProgressIndicator(
                value: _currentPage / 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
