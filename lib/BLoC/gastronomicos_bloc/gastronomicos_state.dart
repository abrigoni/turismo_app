part of 'gastronomicos_bloc.dart';

abstract class GastronomicosState extends Equatable {
  const GastronomicosState();

  @override 
  List<Object> get props => [];
}

class GastronomicosLoadInProgress extends GastronomicosState {}

class GastronomicosLoadSuccess extends GastronomicosState {
  final List<dynamic> gastronomicos; 

  const GastronomicosLoadSuccess({@required this.gastronomicos}) : assert(gastronomicos != null);

  @override 
  List<Object> get props => [gastronomicos];

  @override
  String toString() => 'GastornomicosLoadSuccess { gastronomicos: $gastronomicos}';
}

class GastronomicosLoadFailure extends GastronomicosState {}

