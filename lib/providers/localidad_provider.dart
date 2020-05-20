import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/providers/urls.dart';
import 'package:app/models/localidad_model.dart';


class LocalidadProvider {
  
  final String _url = "/localidades";

  LocalidadProvider();

  Future<List<Localidad>> getLocalidades() async {
    final resp = await http.get(restApi+_url);
    final decodedData = json.decode(resp.body);
    final localidades = new Localidades.fromJsonList(decodedData);
    return localidades.items;
  }

  Future<Localidad> getLocalidadById(int id) async {
    final resp = await http.get(restApi+_url+"?id=eq.$id");
    final decodedData = json.decode(resp.body);
    final Localidad localidad = new Localidad.fromJsonMap(decodedData[0]);
    return localidad;
  }

}