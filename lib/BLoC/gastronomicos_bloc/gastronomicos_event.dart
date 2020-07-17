part of 'gastronomicos_bloc.dart';

abstract class GastronomicosEvent extends Equatable {
  const GastronomicosEvent();

  @override 
  List<Object> get props => [];
}

class GastronomicosFetch extends GastronomicosEvent { }


class GastronomicosFilter extends GastronomicosEvent { 
  final Map<String, List<int>> filtros;

  GastronomicosFilter(this.filtros);

  @override
  List<Object> get props => [filtros];
}


class GastronomicosSearch extends GastronomicosEvent { 
  final String search;

  GastronomicosSearch(this.search);

  @override
  List<Object> get props => [search];

}
