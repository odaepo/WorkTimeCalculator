import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calcolo Ore Lavorative 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DateTimePickerPage(),
    );
  }
}

class DateTimePickerPage extends StatefulWidget {
  DateTimePickerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DateTimePickerPageState createState() => _DateTimePickerPageState();
}

class _DateTimePickerPageState extends State<DateTimePickerPage> {
  TimeOfDay entrata;

  @override
  void initState() {
    super.initState();
    entrata = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcolo ore lavorative 2'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text("Ora di entrata: ${entrata.hour}: ${entrata.minute}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: _pickTime,
            ),
          ],
        ),
      ),
    );
  }

  _pickTime() async {
    TimeOfDay te = await showTimePicker(context: context, initialTime: entrata);
    if (te != null) {
      setState(() {
        entrata = te;
      });
    }
  }
}
