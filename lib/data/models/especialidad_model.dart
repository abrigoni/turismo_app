class Especialidades {
  List<Especialidad> items = new List();
  Especialidades();

  Especialidades.fromJsonList(List<dynamic> jsonList){
    if (jsonList == null) return;
    for (var item in jsonList) {
      Especialidad especialidad = Especialidad.fromJsonMap(item);
      items.add(especialidad);
    }
  }
}


class Especialidad {
  int id;
  String nombre;

  Especialidad({
    this.id,
    this.nombre,
  });

  Especialidad.fromJsonMap(Map<String, dynamic> json) {
    this.id     = json["id"];
    this.nombre = json["nombre"];
  }
}
