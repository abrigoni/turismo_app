import 'package:app/BLoC/alojamientos_bloc/alojamientos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  
  String _busqueda = "";
  TextStyle textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0);
  AlojamientosBloc _alojamientosBloc;

  @override
  Widget build(BuildContext context) {
    _alojamientosBloc = BlocProvider.of<AlojamientosBloc>(context);
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
    _alojamientosBloc.add(AlojamientosSearch(_busqueda));
  }

}