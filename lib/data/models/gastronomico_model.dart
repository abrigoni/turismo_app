import 'package:equatable/equatable.dart';

class Gastronomicos {
  List<Gastronomico> items = new List();

  Gastronomicos();

  Gastronomicos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final gastronomico = Gastronomico.fromJsonMap(item);
      items.add(gastronomico);
    }
  }
}


class Gastronomico extends Equatable {
  int id;
  String nombre;
  String domicilio;
  double lat;
  double lng;
  String foto;
  int localidadId;
  dynamic especialidades;
  dynamic actividades;
  dynamic localidad;
  bool visible = true; // para filtrado

  Gastronomico({
    this.id,
    this.nombre,
    this.domicilio,
    this.lat,
    this.lng,
    this.foto,
    this.localidadId,
    this.especialidades,
    this.actividades,
    this.localidad
  });

  Gastronomico.fromJsonMap(Map<String, dynamic> json) {
    this.id               = json["id"];
    this.nombre           = json["nombre"];
    this.domicilio        = json["domicilio"];
    this.lat              = json["lat"];
    this.lng              = json["lng"];
    this.foto             = json["foto"];
    this.localidadId      = json["localidad_id"];
    this.localidad        = json["localidad"];
    this.especialidades   = json["especialidades"];
    this.actividades      = json["actividades"];
  }

  @override
  List<Object> get props => [id] ;

}
