import 'dart:io';

import 'package:app/data/models/favorito_model.dart';
import 'package:flutter/material.dart';


class RecuerdoWidget extends StatefulWidget {

  final String filePath;
  final Favorito favorito;
  final Function(String, Favorito) func;

  RecuerdoWidget({@required this.filePath, @required this.favorito, @required this.func});

  @override
  _RecuerdoWidgetState createState() => _RecuerdoWidgetState();
}

class _RecuerdoWidgetState extends State<RecuerdoWidget> {

  bool overlayVisible = false;
  bool alertVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () { setState((){overlayVisible = !overlayVisible;}); },
        child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: Stack(
            children: <Widget>[
              Image.file(
                File(widget.filePath),
                height: 90.0,
                width: 90.0,
              ),
              _crearOverlay(),
            ],
          )
        )
      ),
    );
  }

  Widget _crearOverlay() {
    if (!overlayVisible) return SizedBox(height: 1);
    return Container(
      width: 90.0,
      height: 90.0,
      color: Color.fromRGBO(231, 76, 60, 0.4),
      child: GestureDetector(
        onTap: _showMyDialog,
        child: Icon(Icons.delete, color: Colors.white, size: 40)
      )
    );
  }

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Borrar recuerdo'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('¿Desea borrar el recuerdo seleccionado?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Si'),
            onPressed: () {
              Navigator.of(context).pop();
              widget.func(widget.filePath, widget.favorito);
            },
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}