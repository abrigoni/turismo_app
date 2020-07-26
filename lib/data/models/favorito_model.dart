import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';


class Favorito extends Equatable {
  int establecimientoId;
  bool esAlojamiento; /* si no es alojamiento es gastr */
  List<String> recuerdos;
  bool visible = true;

  Favorito({@required this.establecimientoId, this.esAlojamiento, this.recuerdos});

  @override
  List<Object> get props => [establecimientoId, esAlojamiento, recuerdos];

  Favorito.fromJsonMap(Map<String, dynamic> json) {
    this.establecimientoId  = json["establecimientoId"];
    this.esAlojamiento      = json["esAlojamiento"];
    this.recuerdos          = json["recuerdos"];
  }

  factory Favorito.fromJson(Map<String, dynamic> json) => Favorito(
    establecimientoId: json['establecimientoId'],
    esAlojamiento: json['esAlojamiento'],
    recuerdos: jsonDecode(json['recuerdos']).map<String>((e) => e.toString()).toList() 
  );

  Map<String, dynamic> toJson() => {
    'establecimientoId': establecimientoId,
    'esAlojamiento': esAlojamiento,
    'recuerdos': jsonEncode(recuerdos),
  };

}