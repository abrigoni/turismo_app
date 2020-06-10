import 'package:equatable/equatable.dart';


abstract class AlojamientoEvent extends Equatable {
  const AlojamientoEvent();
  @override 
  List<Object> get props => [];
}

class FetchAlojamientos extends AlojamientoEvent {
}

