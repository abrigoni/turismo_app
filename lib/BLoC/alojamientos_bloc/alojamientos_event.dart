part of 'alojamientos_bloc.dart';

abstract class AlojamientosEvent extends Equatable {
  const AlojamientosEvent();

  @override
  List<Object> get props => [];
}

class AlojamientosFetch extends AlojamientosEvent { }

class AlojamientosFilter extends AlojamientosEvent { 
  final Map<String, List<int>> filtros;

  AlojamientosFilter(this.filtros);

  @override
  List<Object> get props => [filtros];
}

