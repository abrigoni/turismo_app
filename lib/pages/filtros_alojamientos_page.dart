import 'package:app/models/categoria_model.dart';
import 'package:app/models/clasificacion_model.dart';
import 'package:flutter/material.dart';
import 'package:app/providers/categoria_provider.dart';
import 'package:app/providers/clasificacion_provider.dart';


class FiltrosAlojamientosPage extends StatefulWidget {

  static const String ROUTENAME = 'FiltroAlojamientosPage';
  final ClasificacionProvider clasificacionProvider;
  final CategoriaProvider categoriaProvider;

  FiltrosAlojamientosPage({
    @required this.clasificacionProvider,
    @required this.categoriaProvider,
  });

  @override
  _FiltrosAlojamientosPageState createState() => _FiltrosAlojamientosPageState();
}

class _FiltrosAlojamientosPageState extends State<FiltrosAlojamientosPage> {

  List<Categoria> categorias;
  List<Clasificacion> clasificaciones;

  @override 
  void initState() {
    super.initState();
    getClasificaciones();
    getCategorias();
  }

  void getClasificaciones() async {
    clasificaciones = await widget.clasificacionProvider.getClasificaciones();
    print(clasificaciones[0].nombre);
  }

  void getCategorias() async {
    categorias = await widget.categoriaProvider.getCategorias();
    print(categorias[0].estrellas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtrar alojamientos"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text("Filtro de alojamientos :D")
      )
    );
  }
}