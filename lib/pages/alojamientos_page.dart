import 'package:flutter/material.dart';
import 'package:turismoapp/widgets/list_container_widget.dart';
import 'package:turismoapp/widgets/searchbar_widget.dart';

class AlojamientosPage extends StatelessWidget {
  static const String ROUTENAME = 'Alojamientos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _crearAppBar(),
      backgroundColor: Color(0xFF4EAEFB),
      body: SafeArea( 
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 20.0, 
          ),
          SearchBarWidget(),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListContainerWidget(),
          )
          
        ],
        )
      )
    );
  }

  Widget _crearAppBar() {
    return AppBar(
        backgroundColor: Color(0xFF4EAEFB), 
        title: Text("Alojamientos"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.filter_list), onPressed: (){}),
        ],
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.map), onPressed: (){}),
    );
  }


}
