import 'dart:async';
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
  }

  Stream<GastronomicosState> _mapGastronomicosFetchToState() async* {
    try {
      final gastronomicos = await this.gastronomicoRepository.getAll();
      yield GastronomicosLoadSuccess(gastronomicos: gastronomicos);
    } catch (_) {
      yield GastronomicosLoadFailure();
    }
  }
}
