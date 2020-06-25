import 'package:flutter/material.dart';
import 'package:app/presentation/screens/alojamientos_screen.dart';
import 'package:app/presentation/screens/favoritos_screen.dart';
import 'package:app/presentation/screens/gastronomicos_screen.dart';



class HomeScreen extends StatefulWidget {

  static const String ROUTENAME = "home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final iconList = List.unmodifiable([ 
      {"icon": Icons.hotel}, 
      {"icon": Icons.favorite}, 
      {"icon": Icons.restaurant}, 
  ]);

  final screens = List<Widget>.unmodifiable([
    AlojamientosScreen(),
    FavoritosScreen(),
    GastronomicosScreen(),
  ]);

  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[navIndex], 
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }


  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: navIndex,
      onTap: (index) {setState(() {
        navIndex = index;
      });},
      items: [ for (var icon in iconList) BottomNavigationBarItem(icon: Icon(icon["icon"]), title: Container()) ]
    );
  }
}
