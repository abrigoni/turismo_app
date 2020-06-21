import 'dart:async';
import 'package:bloc/bloc.dart';
import './alojamiento_event.dart';
import './alojamiento_state.dart';
import 'package:app/data/providers/alojamiento_provider.dart';



class AlojamientoBloc extends Bloc<AlojamientoEvent, AlojamientoState> {

  final AlojamientoProvider alojamientoProvider;

  AlojamientoBloc({this.alojamientoProvider});

  @override
  get initialState => AlojamientoInitial();

  @override
  Stream<AlojamientoState> mapEventToState(AlojamientoEvent event) async* {
    final currentState = state;
    if (event is FetchAlojamientos) {
      try {
        if (currentState is AlojamientoInitial) {
          final alojamientos = await alojamientoProvider.getAlojamientos();
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