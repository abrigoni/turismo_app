
import 'package:app/providers/categoria_provider.dart';
import 'package:app/providers/clasificacion_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/alojamientos_map_page.dart';
import 'package:app/pages/filtros_gastronomicos_page.dart';
import 'package:app/pages/gastronomicos_map_page.dart';
import 'package:app/pages/alojamiento_detail_page.dart';
import 'package:app/pages/favoritos_page.dart';
import 'package:app/pages/filtros_alojamientos_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Turismo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomePage.ROUTENAME,
        routes: {
          HomePage.ROUTENAME:                 (BuildContext context) => HomePage(),
          AlojamientosMapPage.ROUTENAME:      (BuildContext context) => AlojamientosMapPage(),
          FiltrosAlojamientosPage.ROUTENAME:  (BuildContext context) => FiltrosAlojamientosPage(clasificacionProvider: ClasificacionProvider(), categoriaProvider: CategoriaProvider()),
          AlojamientoDetailPage.ROUTENAME:    (BuildContext context) => AlojamientoDetailPage(),
          GastronomicosMapPage.ROUTENAME:     (BuildContext context) => GastronomicosMapPage(),
          FiltrosGastronomicosPage.ROUTENAME: (BuildContext context) => FiltrosGastronomicosPage(),
          FavoritosPage.ROUTENAME:            (BuildContext context) => FavoritosPage(),
        }
      );
  }
}
