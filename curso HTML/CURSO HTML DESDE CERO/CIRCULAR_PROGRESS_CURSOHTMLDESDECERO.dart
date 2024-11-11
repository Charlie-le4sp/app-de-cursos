// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CIRCULAR_PROGRESS_CURSOHTMLDESDECERO extends StatefulWidget {
  const CIRCULAR_PROGRESS_CURSOHTMLDESDECERO({super.key});

  @override
  _CIRCULAR_PROGRESS_CURSOHTMLDESDECEROState createState() =>
      _CIRCULAR_PROGRESS_CURSOHTMLDESDECEROState();
}

class _CIRCULAR_PROGRESS_CURSOHTMLDESDECEROState
    extends State<CIRCULAR_PROGRESS_CURSOHTMLDESDECERO> {
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  void _setProgress(double value) {
    setState(() {
      progress = value;
      _saveProgress();
    });
  }

  void _saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('progress', progress);
  }

  void _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      progress = prefs.getDouble('progress') ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircularPercentIndicator(
            curve: Curves.easeInOutCubicEmphasized,
            percent: progress,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.blue,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            animation: true,
            animationDuration: 2500,
            radius: 40,
            lineWidth: 15,
            center: Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.white,
                fontFamily: "Poppins",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
