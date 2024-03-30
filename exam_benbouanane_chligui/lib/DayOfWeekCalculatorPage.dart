import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class DayOfWeekCalculatorPage extends StatefulWidget {
  @override
  _DayOfWeekCalculatorPageState createState() =>
      _DayOfWeekCalculatorPageState();
}

class _DayOfWeekCalculatorPageState extends State<DayOfWeekCalculatorPage> {
  int _day = 1;
  int _month = 1;
  int _year = DateTime.now().year;
  String _result = '';

  int calculateDayOfWeek(int day, int month, int year) {
    int a = year - 1900;
    int j;

    if (month < 3) {
      // Adjust for January and February in leap years
      int leapAdjust =
          (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ? -1 : 0;
      j = (day + a + (a ~/ 4) + calculateF(month) + leapAdjust).remainder(7);
    } else {
      j = (day + a + (a ~/ 4) + calculateF(month)).remainder(7);
    }

    // Adjust for zero-based indexing
    if (j < 0) {
      j += 7;
    }

    return j + 1; // Adjust for one-based indexing
  }

  int calculateF(int month) {
    List<int> fValues = [0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5];
    return fValues[month - 1];
  }

  Map<int, String> dayNames = {
    1: 'Dimanche',
    2: 'Lundi',
    3: 'Mardi',
    4: 'Mercredi',
    5: 'Jeudi',
    6: 'Vendredi',
    7: 'Samedi',
  };

  void calculateDay() {
    int dayOfWeek = calculateDayOfWeek(_day, _month, _year);
    _result = 'Le $_day/$_month/$_year est un ${dayNames[dayOfWeek]}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Calculateur de jour'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberPicker(
                  value: _day,
                  minValue: 1,
                  maxValue: 31,
                  onChanged: (value) => setState(() => _day = value),
                ),
                NumberPicker(
                  value: _month,
                  minValue: 1,
                  maxValue: 12,
                  onChanged: (value) => setState(() => _month = value),
                ),
                NumberPicker(
                  value: _year,
                  minValue: 1900,
                  maxValue: DateTime.now().year + 10,
                  onChanged: (value) => setState(() => _year = value),
                ),
              ],
            ),
            SizedBox(height: 19),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: calculateDay,
              child: Text(
                'Calculer',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                _result,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
