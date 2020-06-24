import 'package:app/data/models/alojamiento_model.dart';
import 'package:app/data/providers/alojamiento_provider.dart';

class AlojamientoRepository {
  final AlojamientoProvider _alojamientoProvider;

  AlojamientoRepository({AlojamientoProvider alojamientoProvider})
  : _alojamientoProvider = alojamientoProvider ?? AlojamientoProvider();

  Future<List<Alojamiento>> getAll() async {
    final alojamientos = await _alojamientoProvider.getAlojamientos();
    return alojamientos;
  }
}