import 'package:flutter/material.dart';



class ListContainerWidget extends StatelessWidget {



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
      )
    );
  }
}