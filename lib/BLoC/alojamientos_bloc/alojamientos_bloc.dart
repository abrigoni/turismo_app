import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:app/data/models/alojamiento_model.dart';
import 'package:app/data/repositories/alojamiento_repository.dart';

part 'alojamientos_event.dart';
part 'alojamientos_state.dart';


class AlojamientosBloc extends Bloc<AlojamientosEvent, AlojamientosState> {

  final AlojamientoRepository alojamientoRepository;

  AlojamientosBloc({this.alojamientoRepository});

  @override
  get initialState => AlojamientosLoadInProgress();

  @override
  Stream<AlojamientosState> mapEventToState(AlojamientosEvent event) async* {
    if (event is AlojamientosFetch) {
      yield* _mapAlojamientosFetchToState();
    }
    if (event is AlojamientosFilter) {
      yield* _mapAlojamientosFilterToState(event.filtros);
    }
  }


  Stream<AlojamientosState> _mapAlojamientosFetchToState() async* {
    try {
      final alojamientos = await this.alojamientoRepository.getAll();
      yield AlojamientosLoadSuccess(alojamientos: alojamientos);
    } catch (_) {
      yield AlojamientosLoadFailure();
    }
  }

  Stream<AlojamientosState> _mapAlojamientosFilterToState(Map<String, List<int>> filtros) async* {
    try {
      final _state = state as AlojamientosLoadSuccess;
      List<Alojamiento> alojamientos = []..addAll(_state.alojamientos);
      alojamientos.forEach((alojamiento) {
        if ((filtros["localidades"].any((element) => element == alojamiento.localidadId) ||
            filtros["categorias"].any((element) => element == alojamiento.categoriaId) ||
            filtros["clasificaciones"].any((element) => element == alojamiento.clasificacionId)) || 
            (filtros["localidades"].isEmpty && filtros["categorias"].isEmpty && filtros["localidades"].isEmpty) ) {
            alojamiento.visible = true;
          }
          else {
            alojamiento.visible = false;
          }
          return alojamiento;
      });
      yield AlojamientosLoadInProgress();
      yield AlojamientosLoadSuccess(alojamientos: alojamientos);
    } catch(_) {
      yield AlojamientosLoadFailure();
    }
  }


}