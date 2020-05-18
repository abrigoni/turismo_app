import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/models/alojamiento_model.dart';
import 'package:app/providers/urls.dart';


class AlojamientoProvider{

  String _url = '/alojamientos';

  AlojamientoProvider();

  Future<List<Alojamiento>> getAlojamientos() async {
    final resp = await http.get(restApi+_url);
    final decodedData = json.decode(resp.body);
    final alojamientos = new Alojamientos.fromJsonList(decodedData);
    return alojamientos.items;
  }

}