import 'package:app/BLoC/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


class SearchBarWidget extends StatefulWidget {
  final Bloc bloc;
  final String blocType;
  SearchBarWidget({this.bloc, this.blocType});
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  
  String _busqueda = "";
  TextStyle textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: TextField( 
        style: textStyle,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          hintText: "Buscar",
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
    else 
      widget.bloc.add(GastronomicosSearch(_busqueda));
  }

}