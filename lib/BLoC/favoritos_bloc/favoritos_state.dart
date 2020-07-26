part of 'favoritos_bloc.dart';

abstract class FavoritosState extends Equatable {

  const FavoritosState();

  @override
  List<Object> get props => [];
}

class FavoritosLoadInProgress extends FavoritosState {}

class FavoritosLoadSuccess extends FavoritosState {
  final List<Favorito> favoritos;

  const FavoritosLoadSuccess({@required this.favoritos}) : assert(favoritos != null); 

  @override
  List<Object> get props => [favoritos];
}


class FavoritosLoadFailure extends FavoritosState {}