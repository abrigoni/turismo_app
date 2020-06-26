import 'package:app/BLoC/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app/config/graphql_config.dart';
import 'package:app/presentation/screens/gastronomico_detail_screen.dart';
import 'package:app/presentation/screens/filtros_gastronomicos_screen.dart';
import 'package:app/presentation/screens/gastronomicos_map_screen.dart';
import 'package:app/presentation/widgets/gastronomico_card_widget.dart';
import 'package:app/presentation/widgets/searchbar_widget.dart';

class GastronomicosScreen extends StatefulWidget {
  static const String ROUTENAME = 'Gastronomicos';

  @override
  _GastronomicosScreenState createState() => _GastronomicosScreenState();
}

class _GastronomicosScreenState extends State<GastronomicosScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: _crearAppBar(context),
          backgroundColor: Color(0xFFF0AD5F),
          body: SafeArea(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 20.0),
              SearchBarWidget(),
              SizedBox(height: 20.0),
              Expanded(child: _crearListContainer(context))
            ],
          ))
    );
  }

  Widget _crearAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFF0AD5F),
      title: Text("Gastronomicos"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.pushNamed(
                  context, FiltrosGastronomicosScreen.ROUTENAME);
            }),
      ],
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.map),
          onPressed: () {
            Navigator.pushNamed(context, GastronomicosMapScreen.ROUTENAME);
          }),
    );
  }

  Widget _crearListContainer(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(54), topRight: Radius.circular(54)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 20.0),
              ]),
        ),
        BlocBuilder<GastronomicosBloc, GastronomicosState>(
          builder: (context, state) {
            if (state is GastronomicosLoadFailure) {
              return Center(child: Text("Fallo al buscar gastronomicos"),);
            }
            if (state is GastronomicosLoadSuccess) {
              if (state.gastronomicos.isEmpty) {
                return Center(child: Text("Alojamientos Vacio"),);
              }
              return _gastronomicosListView(state.gastronomicos);
            }
            return Center(
              child: CircularProgressIndicator()
            );
          }
        )
      ],
    );
  }

  Widget _gastronomicosListView(List gastronomicos) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemCount: gastronomicos.length,
          itemBuilder: (BuildContext context, int index) {
            return GastronomicoCardWidget(
                gastronomico: gastronomicos[index], onTap: _onCardTap);
          },
        ),
      ),
    );
  }

  void _onCardTap(BuildContext context, dynamic gastronomico) {
    Navigator.pushNamed(context, GastronomicoDetailScreen.ROUTENAME,
        arguments: gastronomico);
  }
}
