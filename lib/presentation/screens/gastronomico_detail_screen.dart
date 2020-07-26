import 'package:app/BLoC/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/data/models/gastronomico_model.dart';
import 'package:app/presentation/widgets/map_widget.dart';


class GastronomicoDetailScreen extends StatelessWidget {
  static const ROUTENAME = "GastronomicoDetail";
  final TextStyle dataStyle = TextStyle(fontSize: 20);
  
  @override
  Widget build(BuildContext context) {
    Gastronomico gastronomico = ModalRoute.of(context).settings.arguments;
    FavoritosBloc _favoritosBloc = BlocProvider.of<FavoritosBloc>(context);
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: (){
            _favoritosBloc.add(FavoritoCreate(establecimiento: gastronomico, esAlojamiento: false));
          },
          child: Icon(Icons.favorite),
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked, 
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _crearContenedorImagen(context, gastronomico.foto),
              SizedBox(height: 10.0),
              _crearDatos(context, gastronomico), 
              MapWidget(
                id: gastronomico.id.toString(),
                position: LatLng(gastronomico.lat, gastronomico.lng),
                titulo: gastronomico.nombre,
                domicilio: gastronomico.domicilio
              ),
              SizedBox(height: 10.0),
            ],
          )
        ),
      )
    );
  }


  Widget _crearContenedorImagen(BuildContext context, String url) {
    return Container(
      width: double.infinity, 
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0), bottomRight: Radius.circular(40.0)),
            child: FadeInImage(
              placeholder: AssetImage("assets/img/loading.gif"),
              image: NetworkImage(url)
            )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back), 
                onPressed: () => Navigator.pop(context),
                iconSize: 45
              )
            ],
          )
        ],
      )
    );
  }

  Widget _crearDatos(BuildContext context, Gastronomico gastronomico) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(gastronomico.nombre, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)), 
          SizedBox(height: 10.0),
          _crearActividades(gastronomico.actividades),
          SizedBox(height: 10.0),
          _crearEspecialidades(gastronomico.especialidades),
          SizedBox(height: 10.0),
          Text(gastronomico.localidad["nombre"], style: dataStyle),
          SizedBox(height: 10.0),
        ],
      )
    );
  }

  Widget _crearActividades(List<dynamic> actividades) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Actividades", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Wrap(
          children: actividades.map<Widget>( (especialidad) {
            return Chip(
              label: Text(especialidad["actividad"]["nombre"]),
            );
          }).toList()
        ),
      ],
    );
  }

  Widget _crearEspecialidades(List<dynamic> especialidades) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Especialidades", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Wrap(
          children: especialidades.map<Widget>( (especialidad) {
            return Chip(
              label: Text(especialidad["especialidad"]["nombre"]),
            );
          }).toList()
        ),
      ],
    );
  }
}