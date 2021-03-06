import 'package:app/BLoC/bloc.dart';
import 'package:app/presentation/screens/filtros_gastronomicos_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  LatLng _center;
  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    _center = ModalRoute.of(context).settings.arguments ?? LatLng(-54.7999992, -68.3000031);
    return Scaffold(
      appBar: _crearAppBar(context),
      body: BlocBuilder<GastronomicosBloc, GastronomicosState>(
        builder: (context, state) {
          if (state is GastronomicosLoadFailure) {
            return Center(child: Text("Failed to fetch Gastronomicos"),);
          }
          if (state is GastronomicosLoadSuccess) {
            if (state.gastronomicos.isEmpty) {
              return Center(child: Text("Gastronomicos empty"));
            }
            gastronomicos = state.gastronomicos;
            return GoogleMap(
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
          return Center(child: CircularProgressIndicator(),);
        },
      )
    );
  }

  Widget _crearAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0xFFF0AD5F), 
        title: Text("Gastronomicos"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.filter_list), onPressed: (){
            Navigator.pushNamed(  context, FiltrosGastronomicosScreen.ROUTENAME);
            }),
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
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
            markerId: MarkerId(gastronomico.id.toString()),
            position: LatLng(gastronomico.lat, gastronomico.lng),
            infoWindow: InfoWindow(
              title: gastronomico.nombre,
              snippet: gastronomico.domicilio,
            ),
          );
          _markers[gastronomico.id.toString()] = marker;
        }
      }
    );
  }
}