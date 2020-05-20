import 'package:flutter/material.dart';
import 'package:app/models/alojamiento_model.dart';


class AlojamientoDetailPage extends StatelessWidget {
  static const String ROUTENAME = 'Alojamiento-Detail';
  Alojamiento alojamiento;

  
  @override
  Widget build(BuildContext context) {
    alojamiento = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Center(child: Text(alojamiento.nombre))
    );
  }
}