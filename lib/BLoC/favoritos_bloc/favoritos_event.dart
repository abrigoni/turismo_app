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
  List<Object> get props => [establecimiento];
}

class FavoritoDelete extends FavoritosEvent {
  final dynamic establecimiento;

  const FavoritoDelete(this.establecimiento);

  @override
  List<Object> get props => [establecimiento];
}

class FavoritoUpdate extends FavoritosEvent {
  final dynamic establecimiento;

  const FavoritoUpdate(this.establecimiento);

  @override
  List<Object> get props => [establecimiento];
}
