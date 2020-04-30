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
  TimeOfDay inizioPausaPranzo;
  TimeOfDay finePausaPranzo;
  TimeOfDay uscita;
  String totale;

  @override
  void initState() {
    super.initState();
    entrata = TimeOfDay.now();
    inizioPausaPranzo = TimeOfDay.now();
    finePausaPranzo = TimeOfDay.now();
    uscita = TimeOfDay.now();
    totale = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcolo ore lavorative'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text("Ora di entrata: ${entrata.hour}: ${entrata.minute}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: _pickTimeEntrata,
            ),
            ListTile(
              title: Text(
                  "Ora di inizio pausa pranzo: ${inizioPausaPranzo.hour}: ${inizioPausaPranzo.minute}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: _pickTimeInizioPausaPranzo,
            ),
            ListTile(
              title: Text(
                  "Ora di fine pausa pranzo: ${finePausaPranzo.hour}: ${finePausaPranzo.minute}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: _pickTimeFinePausaPranzo,
            ),
            ListTile(
              title: Text("Ora di uscita: ${uscita.hour}: ${uscita.minute}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: _pickTimeUscita,
            ),
            ListTile(
              title: Text("Tempo: ${totale}"),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: _pickTimeUscita,
            ),
          ],
        ),
      ),
    );
  }

  _pickTimeEntrata() async {
    TimeOfDay te = await showTimePicker(context: context, initialTime: entrata);
    if (te != null) {
      setState(() {
        entrata = te;
      });
    }
  }

  _pickTimeInizioPausaPranzo() async {
    TimeOfDay te = await showTimePicker(context: context, initialTime: entrata);
    if (te != null) {
      setState(() {
        inizioPausaPranzo = te;
      });
    }
  }

  _pickTimeFinePausaPranzo() async {
    TimeOfDay te = await showTimePicker(context: context, initialTime: entrata);
    if (te != null) {
      setState(() {
        finePausaPranzo = te;
      });
    }
  }

  _pickTimeUscita() async {
    TimeOfDay te = await showTimePicker(context: context, initialTime: entrata);
    if (te != null) {
      setState(() {
        uscita = te;
        int totmin = calTotalMinute(entrata, inizioPausaPranzo) +
            calTotalMinute(finePausaPranzo, uscita);
        totale = minToString(totmin);
      });
    }
  }

  ///Calculates the amount of time from a [startTime] and an [endTime].
  int calTotalMinute(TimeOfDay startTime, TimeOfDay endTime) {
    double totalTime = (endTime.hour + (endTime.minute / 60)) -
        (startTime.hour + (startTime.minute / 60));
    int hours = totalTime.floor();
    int minuts = ((totalTime - totalTime.floorToDouble()) * 60).round();
    return hours * 60 + minuts;
  }

  ///Calculates the amount of time from a [startTime] and an [endTime].
  String minToString(int min) {
    int ore = (min / 60).round();
    int minuti = min - ore * 60;
    return '${ore}:${minuti}';
  }
}
