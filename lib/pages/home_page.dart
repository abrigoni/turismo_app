import 'package:flutter/material.dart';
import 'package:app/pages/alojamientos_page.dart';
import 'package:app/pages/gastronomicos_page.dart';
import 'package:app/providers/alojamiento_provider.dart';
import 'package:app/pages/favoritos_page.dart';


class HomePage extends StatefulWidget {

  static const String ROUTENAME = "home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final iconList = List<IconData>.unmodifiable([ 
      Icons.hotel, 
      Icons.favorite,
      Icons.restaurant
  ]);

  int navIndex = 0;
  final pages = List<Widget>.unmodifiable([
    AlojamientosPage(alojamientosProvider: AlojamientoProvider(),),
    GastronomicosPage(),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[navIndex], 
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed: (){Navigator.pushNamed(context, FavoritosPage.ROUTENAME);}
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }


  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: navIndex,
      onTap: (index) {setState(() {
        navIndex = index;
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
