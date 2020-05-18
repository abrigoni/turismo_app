import 'package:flutter/material.dart';
import 'package:app/pages/alojamientos_page.dart';
import 'package:app/pages/gastronomicos_page.dart';
import 'package:app/providers/alojamiento_provider.dart';


class HomePage extends StatefulWidget {

  static const String ROUTENAME = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  IconData selectedItem = Icons.hotel;
  List itemsList = [
      {
        "icon": Icons.hotel, 
        "text": "Alojamientos"
      },
      {
        "icon": Icons.restaurant,
        "text": "Gastronomicos"
      }
  ];

  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currentIndex), 
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF95A5A6),
        child: Icon(Icons.favorite),
        onPressed: (){},
      ),
    );
  }

  Widget _callPage(int paginaActual) {
    switch(paginaActual) {
      case 0: return AlojamientosPage(alojamientosProvider: new AlojamientoProvider(), );
      case 1: return GastronomicosPage();
      default: return AlojamientosPage(alojamientosProvider: new AlojamientoProvider(), );
    }
  }


  // Widget _crearActiveIcon(IconData icon) {

  //   return ShaderMask(
  //             shaderCallback: (Rect bounds) {
  //               return RadialGradient(
  //                 center: Alignment.topLeft,
  //                 radius: 0.5,
  //                 colors: <Color>[
  //                   Colors.red, Colors.orange
  //                 ],
  //                 tileMode: TileMode.repeated,
  //               ).createShader(bounds);
  //             },
  //             child: Icon(icon),
  //   );
  // }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {setState(() {
        currentIndex = index;
      });},
      items: <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: Icon(Icons.hotel),
          title: Container(),
           activeIcon: Icon(Icons.hotel, color: Color(0xFF4EAEFB))
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          title: Container(),
          activeIcon: Icon(Icons.restaurant, color: Color(0xFFF0AD5F))
          // activeIcon: _crearActiveIcon(Icons.restaurant)
        ),
      ]
      
    );
  }
}