import 'package:flutter/material.dart';
import 'package:app/presentation/screens/alojamiento_detail_screen.dart';
import 'package:app/presentation/screens/alojamientos_map_screen.dart';
import 'package:app/presentation/screens/favoritos_screen.dart';
import 'package:app/presentation/screens/filtros_alojamientos_screen.dart';
import 'package:app/presentation/screens/filtros_gastronomicos_screen.dart';
import 'package:app/presentation/screens/gastronomico_detail_screen.dart';
import 'package:app/presentation/screens/gastronomicos_map_screen.dart';
import 'package:app/presentation/screens/home_screen.dart';
import 'data/providers/providers.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder> {
  HomeScreen.ROUTENAME:                 (BuildContext context) => HomeScreen(),
  AlojamientosMapScreen.ROUTENAME:      (BuildContext context) => AlojamientosMapScreen(),
  FiltrosAlojamientosScreen.ROUTENAME:  (BuildContext context) => FiltrosAlojamientosScreen(
      clasificacionProvider: ClasificacionProvider(), 
      categoriaProvider: CategoriaProvider(),
      localidadProvider: LocalidadProvider()
  ),
  AlojamientoDetailScreen.ROUTENAME:    (BuildContext context) => AlojamientoDetailScreen(
    clasificacionProvider: ClasificacionProvider(), 
    categoriaProvider: CategoriaProvider(),
    localidadProvider: LocalidadProvider()
  ),
  GastronomicosMapScreen.ROUTENAME:     (BuildContext context) => GastronomicosMapScreen(),
  GastronomicoDetailScreen.ROUTENAME:     (BuildContext context) => GastronomicoDetailScreen(),
  FiltrosGastronomicosScreen.ROUTENAME: (BuildContext context) => FiltrosGastronomicosScreen(),
  FavoritosScreen.ROUTENAME:            (BuildContext context) => FavoritosScreen(),
};