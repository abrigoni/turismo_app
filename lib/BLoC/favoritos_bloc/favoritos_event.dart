part of 'favoritos_bloc.dart';

abstract class FavoritosEvent extends Equatable {
  const FavoritosEvent();
}

class FavoritosFetch extends FavoritosEvent {
  const FavoritosFetch();

  @override
  List<Object> get props => [];
}

class FavoritoCreate extends FavoritosEvent {
  final dynamic establecimiento;
  final bool esAlojamiento;

  const FavoritoCreate({@required this.establecimiento, @required this.esAlojamiento});

  @override
  List<Object> get props => [establecimiento, esAlojamiento];
}

class FavoritosSearch extends FavoritosEvent {
  final String search; 
  final List<Alojamiento> alojamientos;
  final List<Gastronomico> gastronomicos;

  FavoritosSearch(this.search, this.alojamientos, this.gastronomicos);

  @override 
  List<Object> get props => [search];
}

class FavoritoUpdate extends FavoritosEvent {
  final dynamic establecimiento;
  final bool esAlojamiento;
  final String image;
  final bool borrado;

  const FavoritoUpdate({@required this.establecimiento, @required this.esAlojamiento, @required this.image, @required this.borrado});

  @override
  List<Object> get props => [establecimiento, esAlojamiento];
}

class FavoritoDelete extends FavoritosEvent {
  final dynamic establecimiento;
  final bool esAlojamiento;

  const FavoritoDelete({@required this.establecimiento, @required this.esAlojamiento});

  @override
  List<Object> get props => [establecimiento, esAlojamiento];
}
