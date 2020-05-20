import 'package:flutter/material.dart';
import 'package:app/models/alojamiento_model.dart';


class AlojamientoDetailPage extends StatefulWidget {
  static const String ROUTENAME = 'Alojamiento-Detail';

  @override
  _AlojamientoDetailPageState createState() => _AlojamientoDetailPageState();
}

class _AlojamientoDetailPageState extends State<AlojamientoDetailPage> {
  Alojamiento alojamiento;

  @override
  Widget build(BuildContext context) {
    alojamiento = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Center(child: Text(alojamiento.nombre))
    );
  }
}