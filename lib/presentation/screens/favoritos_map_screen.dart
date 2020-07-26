import 'package:app/BLoC/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/data/models/favorito_model.dart';


class FavoritosMapScreen extends StatefulWidget {
  static const String ROUTENAME = 'FavoritosMapScreen';

  @override
  _FavoritosMapScreenState createState() => _FavoritosMapScreenState();
}

class _FavoritosMapScreenState extends State<FavoritosMapScreen> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(-54.7999992, -68.3000031);

  final Map<String, Marker> _markers = {};

  List<Favorito> favoritos;

  AlojamientosBloc _alojamientosBloc;
  GastronomicosBloc _gastronomicosBloc;

  @override
  Widget build(BuildContext context) {
    _alojamientosBloc = BlocProvider.of<AlojamientosBloc>(context);
    _gastronomicosBloc = BlocProvider.of<GastronomicosBloc>(context);
    return Scaffold(
      backgroundColor: Color(0xFF4EAEFB),
      appBar: _crearAppBar(context),
      body: BlocBuilder<FavoritosBloc, FavoritosState>(
        builder: (context, state) {
            if (state is FavoritosLoadFailure) {
              return Center(
                child: Text('Failed to fetch favoritos'),
              );
            }
            if (state is FavoritosLoadSuccess) {
              favoritos = state.favoritos;
              return _crearMapScreen(context);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      )
    );
  }

  Widget _crearMapScreen(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 15.0,
      ),
      markers: _markers.values.toSet(),
    );
  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    var idx = 0;
    setState(() {
      _markers.clear();
      for (final favorito in favoritos) {
        if (favorito.visible) {
          var establecimiento;
          if (favorito.esAlojamiento) {
            var _state = _alojamientosBloc.state as AlojamientosLoadSuccess;
            establecimiento = _state.alojamientos.firstWhere((element) => element.id == favorito.establecimientoId);
          } else {
            var _state = _gastronomicosBloc.state as GastronomicosLoadSuccess;
            establecimiento = _state.gastronomicos.firstWhere((element) => element.id == favorito.establecimientoId);
          }
          final marker = Marker(
            markerId: MarkerId(idx.toString()),
            position: LatLng(establecimiento.lat, establecimiento.lng),
            infoWindow: InfoWindow(
              title: establecimiento.nombre,
              snippet: establecimiento.domicilio,
            ),
          );
          _markers[idx.toString()] = marker;
          idx++;
        }
      }
    });
  }


  Widget _crearAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF4EAEFB),
      title: Text("Mapa - Favoritos"),
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
