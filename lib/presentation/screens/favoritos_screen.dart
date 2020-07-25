import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/BLoC/favoritos_bloc/favoritos_bloc.dart';
import 'package:app/presentation/widgets/searchbar_widget.dart';
import 'package:app/presentation/screens/favoritos_map_screen.dart';


class FavoritosScreen extends StatelessWidget {

  static const String ROUTENAME = "Favoritos";

  @override
  Widget build(BuildContext context) {
    FavoritosBloc _favoritosBloc = BlocProvider.of<FavoritosBloc>(context);

    return Scaffold(
      backgroundColor: Color(0xFF4EAEFB),
        appBar: _crearAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height:20),
          SearchBarWidget(bloc: _favoritosBloc, blocType: 'Favorito'),
          SizedBox(height:20),
          Expanded(
            child: _crearListContainer(context)
          )
        ]
      )
    );
  }

  Widget _crearAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF4EAEFB),
      title: Text("Favoritos"),
      centerTitle: true,
      leading: IconButton(icon: Icon(Icons.map), onPressed: () async {
        Navigator.pushNamed(context, FavoritosMapScreen.ROUTENAME);
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
              return _favoritosListView(state.favoritos);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ],
    );
  }

  Widget _favoritosListView(List<dynamic> favoritos) {
    return Container(
      child: Text("Listado")
    );
  }
}