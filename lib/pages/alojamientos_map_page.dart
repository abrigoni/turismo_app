import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/models/alojamiento_model.dart';


class AlojamientosMapPage extends StatefulWidget {
  
  static const String ROUTENAME = 'AlojamientosMapPage';

  @override
  _AlojamientosMapPageState createState() => _AlojamientosMapPageState();
}

class _AlojamientosMapPageState extends State<AlojamientosMapPage> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(-54.7999992,-68.3000031);
  List<Alojamiento> alojamientos;
  final Map<String, Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    setState(() {
      _markers.clear();
        for (final alojamiento in alojamientos) {
          final marker = Marker(
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
    );
  }



  @override
  Widget build(BuildContext context) {
    alojamientos = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: _crearAppBar(context),
      body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
          markers: _markers.values.toSet(),
      )
    );
  }

  Widget _crearAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0xFF4EAEFB), 
        title: Text("Alojamientos"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.filter_list), onPressed: (){}),
        ],
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pop(context);
        }),
    );
  }
}