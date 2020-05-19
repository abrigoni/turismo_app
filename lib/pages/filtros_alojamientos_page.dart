import 'package:flutter/material.dart';


class FiltrosAlojamientosPage extends StatelessWidget {

  static const String ROUTENAME = 'FiltroAlojamientosPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtrar alojamientos"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text("Filtro de alojamientos :D")
      )
    );
  }
}