import 'package:flutter/material.dart';


class FilterChipWidget extends StatefulWidget {
  
  final String chipName;
  final Color primaryColor;

  FilterChipWidget({Key key, this.chipName, this.primaryColor});

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {

  var _isSelected = false;

  @override
  Widget build(BuildContext context) {

    
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: _isSelected ? Colors.white : widget.primaryColor,fontSize: 16.0,fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30.0),),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      checkmarkColor: Colors.white,
      selectedColor: widget.primaryColor,
    );
  }
}