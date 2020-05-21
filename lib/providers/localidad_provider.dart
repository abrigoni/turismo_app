import 'package:app/providers/base_provider.dart';
import 'package:app/models/localidad_model.dart';


class LocalidadProvider extends BaseProvider {
  
  final String _url = "/localidades";

  LocalidadProvider();

  Future<List<Localidad>> getLocalidades() async {
    final decodedData = await super.httpGetRequest(_url);
    final localidades = new Localidades.fromJsonList(decodedData);
    return localidades.items;
  }

  Future<Localidad> getLocalidadById(int id) async {
    final decodedData = await super.httpGetRequest(_url+"?id=eq.$id");
    final Localidad localidad = new Localidad.fromJsonMap(decodedData[0]);
    return localidad;
  }

}