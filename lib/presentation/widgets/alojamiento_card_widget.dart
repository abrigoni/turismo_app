import 'package:flutter/material.dart';
import 'package:app/data/models/alojamiento_model.dart';



class AlojamientoCardWidget extends StatelessWidget {

  final Alojamiento alojamiento;
  final Function(BuildContext, Alojamiento) onTap;
  final Function(BuildContext, Alojamiento) onLocationTap;

  AlojamientoCardWidget({this.alojamiento, this.onTap, this.onLocationTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTap(context, alojamiento),
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _crearImagen(alojamiento.foto),
                    SizedBox(width:10.0),
                    _crearInfo(alojamiento.nombre, alojamiento.domicilio, alojamiento.categoriaId),
                    SizedBox(width:10.0),
                    GestureDetector(
                      onTap: () => onLocationTap(context, alojamiento),
                      child: Icon(Icons.location_on, color: Colors.blue, size: 50)
                    ),
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
      ),
    );
  }

  Widget _renderizarEstrellas(int categoria) {
    final estrellas = List();
    for (var i = 0; i < categoria; i++) {
      estrellas.add(Icon(Icons.star, color: Colors.yellow, size: 20.0));
    }
    return Row(
      children:  estrellas.map<Widget>((estrella)=>estrella).toList()
    );
  }

  Widget _crearInfo(String nombre, String domicilio, int categoria) {
    return Container(
      width: 120.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(nombre, overflow: TextOverflow.clip),
          Text(domicilio),
          _renderizarEstrellas(categoria),
        ],
      ),
    );
  }
}