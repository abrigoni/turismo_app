import 'package:flutter/material.dart';


class FilterChipWidget extends StatefulWidget {
  
  final String chipName;

  FilterChipWidget({Key key, this.chipName});

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {

  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      avatar: CircleAvatar(
              backgroundColor: Color(0xFF18C5C1),
              child: Text(widget.chipName[0],
                style: TextStyle(color: Colors.white))),
      onSelected: (value){
        setState(() {
          _isSelected = value;
        });
      },
      selected: _isSelected,
    );
  }
}