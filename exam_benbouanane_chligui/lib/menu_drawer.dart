import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage("assets/images/menu.jpg"))),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
              ),
            ),
          ),
          ListTile(
            title: Text('Recherche de photos'),
            onTap: () {
              Navigator.pushNamed(context, '/photo-search');
            },
          ),
          ListTile(
            title: Text('API Data'),
            onTap: () {
              Navigator.pushNamed(context, '/api-data');
            },
          ),
          ListTile(
            title: Text("Calculer jour d'une date"),
            onTap: () {
              Navigator.pushNamed(context, '/day-of-date');
            },
          ),
        ],
      ),
    );
  }
}
