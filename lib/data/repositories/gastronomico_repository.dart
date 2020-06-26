import 'package:app/data/providers/gastronomico_provider.dart';

class GastronomicoRepository {
  final GastronomicoProvider _gastronomicoProvider;

  GastronomicoRepository({GastronomicoProvider gastronomicoProvider})
  : _gastronomicoProvider = gastronomicoProvider ?? GastronomicoProvider.create();

  Future<List<dynamic>> getAll() async {
    final gastronomicos = await _gastronomicoProvider.getAll();
    return gastronomicos;
  }
}