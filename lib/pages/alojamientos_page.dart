import 'package:flutter/material.dart';
import 'package:turismoapp/widgets/list_container_widget.dart';

class AlojamientosPage extends StatelessWidget {
  static const String ROUTENAME = 'Alojamientos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4EAEFB),
      body: SafeArea( 
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 180.0, 
            child: Text("Alojamientos")
          ), 
          Expanded(
            child: ListContainerWidget(),
          )
          
        ],
        )
      )
    );
  }

}
