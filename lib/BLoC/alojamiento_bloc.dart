import 'dart:async';
import 'package:app/data/repositories/alojamiento_repository.dart';
import 'package:bloc/bloc.dart';
import './alojamiento_event.dart';
import './alojamiento_state.dart';


class AlojamientosBloc extends Bloc<AlojamientosEvent, AlojamientosState> {

  final AlojamientoRepository alojamientoRepository;

  AlojamientosBloc({this.alojamientoRepository});

  @override
  get initialState => AlojamientosLoadInProgress();

  @override
  Stream<AlojamientosState> mapEventToState(AlojamientosEvent event) async* {
    if (event is AlojamientosLoaded) {
      yield* _mapAlojamientosLoadedToState();
    }
  }


  Stream<AlojamientosState> _mapAlojamientosLoadedToState() async* {
    try {
      final alojamientos = await this.alojamientoRepository.getAll();
      yield AlojamientosLoadSuccess(alojamientos: alojamientos);
    } catch (_) {
      yield AlojamientosLoadFailure();
    }
  }


}