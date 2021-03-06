import 'package:flutter/material.dart';


class FilterChipWidget extends StatefulWidget {
  
  final dynamic chipInfo;
  final Color primaryColor;
  final Function updateSelecteds;

  FilterChipWidget({Key key, this.chipInfo, this.primaryColor, this.updateSelecteds});

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {

  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: FilterChip(
        label: Text(widget.chipInfo["name"]),
        labelStyle: TextStyle(color: _isSelected ? Colors.white : widget.primaryColor,fontSize: 16.0,fontWeight: FontWeight.bold),
        selected: _isSelected,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        backgroundColor: Color(0xffededed),
        onSelected: (isSelected) {
          setState(() {
            _isSelected = isSelected;
          });
          widget.updateSelecteds(widget.chipInfo["id"]);
        },
        checkmarkColor: Colors.white,
        selectedColor: widget.primaryColor,
      ),
    );
  }
}