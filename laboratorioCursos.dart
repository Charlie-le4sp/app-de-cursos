import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class laboratorioCursos extends StatefulWidget {
  @override
  _laboratorioCursosState createState() => _laboratorioCursosState();
}

class _laboratorioCursosState extends State<laboratorioCursos> {
  late SharedPreferences _prefsStatus;
  bool _isVisible1 = false;
  bool _isVisible2 = false;
  bool _isVisible3 = false;

  @override
  void initState() {
    super.initState();
    _loadVisibility();
  }

  _loadVisibility() async {
    _prefsStatus = await SharedPreferences.getInstance();
    setState(() {
      _isVisible1 = _prefsStatus.getBool('isVisible1') ?? false;
      _isVisible2 = _prefsStatus.getBool('isVisible2') ?? false;
      _isVisible3 = _prefsStatus.getBool('isVisible3') ?? false;
    });
  }

  _saveVisibility() async {
    await _prefsStatus.setBool('isVisible1', _isVisible1);
    await _prefsStatus.setBool('isVisible2', _isVisible2);
    await _prefsStatus.setBool('isVisible3', _isVisible3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contenedores'),
      ),
      body: ListView(
        children: <Widget>[
          Visibility(
            visible: _isVisible1,
            child: Container(
              color: Colors.red,
              height: 100,
            ),
          ),
          Visibility(
            visible: _isVisible2,
            child: Container(
              color: Colors.blue,
              height: 100,
            ),
          ),
          Visibility(
            visible: _isVisible3,
            child: Container(
              color: Colors.green,
              height: 100,
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "1",
            onPressed: () {
              setState(() {
                _isVisible1 = !_isVisible1;
                _saveVisibility();
              });
            },
            child: Icon(_isVisible1 ? Icons.visibility_off : Icons.visibility),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "2",
            onPressed: () {
              setState(() {
                _isVisible2 = !_isVisible2;
                _saveVisibility();
              });
            },
            child: Icon(_isVisible2 ? Icons.visibility_off : Icons.visibility),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "3",
            onPressed: () {
              setState(() {
                _isVisible3 = !_isVisible3;
                _saveVisibility();
              });
            },
            child: Icon(_isVisible3 ? Icons.visibility_off : Icons.visibility),
          ),
        ],
      ),
    );
  }
}
