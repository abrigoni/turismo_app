import 'package:flutter/material.dart';

class CustomNavBarWidget extends StatefulWidget {

  final List<IconData> icons;
  final Function(int) onPressed;
  final int activeIndex;

  const CustomNavBarWidget({@required this.icons, @required this.onPressed, @required this.activeIndex}) : assert(icons != null);



  @override
  _CustomNavBarWidgetState createState() => _CustomNavBarWidgetState();
}

class _CustomNavBarWidgetState extends State<CustomNavBarWidget> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          for (var i = 0; i<widget.icons.length; i++) 
            IconButton(
              icon: Icon(widget.icons[i]),
              color: i == widget.activeIndex? Colors.yellow[700] : Colors.black, 
              onPressed: () => widget.onPressed(i),
            )
        ],
      )
    );
  }
}