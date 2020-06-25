import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:app/data/models/alojamiento_model.dart';

abstract class AlojamientosState extends Equatable {
  const AlojamientosState();

  @override 
  List<Object> get props => [];
}

class AlojamientosLoadInProgress extends AlojamientosState {}

class AlojamientosLoadSuccess extends AlojamientosState {
  final List<Alojamiento> alojamientos;

  const AlojamientosLoadSuccess({@required this.alojamientos}) : assert(alojamientos != null);

  @override 
  List<Object> get props => [alojamientos];

  @override 
  String toString() => 'AlojamientosLoadSuccess { alojamientos: $alojamientos }';
}

class AlojamientosLoadFailure extends AlojamientosState {}
