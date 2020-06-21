import './base_provider.dart';
import 'package:app/data/models/models.dart';


class CategoriaProvider extends BaseProvider {

  final String _url = "/categorias";

  CategoriaProvider();

  Future<List<Categoria>> getCategorias() async {
    final decodedData = await super.httpGetRequest(_url);
    final clasificaciones = new Categorias.fromJsonList(decodedData);
    return clasificaciones.items;
  }

  Future<Categoria> getcategoriaById(int id) async {
    final decodedData = await super.httpGetRequest(_url+"?id=eq.$id");
    final Categoria categoria = new Categoria.fromJsonMap(decodedData[0]);
    return categoria;
  }

}