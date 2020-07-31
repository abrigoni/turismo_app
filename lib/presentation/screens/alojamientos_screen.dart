import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/BLoC/bloc.dart';
import 'package:app/data/models/alojamiento_model.dart';
import 'package:app/presentation/screens/alojamiento_detail_screen.dart';
import 'package:app/presentation/screens/alojamientos_map_screen.dart';
import 'package:app/presentation/screens/filtros_alojamientos_screen.dart';
import 'package:app/presentation/widgets/alojamiento_card_widget.dart';
import 'package:app/presentation/widgets/searchbar_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AlojamientosScreen extends StatelessWidget {

  static const String ROUTENAME = 'Alojamientos';

  @override 
  Widget build(BuildContext context) {
    AlojamientosBloc _alojamientosBloc = BlocProvider.of<AlojamientosBloc>(context);
    return Scaffold(
        backgroundColor: Color(0xFF4EAEFB),
        appBar: _crearAppBar(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 20.0 ),
            SearchBarWidget(bloc: _alojamientosBloc, blocType: "alojamiento",),
            SizedBox(height: 20.0),
            Expanded(
              child: _crearListContainer(context),
            )
          ],
        )
    );
  }

  Widget _crearAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0xFF4EAEFB), 
        title: Text("Alojamientos"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.filter_list), onPressed: (){
            Navigator.pushNamed(context, FiltrosAlojamientosScreen.ROUTENAME);
          }),
        ],
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.map), onPressed: () async {
          Navigator.pushNamed(context, AlojamientosMapScreen.ROUTENAME);
        }),
    );
  }

  Widget _crearListContainer(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(54), topRight: Radius.circular(54)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 20.0),
            ]
          ),
        ),
        BlocBuilder<AlojamientosBloc, AlojamientosState>(
          builder: (context, state) {
            if (state is AlojamientosLoadFailure) {
              return Center(
                child: Text('Fallo al buscar alojamientos'),
              );
            }
            if (state is AlojamientosLoadSuccess) {
              if (state.alojamientos.isEmpty) {
                return Center(
                  child: Text('Alojamientos vacio'),
                );
              }
              return _alojamientosListView(state.alojamientos);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
      )
      ],
    );
  }

  Widget _alojamientosListView(List<Alojamiento> alojamientos) {
    return Center(
        child: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: ListView.builder(
                itemCount: alojamientos.length,
                itemBuilder: (BuildContext context, int index) {
                  if (alojamientos[index].visible)
                    return AlojamientoCardWidget(alojamiento: alojamientos[index], onTap: _onCardTap, onLocationTap: _onLocationTap);
                  else 
                    return Container();
            }
        ),
      ),
    );
  }

  void _onCardTap(BuildContext context, Alojamiento alojamiento) {
    Navigator.pushNamed(context, AlojamientoDetailScreen.ROUTENAME, arguments: alojamiento);
  }

  void _onLocationTap(BuildContext context, Alojamiento alojamiento) {
    Navigator.pushNamed(context, AlojamientosMapScreen.ROUTENAME, arguments: LatLng(alojamiento.lat, alojamiento.lng));
  }

  void searchBlocEvent(String search) {
    // BlocProvider.of<AlojamientosBloc>(context)..add(AlojamientosSearch(search));
    print("Hola");
  }
}
