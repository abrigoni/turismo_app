import 'package:flutter/material.dart';


class FavoritosScreen extends StatelessWidget {

  static const String ROUTENAME = "Favoritos";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Favoritos")
        )
      )
    );
  }
}