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
    if (event is AlojamientosSearch) {
      yield *_mapAlojamientosSearchToState(event.search);
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
    yield AlojamientosLoadInProgress();
    try {
      final _state = state as AlojamientosLoadSuccess;
      List<Alojamiento> alojamientos = []..addAll(_state.alojamientos);
      alojamientos.forEach((alojamiento) {
        if ((filtros["localidades"].contains(alojamiento.localidadId) ||
            filtros["categorias"].contains(alojamiento.categoriaId) ||
            filtros["clasificaciones"].contains(alojamiento.clasificacionId)) || 
            (filtros["localidades"].isEmpty && filtros["categorias"].isEmpty && filtros["localidades"].isEmpty) ) {
            alojamiento.visible = true;
          }
          else {
            alojamiento.visible = false;
          }
      });
      yield AlojamientosLoadSuccess(alojamientos: alojamientos);
    } catch(_) {
      yield AlojamientosLoadFailure();
    }
  }


  Stream<AlojamientosState> _mapAlojamientosSearchToState(String search) async* {
    yield AlojamientosLoadInProgress();
    try {
      final _state = state as AlojamientosLoadSuccess;
      List<Alojamiento> alojamientos = []..addAll(_state.alojamientos);
      alojamientos.forEach((alojamiento) {
        if (search.isEmpty || alojamiento.nombre.toLowerCase().contains(search.toLowerCase())) {
            alojamiento.visible = true;
          }
          else {
            alojamiento.visible = false;
          }
      });
      yield AlojamientosLoadSuccess(alojamientos: alojamientos);
    } catch(_) {
      yield AlojamientosLoadFailure();
    }
  }


}