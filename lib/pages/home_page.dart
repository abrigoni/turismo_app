import 'package:flutter/material.dart';
import 'package:app/pages/alojamientos_page.dart';
import 'package:app/pages/gastronomicos_page.dart';
import 'package:app/providers/alojamiento_provider.dart';
import 'package:app/widgets/custom_navbar_widget.dart';


class HomePage extends StatefulWidget {

  static const String ROUTENAME = "home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final iconList = List<IconData>.unmodifiable([ 
      Icons.hotel, 
      Icons.restaurant
  ]);

  int navIndex = 0;
  final pages = List<Widget>.unmodifiable([
    AlojamientosPage(alojamientosProvider: AlojamientoProvider(),),
    GastronomicosPage()
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[navIndex], 
      bottomNavigationBar: CustomNavBarWidget(
        icons: iconList, 
        onPressed: (i) => setState(() => navIndex = i), 
        activeIndex: navIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF95A5A6),
        child: Icon(Icons.favorite),
        onPressed: (){},
      ),
    );
  }
}
