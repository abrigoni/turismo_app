import 'package:flutter/material.dart';
import 'package:app/pages/alojamientos_page.dart';
import 'package:app/pages/gastronomicos_page.dart';
import 'package:app/pages/favoritos_page.dart';


class HomePage extends StatefulWidget {

  static const String ROUTENAME = "home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final iconList = List.unmodifiable([ 
      {"icon": Icons.hotel,       "title": "Alojamientos"}, 
      {"icon": Icons.favorite,    "title": "Favoritos"}, 
      {"icon": Icons.restaurant,  "title": "Gastronomicos"}, 
  ]);

  final pages = List<Widget>.unmodifiable([
    AlojamientosPage(),
    FavoritosPage(),
    GastronomicosPage(),
  ]);

  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[navIndex], 
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }


  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: navIndex,
      onTap: (index) {setState(() {
        navIndex = index;
      });},
      items: [ for (var icon in iconList) BottomNavigationBarItem(icon: Icon(icon["icon"]), title: Text(icon["title"])) ]
    );
  }
}
