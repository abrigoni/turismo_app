import 'package:flutter/material.dart';
import 'package:app/data/providers/providers.dart';
import 'package:app/presentation/screens/alojamiento_detail_screen.dart';
import 'package:app/presentation/screens/alojamientos_map_screen.dart';
import 'package:app/presentation/screens/favoritos_screen.dart';
import 'package:app/presentation/screens/filtros_alojamientos_screen.dart';
import 'package:app/presentation/screens/filtros_gastronomicos_screen.dart';
import 'package:app/presentation/screens/gastronomico_detail_screen.dart';
import 'package:app/presentation/screens/gastronomicos_map_screen.dart';
import 'package:app/presentation/screens/home_screen.dart';

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
        initialRoute: HomeScreen.ROUTENAME,
        routes: {
          HomeScreen.ROUTENAME:                 (BuildContext context) => HomeScreen(),
          AlojamientosMapScreen.ROUTENAME:      (BuildContext context) => AlojamientosMapScreen(),
          FiltrosAlojamientosScreen.ROUTENAME:  (BuildContext context) => FiltrosAlojamientosScreen(
              clasificacionProvider: ClasificacionProvider(), 
              categoriaProvider: CategoriaProvider(),
              localidadProvider: LocalidadProvider()),
          AlojamientoDetailScreen.ROUTENAME:    (BuildContext context) => AlojamientoDetailScreen(
            clasificacionProvider: ClasificacionProvider(), 
            categoriaProvider: CategoriaProvider(),
            localidadProvider: LocalidadProvider()
            ),
          GastronomicosMapScreen.ROUTENAME:     (BuildContext context) => GastronomicosMapScreen(),
          GastronomicoDetailScreen.ROUTENAME:     (BuildContext context) => GastronomicoDetailScreen(),
          FiltrosGastronomicosScreen.ROUTENAME: (BuildContext context) => FiltrosGastronomicosScreen(),
          FavoritosScreen.ROUTENAME:            (BuildContext context) => FavoritosScreen(),
        }
      );
  }
}
