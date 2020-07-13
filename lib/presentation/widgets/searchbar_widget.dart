import 'package:flutter/material.dart';


class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  
  String _busqueda;
  TextStyle textStyle;
  final controller = TextEditingController();

  _SearchBarWidgetState() {
    this._busqueda = "";
    this.textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: TextField( 
        controller: controller,
        style: textStyle,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          hintText: "Buscar",
          suffixIcon: Icon(Icons.search, color: Colors.white),
          hintStyle: textStyle
        ),
        onChanged: (busqueda){ _busqueda = busqueda; },
      ),
    );
  }
}