import 'package:equatable/equatable.dart';

class Alojamientos {
  List<Alojamiento> items = new List();

  Alojamientos();

  Alojamientos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final alojamiento = Alojamiento.fromJsonMap(item);
      items.add(alojamiento);
    }
  }
}


class Alojamiento extends Equatable {
  int id;
  String nombre;
  String domicilio;
  double lat;
  double lng;
  String foto;
  int clasificacionId;
  int categoriaId;
  int localidadId;
  bool visible = true; // para filtrado

  Alojamiento({
    this.id,
    this.nombre,
    this.domicilio,
    this.lat,
    this.lng,
    this.foto,
    this.clasificacionId,
    this.categoriaId,
    this.localidadId,
  });

  Alojamiento.fromJsonMap(Map<String, dynamic> json) {
    this.id               = json["id"];
    this.nombre           = json["nombre"];
    this.domicilio        = json["domicilio"];
    this.lat              = json["lat"];
    this.lng              = json["lng"];
    this.foto             = json["foto"];
    this.clasificacionId  = json["clasificacion_id"];
    this.categoriaId      = json["categoria_id"];
    this.localidadId      = json["localidad_id"];
  }

  @override
  List<Object> get props => [id] ;

}
