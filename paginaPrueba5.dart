import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(paginaPrueba5());
}

class paginaPrueba5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reorderable List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> widgetList = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? storedList = prefs.getStringList('widgetList');
    if (storedList != null) {
      setState(() {
        widgetList = storedList;
      });
    }
  }

  void saveWidgetList() {
    prefs.setStringList('widgetList', widgetList);
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final String item = widgetList.removeAt(oldIndex);
      widgetList.insert(newIndex, item);
      saveWidgetList();
    });
  }

  Widget buildItem(BuildContext context, int index) {
    final String item = widgetList[index];
    return ListTile(
      key: Key(item),
      title: Text(item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reorderable List'),
      ),
      body: ReorderableListView(
        onReorder: _onReorder,
        children: widgetList.asMap().entries.map((entry) {
          final index = entry.key;
          return buildItem(context, index);
        }).toList(),
      ),
    );
  }
}
