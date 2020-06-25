import 'package:equatable/equatable.dart';

abstract class AlojamientosEvent extends Equatable {
  const AlojamientosEvent();

  @override
  List<Object> get props => [];
}

class AlojamientosLoaded extends AlojamientosEvent { }

