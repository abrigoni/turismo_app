import 'package:flutter/material.dart';
import 'package:turismoapp/pages/alojamientos_page.dart';
import 'package:turismoapp/pages/gastronomicos_page.dart';


class HomePage extends StatefulWidget {

  static const String ROUTENAME = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currentIndex), 
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed: (){},
      ),
    );
  }

  Widget _callPage(int paginaActual) {
    switch(paginaActual) {
      case 0: return AlojamientosPage();
      case 1: return GastronomicosPage();
      default: return AlojamientosPage();
    }
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {setState(() {
        currentIndex = index;
      });},
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.hotel),
          title: Text('Alojamientos')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          title: Text('Gastronomicos')
        )
      ]
    );
  }
}