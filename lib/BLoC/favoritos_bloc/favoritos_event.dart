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

class FavoritoUpdate extends FavoritosEvent {
  final dynamic establecimiento;
  final bool esAlojamiento;

  const FavoritoUpdate({@required this.establecimiento, @required this.esAlojamiento});

  @override
  List<Object> get props => [establecimiento, esAlojamiento];
}

class FavoritoDelete extends FavoritosEvent {
  final Favorito favorito;

  const FavoritoDelete({@required this.favorito});

  @override
  List<Object> get props => [favorito];
}
