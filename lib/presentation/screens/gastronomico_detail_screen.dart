import 'dart:io';

import 'package:app/BLoC/bloc.dart';
import 'package:app/data/models/favorito_model.dart';
import 'package:app/presentation/widgets/recuerdo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/data/models/gastronomico_model.dart';
import 'package:app/presentation/widgets/map_widget.dart';
import 'package:image_picker/image_picker.dart';


class GastronomicoDetailScreen extends StatefulWidget {
  static const ROUTENAME = "GastronomicoDetail";

  @override
  _GastronomicoDetailScreenState createState() => _GastronomicoDetailScreenState();
}

class _GastronomicoDetailScreenState extends State<GastronomicoDetailScreen> {
  final TextStyle dataStyle = TextStyle(fontSize: 20);
  Gastronomico gastronomico;
  File _image;
  final picker = ImagePicker();
  List<Favorito> favoritos = [];
  FavoritosBloc _favoritosBloc;
  bool esFavorito = false;
  Favorito favorito;

  @override
  Widget build(BuildContext context) {
    gastronomico = ModalRoute.of(context).settings.arguments;
    _favoritosBloc = BlocProvider.of<FavoritosBloc>(context);

    _favoritosBloc = BlocProvider.of<FavoritosBloc>(context);
    if (_favoritosBloc.state is FavoritosLoadSuccess) {
      var _state = _favoritosBloc.state as FavoritosLoadSuccess;
      favoritos = _state.favoritos;
      try {
        favorito = favoritos.firstWhere((e) => !e.esAlojamiento && e.establecimientoId == gastronomico.id);
        esFavorito = favorito != null;
      } catch (_) {
        print(_);
      }
      
    }

    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: (){
            if (esFavorito) {
                _favoritosBloc.add(FavoritoDelete(establecimiento: gastronomico, esAlojamiento: false ));
              }
              else {
                _favoritosBloc.add(FavoritoCreate(
                  establecimiento: gastronomico, esAlojamiento: false));
              }
              esFavorito = !esFavorito;
              setState(() {
                
              });
    
          },
          child: Icon(Icons.favorite, color: esFavorito ? Colors.red[300] : Colors.white ),
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
              esFavorito ? _crearSeccionRecuerdos() : Container()
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

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
Widget _crearNuevoRecuerdo() {
    return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[700]),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                height: 200,
                width: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: _image == null ? Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("No se seleccionó ninguna imagen"),
                  )) : Image.file(_image, fit: BoxFit.contain,)
                )
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                      onTap: getImageFromCamera,
                      child: Icon(Icons.camera_alt, size: 50)),
                  GestureDetector(
                      onTap: getImageFromGallery,
                      child: Icon(Icons.collections, size: 50)),
                ],
              )
            ],
          ),
          _image != null ? 
            GestureDetector(
                onTap: () { 
                  _favoritosBloc.add(FavoritoUpdate(establecimiento: gastronomico, esAlojamiento: false, image: _image.path, borrado: false)); 
                  _image = null;
                  setState(() {
                    
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0xFF18C5C1), const Color(0xFF5BC6D0)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text("Guardar", style: TextStyle(color: Colors.white, fontSize: 20)),
                  )
                )
              )
            :
            Container()
      ]
    );
  }


    void deleteRecuerdo(String filePath, Favorito favorito) {
      _favoritosBloc.add(FavoritoUpdate(
                    establecimiento: gastronomico,
                    esAlojamiento: false,
                    image: filePath,
                    borrado: true));
      setState(() {
      
      });
    } 

  Widget _mostrarRecuerdos() {
    if (favorito.recuerdos?.length == 0) {
      return Center(child: Text("Todavía no hay recuerdos de este establecimiento"));
    } else {
      return Wrap(
        direction: Axis.horizontal,
        children: favorito.recuerdos.map((e) {
          return RecuerdoWidget(filePath: e, favorito: favorito, func: deleteRecuerdo);
        }).toList(),
      );
    }
  }
  Widget _crearSeccionRecuerdos() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Recuerdos",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 20),
            _crearNuevoRecuerdo(),
            SizedBox(height: 20),
            _mostrarRecuerdos()
          ],
        ));
  }
}