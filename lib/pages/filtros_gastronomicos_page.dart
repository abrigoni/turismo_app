import 'package:flutter/material.dart';


class FiltrosGastronomicosPage extends StatelessWidget {

  static const String ROUTENAME = 'FiltroGastronomicosPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtrar Gastronomicos"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text("Filtro de Gastronomicos :D")
      )
    );
  }
}