import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapWidget extends StatefulWidget {

  final String id;
  final LatLng position;
  final String titulo; 
  final String domicilio;

  MapWidget({this.id, this.position, this.titulo, this.domicilio});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    
    setState(() {
        
      Marker marker = Marker(
        markerId: MarkerId(widget.id.toString()),
        position: widget.position,
      );

      _markers[widget.id] = marker;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[700]),
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: widget.position,
                zoom: 15.0,
              ),
              myLocationEnabled: true,
              markers: _markers.values.toSet(),
            ),
            Container(
              height: 20.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(widget.domicilio)
                ],
              ),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[700])),
                color: Colors.grey[400]
              ),
            ),
          ],
        )
      )
    );
  }
}