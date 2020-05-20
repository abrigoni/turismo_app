import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/providers/urls.dart';
import 'package:app/models/clasificacion_model.dart';


class ClasificacionProvider {
  
  final String _url = "/clasificaciones";

  ClasificacionProvider();

  Future<List<Clasificacion>> getClasificaciones() async {
    final resp = await http.get(restApi+_url);
    final decodedData = json.decode(resp.body);
    final clasificaciones = new Clasificaciones.fromJsonList(decodedData);
    return clasificaciones.items;
  }
  // TODO: ClasificacionById


}