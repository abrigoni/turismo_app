class Clasificaciones {
  List<Clasificacion> items = new List();
  Clasificaciones();

  Clasificaciones.fromJsonList(List<dynamic> jsonList){
    if (jsonList == null) return;
    for (var item in jsonList) {
      Clasificacion clasificacion = Clasificacion.fromJsonMap(item);
      items.add(clasificacion);
    }
  }
}


class Clasificacion {
  int id;
  String nombre;

  Clasificacion({
    this.id,
    this.nombre,
  });

  Clasificacion.fromJsonMap(Map<String, dynamic> json) {
    this.id     = json["id"];
    this.nombre = json["nombre"];
  }
}
