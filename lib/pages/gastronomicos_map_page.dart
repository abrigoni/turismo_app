import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GastronomicosMapPage extends StatefulWidget {
  
  
  static const String ROUTENAME = 'GastronomicosMapPage';

  @override
  _GastronomicosMapPageState createState() => _GastronomicosMapPageState();
}

class _GastronomicosMapPageState extends State<GastronomicosMapPage> {
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
        backgroundColor: Color(0xFFF0AD5F), 
        title: Text("Gastronomicos"),
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