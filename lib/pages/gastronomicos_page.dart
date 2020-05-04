import 'package:flutter/material.dart';
import 'package:turismoapp/widgets/list_container_widget.dart';

class GastronomicosPage extends StatelessWidget {
  static const String ROUTENAME = 'Gastronomicos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0AD5F),
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
