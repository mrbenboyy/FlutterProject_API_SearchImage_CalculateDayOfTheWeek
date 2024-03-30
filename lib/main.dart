import 'package:examen_benbouanane_chligui/DayOfWeekCalculatorPage.dart';
import 'package:flutter/material.dart';
import 'menu_drawer.dart';
import 'photo_search_page.dart';
import 'api_data_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/photo-search': (context) => PhotoSearchPage(),
        '/api-data': (context) => ApiDataPage(),
        '/day-of-date': (context) => DayOfWeekCalculatorPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Accueil'),
      ),
      drawer: MenuDrawer(),
      body: Center(
        // child: Text('Page d\'accueil'),
        child: Text(
          'Bonjour et bienvenue à notre application \ncette application est réalisé par\nAbdelhakim Benbouanane et\nOuthmane Chligui',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
