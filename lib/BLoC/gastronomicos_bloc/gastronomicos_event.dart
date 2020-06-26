part of 'gastronomicos_bloc.dart';

abstract class GastronomicosEvent extends Equatable {
  const GastronomicosEvent();

  @override 
  List<Object> get props => [];
}

class GastronomicosFetch extends GastronomicosEvent { }
