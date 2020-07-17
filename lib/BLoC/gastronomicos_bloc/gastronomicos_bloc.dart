import 'dart:async';
import 'package:app/data/models/gastronomico_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:app/data/repositories/gastronomico_repository.dart';
part 'gastronomicos_event.dart';
part 'gastronomicos_state.dart';


class GastronomicosBloc extends Bloc<GastronomicosEvent, GastronomicosState> {

  final GastronomicoRepository gastronomicoRepository;

  GastronomicosBloc({this.gastronomicoRepository});

  @override
  GastronomicosState get initialState => GastronomicosLoadInProgress();

  @override
  Stream<GastronomicosState> mapEventToState(
    GastronomicosEvent event,
  ) async* {
    if (event is GastronomicosFetch) {
      yield* _mapGastronomicosFetchToState();
    }
    if (event is GastronomicosFilter) {
      yield* _mapGastronomicosFilterToState(event.filtros);
    }
    if (event is GastronomicosSearch) {
      yield* _mapGastronomicosSearchToState(event.search);
    }
  }

  Stream<GastronomicosState> _mapGastronomicosFetchToState() async* {
    try {
      final gastronomicos = await this.gastronomicoRepository.getAll();
      yield GastronomicosLoadSuccess(gastronomicos: gastronomicos);
    } catch (_) {
      yield GastronomicosLoadFailure();
    }
  }

  Stream<GastronomicosState> _mapGastronomicosFilterToState(Map<String, List<int>> filtros) async* {
    print(filtros);
  }

  Stream<GastronomicosState> _mapGastronomicosSearchToState(String search) async* {
    yield GastronomicosLoadInProgress();
    try {
      final _state = state as GastronomicosLoadSuccess;
      List<Gastronomico> gastronomicos = []..addAll(_state.gastronomicos);
      gastronomicos.forEach((gastronomico) {
        if (search.isEmpty || gastronomico.nombre.toLowerCase().contains(search.toLowerCase()))
          gastronomico.visible = true;
        else 
          gastronomico.visible = false;
      });

      yield GastronomicosLoadSuccess(gastronomicos: gastronomicos);
    } catch(_){
      yield GastronomicosLoadFailure();
    }
  }
}
