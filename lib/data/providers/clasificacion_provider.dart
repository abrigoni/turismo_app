import './base_provider.dart';
import 'package:app/data/models/models.dart';


class ClasificacionProvider extends BaseProvider {
  
  final String _url = "/clasificaciones";

  ClasificacionProvider();

  Future<List<Clasificacion>> getClasificaciones() async {
    final decodedData = await super.httpGetRequest(_url);
    final clasificaciones = new Clasificaciones.fromJsonList(decodedData);
    return clasificaciones.items;
  }

  Future<Clasificacion> getClasificacionById(int id) async {
    final decodedData = await super.httpGetRequest(_url+"?id=eq.$id");
    final Clasificacion clasificacion = new Clasificacion.fromJsonMap(decodedData[0]);
    return clasificacion;
  }

}