part of 'alojamientos_bloc.dart';

abstract class AlojamientosEvent extends Equatable {
  const AlojamientosEvent();

  @override
  List<Object> get props => [];
}

class AlojamientosFetch extends AlojamientosEvent { }

