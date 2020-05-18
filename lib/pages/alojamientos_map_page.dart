import 'package:app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class AlojamientosMapPage extends StatefulWidget {
  
  
  static const String ROUTENAME = 'AlojamientosMapPage';

  @override
  _AlojamientosMapPageState createState() => _AlojamientosMapPageState();
}

class _AlojamientosMapPageState extends State<AlojamientosMapPage> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(-54.7999992,-68.3000031);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _crearAppBar(context),
      body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
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
          Navigator.pushNamed(context, HomePage.ROUTENAME);
        }),
    );
  }
}