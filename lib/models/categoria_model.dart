class Categorias {
  List<Categoria> items = new List(); 
  Categorias();

  Categorias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final categoria = Categoria.fromJsonMap(item);
      items.add(categoria);
    }
  }
}

class Categoria {
  int id;
  String estrellas;
  int valor;

  Categoria({
    this.id,
    this.estrellas,
    this.valor,
  });

  Categoria.fromJsonMap(Map<String, dynamic> json) {
    this.id           = json["id"];
    this.estrellas    = json["estrellas"];
    this.valor        = json["valor"];
  }
}
