import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/models/alojamiento_model.dart';
import 'package:app/providers/alojamiento_provider.dart';
import 'package:app/BLoC/alojamiento_bloc.dart';
import 'package:app/BLoC/alojamiento_event.dart';
import 'package:app/BLoC/alojamiento_state.dart';
import 'package:app/pages/filtros_alojamientos_page.dart';


class AlojamientosMapPage extends StatelessWidget {

  static const String ROUTENAME = 'AlojamientosMapPage';

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF4EAEFB),
        appBar: _crearAppBar(context),
        body: BlocProvider(
          create: (context) =>
              AlojamientoBloc(alojamientoProvider: AlojamientoProvider() )..add(FetchAlojamientos()),
          child: AlojamientosUI()
      ),
    );
  }

  Widget _crearAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0xFF4EAEFB), 
        title: Text("Mapa - Alojamientos"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.filter_list), onPressed: (){
            Navigator.pushNamed(context, FiltrosAlojamientosPage.ROUTENAME);
          }),
        ],
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pop(context);
        }),
    );
  }

}


class AlojamientosUI extends StatefulWidget {
  @override
  _AlojamientosUIState createState() => _AlojamientosUIState();
}

class _AlojamientosUIState extends State<AlojamientosUI> {
  
  /* mapa */
  GoogleMapController mapController;
  final LatLng _center = const LatLng(-54.7999992,-68.3000031);
  final Map<String, Marker> _markers = {};
  /* bloc */
  AlojamientoBloc _alojamientoBloc;
  List<Alojamiento> alojamientos;

  @override
  void initState() {
    super.initState();
    _alojamientoBloc = BlocProvider.of<AlojamientoBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlojamientoBloc, AlojamientoState>(
      builder: (context, state) {
        if (state is AlojamientoFailure) {
          return Center(
            child: Text('failed to fetch alojamientos'),
          );
        }
        if (state is AlojamientoSuccess) {
          if (state.alojamientos.isEmpty) {
            return Center(
              child: Text('no alojamientos'),
            );
          }
          alojamientos = state.alojamientos;
          return _crearMapScreen(context);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
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
  
}