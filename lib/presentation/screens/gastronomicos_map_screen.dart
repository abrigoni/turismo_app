import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GastronomicosMapScreen extends StatefulWidget {
  
  
  static const String ROUTENAME = 'GastronomicosMapScreen';

  @override
  _GastronomicosMapScreenState createState() => _GastronomicosMapScreenState();
}

class _GastronomicosMapScreenState extends State<GastronomicosMapScreen> {

  List<dynamic> gastronomicos;

  /* Map */
  GoogleMapController mapController;
  final LatLng _center = const LatLng(-54.7999992,-68.3000031);
  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    gastronomicos = ModalRoute.of(context).settings.arguments;
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
        _markers.clear();
        for (final gastronomico in gastronomicos) {
          final marker = Marker(
            markerId: MarkerId(gastronomico["id"].toString()),
            position: LatLng(gastronomico["lat"], gastronomico["lng"]),
            infoWindow: InfoWindow(
              title: gastronomico["nombre"],
              snippet: gastronomico["domicilio"],
            ),
          );
          _markers[gastronomico["id"].toString()] = marker;
        }
      }
    );
  }
}