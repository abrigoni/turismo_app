import 'package:app/providers/base_provider.dart';
import 'package:app/models/alojamiento_model.dart';



class AlojamientoProvider extends BaseProvider {

  String _url = '/alojamientos';

  AlojamientoProvider();

  Future<List<Alojamiento>> getAlojamientos() async {
    final decodedData = await super.httpGetRequest(_url);
    final alojamientos = new Alojamientos.fromJsonList(decodedData);
    return alojamientos.items;
  }

}