import 'dart:async';
import 'package:app/data/repositories/alojamiento_repository.dart';
import 'package:bloc/bloc.dart';
import './alojamiento_event.dart';
import './alojamiento_state.dart';


class AlojamientoBloc extends Bloc<AlojamientoEvent, AlojamientoState> {

  final AlojamientoRepository alojamientoRepository;

  AlojamientoBloc({this.alojamientoRepository});

  @override
  get initialState => AlojamientoInitial();

  @override
  Stream<AlojamientoState> mapEventToState(AlojamientoEvent event) async* {
    final currentState = state;
    if (event is FetchAlojamientos) {
      try {
        if (currentState is AlojamientoInitial) {
          print("Alojamiento Initial");
          final alojamientos = await alojamientoRepository.getAll();
          yield AlojamientoSuccess(alojamientos: alojamientos);
          return;
        }
        // if (currentState is AlojamientoSuccess) {
        //   final alojamientos = await _fetchAlojamientos(currentState.alojamientos.length, 20);
        //   yield AlojamientoSuccess(
        //     alojamientos: currentState.alojamientos + alojamientos,
        //   );
        // }
      } catch (_) {
        yield AlojamientoFailure();
      }
    }
  }


}