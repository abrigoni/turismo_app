import 'package:app/presentation/screens/alojamiento_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/BLoC/bloc.dart';
import 'package:app/data/models/models.dart';
import 'package:app/presentation/screens/filtros_alojamientos_screen.dart';

class AlojamientosMapScreen extends StatefulWidget {
  static const String ROUTENAME = 'AlojamientosMapScreen';

  @override
  _AlojamientosMapScreenState createState() => _AlojamientosMapScreenState();
}

class _AlojamientosMapScreenState extends State<AlojamientosMapScreen> {
  GoogleMapController mapController;

  LatLng _center;

  Map<String, Marker> _markers = {};

  List<Alojamiento> alojamientos;

  @override
  Widget build(BuildContext context) {
    _center = ModalRoute.of(context).settings.arguments ?? LatLng(-54.7999992, -68.3000031);

    return Scaffold(
        backgroundColor: Color(0xFF4EAEFB),
        appBar: _crearAppBar(context),
        body: BlocBuilder<AlojamientosBloc, AlojamientosState>(
          builder: (context, state) {
            if (state is AlojamientosLoadFailure) {
              return Center(
                child: Text('Failed to fetch Alojamientos'),
              );
            }
            if (state is AlojamientosLoadSuccess) {
              alojamientos = state.alojamientos;
              return _crearMapScreen(context);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Widget _crearMapScreen(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      trafficEnabled: true,
      myLocationButtonEnabled: true,
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
    setState(() {
      _markers.clear();
      for (final alojamiento in alojamientos) {
        if (alojamiento.visible) {
          final marker = Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
            markerId: MarkerId(alojamiento.id.toString()),
            position: LatLng(alojamiento.lat, alojamiento.lng),
            infoWindow: InfoWindow(
              title: alojamiento.nombre,
              snippet: alojamiento.domicilio,
            ),
          );
          _markers[alojamiento.id.toString()] = marker;
        }
      }
    });
  }

  Widget _crearAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF4EAEFB),
      title: Text("Mapa - Alojamientos"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.pushNamed(context, FiltrosAlojamientosScreen.ROUTENAME);
            }),
      ],
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
