import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/providers/clasificacion_provider.dart';
import 'package:app/providers/categoria_provider.dart';
import 'package:app/providers/localidad_provider.dart';
import 'package:app/models/categoria_model.dart';
import 'package:app/models/localidad_model.dart';
import 'package:app/models/alojamiento_model.dart';
import 'package:app/models/clasificacion_model.dart';
import 'package:app/widgets/map_widget.dart';


class AlojamientoDetailPage extends StatefulWidget {
  static const String ROUTENAME = 'Alojamiento-Detail';
  final ClasificacionProvider clasificacionProvider;
  final CategoriaProvider categoriaProvider;
  final LocalidadProvider localidadProvider;

  AlojamientoDetailPage({
    @required this.clasificacionProvider,
    @required this.categoriaProvider,
    @required this.localidadProvider
  });
  
  @override
  _AlojamientoDetailPageState createState() => _AlojamientoDetailPageState();
}

class _AlojamientoDetailPageState extends State<AlojamientoDetailPage> {
  Alojamiento alojamiento;
  Future<Clasificacion> futureClasificacion;
  Future<Categoria> futureCategoria; 
  Future<Localidad> futureLocalidad;

  TextStyle dataStyle = TextStyle(fontSize: 20);

  @override 
  void initState() {
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    alojamiento = ModalRoute.of(context).settings.arguments;

    futureClasificacion = widget.clasificacionProvider.getClasificacionById(alojamiento.clasificacionId);
    futureCategoria = widget.categoriaProvider.getcategoriaById(alojamiento.categoriaId);
    futureLocalidad = widget.localidadProvider.getLocalidadById(alojamiento.localidadId);

    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _crearContenedorImagen(context),
                  SizedBox(height: 10.0,),
                  _crearDatos(context),
                  SizedBox(height: 10.0,),
                  MapWidget(
                      id: alojamiento.id.toString(),
                      position: LatLng(alojamiento.lat, alojamiento.lng),
                      titulo: alojamiento.nombre,
                      domicilio: alojamiento.domicilio,
                  ),
                  SizedBox(height: 10.0,),
                  alojamiento.favorito ? _crearRecuerdos() : Container()
                ],
              ),
            )
          )
      );
  }

  Widget _crearContenedorImagen(BuildContext context) {
    return Container(
      height: 360.0,
      child: Stack(
        children: <Widget>[
          _crearImagen(),
          _accionesImagen(context)
        ],
      ),
    );
  }

  Widget _crearImagen() {
    return ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0), bottomRight: Radius.circular(40.0)),
        child: FadeInImage(
        placeholder: AssetImage("assets/img/loading.gif"), 
        image: NetworkImage(alojamiento.foto),
      ),
    );
  }

  Widget _accionesImagen(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            iconSize: 45,
          ),
          Container(
              margin: EdgeInsets.only(bottom: 15.0, right: 15.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: (){},
                  child: Icon(Icons.favorite),
                ),
              ],
            ),
          )
        ],
      );
  }

  Widget _crearCategoria() {
    return FutureBuilder<Categoria>(
      future: futureCategoria,
      builder: (context, snapshot) {
        if (snapshot.hasData) 
          return Text(snapshot.data.valor.toString(), style: dataStyle);
        return CircularProgressIndicator();
      } 
    );
    
  }

  Widget _puntuacion() {
    return Row(
      children: <Widget>[
        _crearCategoria(),
        Icon(Icons.star, size: 30, color: Colors.yellow[700])
      ],
    );
  }

  Widget _crearTitulo() {
    return Container(
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(alojamiento.nombre, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        _puntuacion(),
      ],),
    );
  }

  Widget _crearClasificacion() {
    return FutureBuilder<Clasificacion>(
      future: futureClasificacion,
      builder: (context, snapshot) {
        if (snapshot.hasData) 
          return Text(snapshot.data.nombre, style: dataStyle);
        return CircularProgressIndicator();
      } 
    );
  }
  
  Widget _crearLocalidad() {
    return FutureBuilder<Localidad>(
      future: futureLocalidad,
      builder: (context, snapshot) {
        if (snapshot.hasData) 
          return Text(snapshot.data.nombre, style: dataStyle);
        return CircularProgressIndicator();
      }
    ); 
  }

  Widget _crearDatos(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _crearTitulo(),
          SizedBox(height:10.0),
          _crearClasificacion(),
          SizedBox(height:10.0),
          _crearLocalidad(),
          SizedBox(height:10.0),
        ],
      )
    );
  }

  Widget _crearRecuerdos() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Text("Recuerdos")
    );
  }

}
