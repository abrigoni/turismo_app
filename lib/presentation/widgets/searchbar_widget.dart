import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:app/BLoC/bloc.dart';


class SearchBarWidget extends StatefulWidget {
  final Bloc bloc;
  final String blocType;
  SearchBarWidget({this.bloc, this.blocType});
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  
  String _busqueda = "";
  var _controller = TextEditingController();
  TextStyle textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0);
  AlojamientosBloc _alojamientosBloc;
  GastronomicosBloc _gastronomicosBloc;

  @override
  Widget build(BuildContext context) {
    _alojamientosBloc = BlocProvider.of<AlojamientosBloc>(context);
    _gastronomicosBloc = BlocProvider.of<GastronomicosBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: TextField( 
        controller: _controller,
        style: textStyle,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          hintText: "Buscar",
          prefixIcon: GestureDetector(child: Icon(Icons.clear, color: Colors.white), onTap: onClearTap),
          suffixIcon: GestureDetector(child: Icon(Icons.search, color: Colors.white), onTap: onSearchTap),
          hintStyle: textStyle
        ),
        onChanged: (busqueda){ _busqueda = busqueda; },
      ),
    );
  }

  void onSearchTap() {
    if (widget.blocType == 'alojamiento') 
      widget.bloc.add(AlojamientosSearch(_busqueda));
    else if (widget.blocType == 'gastronomico')
      widget.bloc.add(GastronomicosSearch(_busqueda));
    else {
      var alojamientosState = _alojamientosBloc.state as AlojamientosLoadSuccess;
      var gastronomicosState = _gastronomicosBloc.state as GastronomicosLoadSuccess;
      widget.bloc.add(FavoritosSearch(_busqueda, alojamientosState.alojamientos, gastronomicosState.gastronomicos));
    }
  }

  void onClearTap() {
    _busqueda = "";
    _controller.clear();
    if (widget.blocType == 'alojamiento') 
      widget.bloc.add(AlojamientosSearch(""));
    else if (widget.blocType == 'gastronomico')
      widget.bloc.add(GastronomicosSearch(""));
    else {
      var alojamientosState = _alojamientosBloc.state as AlojamientosLoadSuccess;
      var gastronomicosState = _gastronomicosBloc.state as GastronomicosLoadSuccess;
      widget.bloc.add(FavoritosSearch("", alojamientosState.alojamientos, gastronomicosState.gastronomicos));
    }
    setState((){});
  }
}