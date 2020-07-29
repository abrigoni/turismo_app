import 'dart:io';

import 'package:app/data/models/favorito_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/data/providers/providers.dart';
import 'package:app/data/models/models.dart';
import 'package:app/BLoC/bloc.dart';
import 'package:app/presentation/widgets/map_widget.dart';
import 'package:image_picker/image_picker.dart';

class AlojamientoDetailScreen extends StatefulWidget {
  static const String ROUTENAME = 'Alojamiento-Detail';
  final ClasificacionProvider clasificacionProvider;
  final CategoriaProvider categoriaProvider;
  final LocalidadProvider localidadProvider;

  AlojamientoDetailScreen(
      {@required this.clasificacionProvider,
      @required this.categoriaProvider,
      @required this.localidadProvider});

  @override
  _AlojamientoDetailScreenState createState() =>
      _AlojamientoDetailScreenState();
}

class _AlojamientoDetailScreenState extends State<AlojamientoDetailScreen> {
  Alojamiento alojamiento;
  Future<Clasificacion> futureClasificacion;
  Future<Categoria> futureCategoria;
  Future<Localidad> futureLocalidad;
  FavoritosBloc _favoritosBloc;
  TextStyle dataStyle = TextStyle(fontSize: 20);
  File _image;
  final picker = ImagePicker();
  List<Favorito> favoritos = [];
  bool esFavorito = false;
  Favorito favorito;

  @override
  Widget build(BuildContext context) {
    alojamiento = ModalRoute.of(context).settings.arguments;

    futureClasificacion = widget.clasificacionProvider
        .getClasificacionById(alojamiento.clasificacionId);
    futureCategoria =
        widget.categoriaProvider.getcategoriaById(alojamiento.categoriaId);
    futureLocalidad =
        widget.localidadProvider.getLocalidadById(alojamiento.localidadId);

    _favoritosBloc = BlocProvider.of<FavoritosBloc>(context);
    if (_favoritosBloc.state is FavoritosLoadSuccess) {
      var _state = _favoritosBloc.state as FavoritosLoadSuccess;
      favoritos = _state.favoritos;
      try {
        favorito = favoritos.firstWhere((e) => e.esAlojamiento && e.establecimientoId == alojamiento.id);
        esFavorito = favorito != null;
      } catch (_) {
        print(_);
      }
      
    }

    return Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: FloatingActionButton(
            onPressed: () {
              
              if (esFavorito) {
                _favoritosBloc.add(FavoritoDelete(establecimiento: alojamiento, esAlojamiento: true ));
              }
              else {
                _favoritosBloc.add(FavoritoCreate(
                  establecimiento: alojamiento, esAlojamiento: true));
              }
              esFavorito = !esFavorito;
              setState(() {
                
              });
            },
            child: Icon(Icons.favorite, color: esFavorito ? Colors.red[300] : Colors.white ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _crearContenedorImagen(context),
              SizedBox(
                height: 10.0,
              ),
              _crearDatos(context),
              SizedBox(
                height: 10.0,
              ),
              MapWidget(
                id: alojamiento.id.toString(),
                position: LatLng(alojamiento.lat, alojamiento.lng),
                titulo: alojamiento.nombre,
                domicilio: alojamiento.domicilio,
              ),
              SizedBox(
                height: 10.0,
              ),
              esFavorito ? _crearSeccionRecuerdos() : Container()
            ],
          ),
        )));
  }

  Widget _crearContenedorImagen(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: <Widget>[_crearImagen(), _accionesImagen(context)],
      ),
    );
  }

  Widget _crearImagen() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0)),
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
        });
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
          Text(alojamiento.nombre,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          _puntuacion(),
        ],
      ),
    );
  }

  Widget _crearClasificacion() {
    return FutureBuilder<Clasificacion>(
        future: futureClasificacion,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Text(snapshot.data.nombre, style: dataStyle);
          return CircularProgressIndicator();
        });
  }

  Widget _crearLocalidad() {
    return FutureBuilder<Localidad>(
        future: futureLocalidad,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Text(snapshot.data.nombre, style: dataStyle);
          return CircularProgressIndicator();
        });
  }

  Widget _crearDatos(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _crearTitulo(),
            SizedBox(height: 10.0),
            _crearClasificacion(),
            SizedBox(height: 10.0),
            _crearLocalidad(),
            SizedBox(height: 10.0),
          ],
        ));
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
                  _favoritosBloc.add(FavoritoUpdate(esAlojamiento: true, establecimiento: alojamiento.id, image: _image.path, borrado: false)); 
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


  Widget _mostrarRecuerdos() {
    if (favorito.recuerdos?.length == 0) {
      return Center(child: Text("Todavía no hay recuerdos de este establecimiento"));
    } else {
      return Column(
        children: favorito.recuerdos.map((recuerdo) {
        return Text("recuerdo");
        }).toList()
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
