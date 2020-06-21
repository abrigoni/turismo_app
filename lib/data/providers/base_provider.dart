import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseProvider {
  final String _baseUrl = "http://192.168.1.36:3000";


  dynamic httpGetRequest(String request) async {
    final resp = await http.get(_baseUrl+request);
    return json.decode(resp.body);
  }
}