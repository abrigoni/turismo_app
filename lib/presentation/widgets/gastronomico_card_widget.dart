import 'package:app/data/models/gastronomico_model.dart';
import 'package:flutter/material.dart';



class GastronomicoCardWidget extends StatelessWidget {

  final Gastronomico gastronomico;
  final Function(BuildContext, Gastronomico) onTap;

  GastronomicoCardWidget({this.gastronomico, this.onTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTap(context, gastronomico),
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _crearImagen(gastronomico.foto),
                    SizedBox(width:10.0),
                    _crearInfo(gastronomico.nombre, gastronomico.localidad["nombre"]),
                    SizedBox(width: 10.0),
                    Icon(Icons.location_on, color: Colors.orange, size: 30),
                  ],
                ),
                Divider()
              ],
            )
          ),
      ),
    );
  }

  Widget _crearImagen(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: FadeInImage(
        height: 90.0,
        width: 90.0,
        image: url != null ? NetworkImage(url) : AssetImage("assets/img/no-img.png"),
        fit: BoxFit.contain, 
        placeholder: AssetImage("assets/img/loading.gif")
      )
    );
  }

  Widget _crearInfo(String nombre, String localidad) {
    return Container(
      width: 120.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(nombre),
          Text(localidad)
        ],
      )
    );
  }

}