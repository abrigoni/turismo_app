import 'package:flutter/material.dart';



class GastronomicoCardWidget extends StatelessWidget {

  final gastronomico;

  GastronomicoCardWidget({this.gastronomico});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Gastronomico Card"),
                SizedBox(width:10.0),
              ],
            ),
            Divider()
          ],
        )
      ),
    );
  }


}