import 'package:app/models/alojamiento_model.dart';
import 'package:equatable/equatable.dart';

abstract class AlojamientoState extends Equatable {
  const AlojamientoState(); 

  @override 
  List<Object> get props => [];
}

class AlojamientoInitial extends AlojamientoState {}

class AlojamientoFailure extends AlojamientoState {}

class AlojamientoSuccess extends AlojamientoState {

  final List<Alojamiento> alojamientos; 

  const AlojamientoSuccess({this.alojamientos}) : assert(alojamientos != null);

  AlojamientoSuccess copyWith({
    List<Alojamiento> alojamientos,
  }) {
    return AlojamientoSuccess(
      alojamientos: alojamientos ?? this.alojamientos
    );
  }

  @override
  List<Object> get props => [alojamientos];

}
