import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/BLoC/bloc.dart';
import 'package:app/BLoC/alojamientos_bloc/alojamientos_bloc.dart';
import 'package:app/BLoC/favoritos_bloc/favoritos_bloc.dart';
import 'package:app/presentation/screens/alojamiento_detail_screen.dart';
import 'package:app/presentation/screens/gastronomico_detail_screen.dart';
import 'package:app/presentation/widgets/alojamiento_card_widget.dart';
import 'package:app/presentation/widgets/gastronomico_card_widget.dart';
import 'package:app/presentation/widgets/searchbar_widget.dart';
import 'package:app/presentation/screens/favoritos_map_screen.dart';
import 'package:app/data/models/models.dart';
import 'package:app/data/models/favorito_model.dart';


class FavoritosScreen extends StatelessWidget {

  static const String ROUTENAME = "Favoritos";

  @override
  Widget build(BuildContext context) {
    FavoritosBloc _favoritosBloc = BlocProvider.of<FavoritosBloc>(context);
    AlojamientosBloc _alojamientosBloc = BlocProvider.of<AlojamientosBloc>(context);
    GastronomicosBloc _gastronomicosBloc = BlocProvider.of<GastronomicosBloc>(context);

    return Scaffold(
      backgroundColor: Colors.red[300],
        appBar: _crearAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height:20),
          SearchBarWidget(bloc: _favoritosBloc, blocType: 'favorito'),
          SizedBox(height:20),
          Expanded(
            child: _crearListContainer(context, _favoritosBloc, _alojamientosBloc, _gastronomicosBloc)
          )
        ]
      )
    );
  }

  Widget _crearAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red[300],
      title: Text("Favoritos"),
      centerTitle: true,
      leading: IconButton(icon: Icon(Icons.map), onPressed: () async {
        Navigator.pushNamed(context, FavoritosMapScreen.ROUTENAME);
      }),
    );
  }

  Widget _crearListContainer(BuildContext context, FavoritosBloc bloc, AlojamientosBloc alojamientosBloc, GastronomicosBloc gastronomicosBloc) {
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
        BlocBuilder<FavoritosBloc, FavoritosState>(
          builder: (context, state) {
            if (state is FavoritosLoadFailure) {
              return Center(
                child: Text('Fallo al buscar Favoritos'),
              );
            }
            if (state is FavoritosLoadSuccess) {
              if (state.favoritos.isEmpty) {
                return Center(
                  child: Text('Favoritos vacio'),
                );
              }
              return _favoritosListView(state.favoritos, bloc, alojamientosBloc, gastronomicosBloc);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ],
    );
  }

  Widget _favoritosListView(List<Favorito> favoritos, FavoritosBloc bloc, AlojamientosBloc alojamientosBloc, GastronomicosBloc gastronomicosBloc) {
    return Center(
      child: Container(
      padding: EdgeInsets.only(top: 20.0),
      child: ListView.builder(
        itemCount: favoritos.length,
        itemBuilder: (BuildContext context, int index) {
          var favorito = favoritos[index];
          if (favorito.visible) {
            if (favorito.esAlojamiento) {
              var alojamientosState = alojamientosBloc.state as AlojamientosLoadSuccess;
              var alojamiento = alojamientosState.alojamientos.firstWhere((element) => element.id == favorito.establecimientoId);
              return AlojamientoCardWidget(alojamiento: alojamiento, onTap: _onAlojamientoCardTap);
            }
            var gastronomicosState = gastronomicosBloc.state as GastronomicosLoadSuccess;
            var gastronomico = gastronomicosState.gastronomicos.firstWhere((element) => element.id == favorito.establecimientoId);
            return GastronomicoCardWidget(gastronomico: gastronomico, onTap: _onGastronomicoCardTap);
          }
          return Container();
        },
      )),
    );
  }

  _onAlojamientoCardTap(BuildContext context, Alojamiento alojamiento) {
    Navigator.pushNamed(context, AlojamientoDetailScreen.ROUTENAME, arguments: alojamiento);
  }

  _onGastronomicoCardTap(BuildContext context, Gastronomico gastronomico) {
    Navigator.pushNamed(context, GastronomicoDetailScreen.ROUTENAME, arguments: gastronomico);
  }
}