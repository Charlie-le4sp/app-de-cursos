import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageB extends StatefulWidget {
  const PageB({super.key});

  @override
  _PageBState createState() => _PageBState();
}

class _PageBState extends State<PageB> {
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  void _incrementProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      progress += 0.1;
      if (progress > 1.0) {
        progress = 1.0; // Limitar el valor máximo a 1.0
      }
      prefs.setDouble('progress', progress);
    });
  }

  void _decrementProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      progress -= 0.1;
      prefs.setDouble('progress', progress);
    });
  }

  void _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      progress = prefs.getDouble('progress') ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _incrementProgress,
      child: const Text('Increment Progress'),
    );
  }
}
