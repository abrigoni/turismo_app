import 'dart:async';
import 'dart:convert';
import 'package:app/BLoC/bloc.dart';
import 'package:app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/data/models/favorito_model.dart';
part 'favoritos_event.dart';
part 'favoritos_state.dart';

class FavoritosBloc extends HydratedBloc<FavoritosEvent, FavoritosState> {
  FavoritosBloc();

  @override
  FavoritosState get initialState {
    return super.initialState ?? FavoritosLoadInProgress();
  }

  @override
  FavoritosState fromJson(Map<String, dynamic> json) {
    try {
      final List favoritos = json['favoritos'];
      return FavoritosLoadSuccess(
        favoritos: favoritos.map((e) => Favorito.fromJson(jsonDecode(e)))
      );
    } catch (_) {
      return FavoritosLoadFailure();
    }
  }

  @override
  Map<String, dynamic> toJson(FavoritosState state) {
    if (state is FavoritosLoadSuccess) {
      return {
        'favoritos': state.favoritos.map((e) => jsonEncode(e.toJson())).toList()
      };
    }
    return null;
  }

  @override
  Stream<FavoritosState> mapEventToState(
    FavoritosEvent event,
  ) async* {
    if (event is FavoritosFetch) {
      yield* _mapFavoritosFetchToState();
    }
    if (event is FavoritoCreate) {
      yield* _mapFavoritoCreateToState(event.establecimiento, event.esAlojamiento);
    }
    if (event is FavoritosSearch) {
      yield* _mapFavoritosSearchToState(event.search, event.alojamientos, event.gastronomicos);
    }
    if (event is FavoritoUpdate) {
      yield* _mapFavoritoUpdateToState(event.establecimiento, event.esAlojamiento, event.image, event.borrado);
    }
    if (event is FavoritoDelete) {
      yield* _mapFavoritoDeleteToState(event.establecimiento, event.esAlojamiento);
    }
  }

  Stream<FavoritosState> _mapFavoritosFetchToState() async* {
    try {
      final List<Favorito> favoritos = [];
      yield FavoritosLoadSuccess(favoritos: favoritos);
    } catch (_) {
      yield FavoritosLoadFailure();
    }
  }

  Stream<FavoritosState> _mapFavoritoCreateToState(dynamic establecimiento, bool esAlojamiento) async* {
    yield FavoritosLoadInProgress();
    try {
      var _state = state as FavoritosLoadSuccess;
      List<Favorito> favoritos = []..addAll(_state.favoritos);
      Favorito favorito = Favorito(establecimientoId: establecimiento.id, esAlojamiento: esAlojamiento, recuerdos: []);
      favoritos.add(favorito);
      yield FavoritosLoadSuccess(favoritos: favoritos);
    } catch(_) {
      yield FavoritosLoadFailure();
    }
  }

  Stream<FavoritosState> _mapFavoritosSearchToState(String search, List<Alojamiento> alojamientos, List<Gastronomico> gastronomicos) async* {
    yield FavoritosLoadInProgress();
    try {
      var _state = state as FavoritosLoadSuccess;
      List<Favorito> favoritos = []..addAll(_state.favoritos);
      favoritos.forEach((favorito) {
        if (favorito.esAlojamiento) {
          if (alojamientos.firstWhere((alojamiento) => alojamiento.id == favorito.establecimientoId).nombre.toLowerCase().contains(search.toLowerCase())) {
            favorito.visible = true;
          } else {
            favorito.visible = false;
          }
        } else {
          if (gastronomicos.firstWhere((gastronomico) => gastronomico.id == favorito.establecimientoId).nombre.toLowerCase().contains(search.toLowerCase())) {
            favorito.visible = true;
          } else {
            favorito.visible = false;
          }
        }
      });
      yield FavoritosLoadSuccess(favoritos: favoritos);
    } catch(_) {
      yield FavoritosLoadFailure();
    }
  }

  Stream<FavoritosState> _mapFavoritoUpdateToState(dynamic establecimiento, bool esAlojamiento, String image, bool borrado) async* {
    yield FavoritosLoadInProgress();
    try {
      var _state = state as FavoritosLoadSuccess;
      List<Favorito> favoritos = []..addAll(_state.favoritos);
      var favorito = favoritos.firstWhere((element) => element.esAlojamiento == esAlojamiento && element.establecimientoId == establecimiento.id);
      if (borrado) {
        favorito.recuerdos.remove(image);
      } else {
        favorito.recuerdos.add(image);
      }
      yield FavoritosLoadSuccess(favoritos: favoritos);
    } catch(_) {
      yield FavoritosLoadFailure();
    }
  }

  Stream<FavoritosState> _mapFavoritoDeleteToState(dynamic establecimiento, bool esAlojamiento) async* {
    yield FavoritosLoadInProgress();
    try {
      var _state = state as FavoritosLoadSuccess;
      List<Favorito> favoritos = []..addAll(_state.favoritos);
      favoritos.removeWhere((element) => element.esAlojamiento == esAlojamiento && element.establecimientoId == establecimiento.id);
      yield FavoritosLoadSuccess(favoritos: favoritos);
    } catch(_) {
      yield FavoritosLoadFailure();
    }
  }
}
