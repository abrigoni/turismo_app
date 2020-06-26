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
  }


  Stream<AlojamientosState> _mapAlojamientosFetchToState() async* {
    try {
      final alojamientos = await this.alojamientoRepository.getAll();
      yield AlojamientosLoadSuccess(alojamientos: alojamientos);
    } catch (_) {
      yield AlojamientosLoadFailure();
    }
  }


}