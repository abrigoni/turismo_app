import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turismoapp/providers/base_provider.dart';
import 'package:turismoapp/models/alojamiento_model.dart';



class AlojamientoProvider extends BaseProvider {

  String _url = '/alojamientos';


  Future<List<Alojamiento>> getAlojamientos() async {
    final resp = await http.get(baseUrl+_url);
    final decodedData = json.decode(resp.body);
    final alojamientos = new Alojamientos.fromJsonList(decodedData);

    return alojamientos.items;
  }

}