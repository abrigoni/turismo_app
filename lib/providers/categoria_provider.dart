import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/providers/urls.dart';
import 'package:app/models/categoria_model.dart';


class CategoriaProvider {

  final String _url = "/categorias";

  CategoriaProvider();

  Future<List<Categoria>> getCategorias() async {
    final resp = await http.get(restApi+_url);
    final decodedData = json.decode(resp.body);
    final clasificaciones = new Categorias.fromJsonList(decodedData);
    return clasificaciones.items;
  }

  // TODO: CategoriaById

}