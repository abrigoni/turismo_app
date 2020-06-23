import 'package:flutter/material.dart';


class GastronomicoDetailScreen extends StatelessWidget {
  static const ROUTENAME = "GastronomicoDetail";
  
  @override
  Widget build(BuildContext context) {
    dynamic gastronomico = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Text(gastronomico["nombre"]),
    );
  }
}