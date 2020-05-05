import 'package:flutter/material.dart';
import 'package:turismoapp/models/alojamiento_model.dart';



class GastronomicoListContainerWidget extends StatelessWidget {

  final List<dynamic> items;

  GastronomicoListContainerWidget({this.items});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(54), topRight: Radius.circular(54)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 20.0),
        ]
      ),
      child: _renderizarLista(items)
      
    );
  }

  Widget _renderizarLista(List<Alojamiento> items) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final alojamiento = items[index]; 
          return Text(alojamiento.nombre);
        }
    );
  }
}