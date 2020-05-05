import 'package:flutter/material.dart';
import 'package:turismoapp/models/alojamiento_model.dart';



class AlojamientoListContainerWidget extends StatelessWidget {

  final List<Alojamiento> alojamientos;

  AlojamientoListContainerWidget({this.alojamientos});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(54), topRight: Radius.circular(54)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 20.0),
        ]
      ),
      child: _renderizarLista()
      
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

  _renderizarEstrellas(int categoria) {
    print(categoria);
    final estrellas = List();
    for (var i = 0; i < categoria; i++) {
      estrellas.add(Icon(Icons.star, color: Colors.yellow, size: 20.0));
    }
    return Row(
      children:  estrellas.map<Widget>((estrella)=>estrella).toList()
    );
  }

  Widget _crearInfo(String nombre, String domicilio, int clasificacion, int categoria) {
    return Container(
      width: 120.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(nombre, overflow: TextOverflow.clip),
          Text(clasificacion.toString()),
          Text(domicilio),
          _renderizarEstrellas(categoria),
        ],
      ),
    );
  }

  Widget _crearAcciones() {
    return Row(
      children: <Widget>[
        Icon(Icons.location_on, color: Colors.blue),
        Icon(Icons.favorite, color: Colors.red)
      ],
    );
  }

  Widget _alojamientoCard(Alojamiento alojamiento) {
    return Center(
      child: Container(
        width: 300,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _crearImagen(alojamiento.foto),
                SizedBox(width:10.0),
                _crearInfo(alojamiento.nombre, alojamiento.domicilio, alojamiento.clasificacionId, alojamiento.categoriaId),
                SizedBox(width:10.0),
                _crearAcciones()
              ],
            ),
            Divider()
          ],
        )
      ),
    );
  }

  Widget _renderizarLista() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: ListView.builder(
                itemCount: alojamientos.length,
                itemBuilder: (BuildContext context, int index) {
                  final alojamiento = alojamientos[index]; 
                  return _alojamientoCard(alojamiento);
            }
        ),
      ),
    );
  }
}