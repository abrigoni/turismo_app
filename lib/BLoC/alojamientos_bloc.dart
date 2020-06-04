import 'dart:async';
import 'package:app/BLoC/bloc.dart';
import 'package:app/models/alojamiento_model.dart';
import 'package:app/providers/alojamiento_provider.dart';

class AlojamientosBloc implements Bloc {

  static final AlojamientosBloc _singleton = new AlojamientosBloc._internal();

  factory AlojamientosBloc() {
    return _singleton;
  }


  AlojamientosBloc._internal() {
    obtenerAlojamientos();
  }

  final _alojamientosController = new StreamController<List<Alojamiento>>.broadcast();

  Stream<List<Alojamiento>> get alojamientosStream => _alojamientosController.stream;

  @override
  void dispose() {
    _alojamientosController?.close();
  }

  obtenerAlojamientos() async {
    _alojamientosController.sink.add( await AlojamientoProvider().getAlojamientos() );
  }

  filtrarAlojamientos() async {
    // @ TODO
  }

}