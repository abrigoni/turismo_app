class Actividades {
  List<Actividad> items = new List();
  Actividades();

  Actividades.fromJsonList(List<dynamic> jsonList){
    if (jsonList == null) return;
    for (var item in jsonList) {
      Actividad actividad = Actividad.fromJsonMap(item);
      items.add(actividad);
    }
  }
}


class Actividad {
  int id;
  String nombre;

  Actividad({
    this.id,
    this.nombre,
  });

  Actividad.fromJsonMap(Map<String, dynamic> json) {
    this.id     = json["id"];
    this.nombre = json["nombre"];
  }
}
