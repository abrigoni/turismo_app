import 'package:app/data/repositories/filtros_repository.dart';
import 'package:flutter/material.dart';


class FiltrosGastronomicosScreen extends StatefulWidget {
  final FiltrosRepository filtrosRepository;
  static const String ROUTENAME = 'FiltroGastronomicosScreen';

  FiltrosGastronomicosScreen({
    @required this.filtrosRepository
  });

  @override
  _FiltrosGastronomicosScreenState createState() => _FiltrosGastronomicosScreenState();
}

class _FiltrosGastronomicosScreenState extends State<FiltrosGastronomicosScreen> {
  Map<String, List> filtros;


  @override 
  void initState() {
    super.initState();
    getFiltros();
  }

  void getFiltros() async {
    filtros = await widget.filtrosRepository.getFiltrosGastronomicos();
    print(filtros);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtrar Gastronomicos"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text("Filtro de Gastronomicos :D")
      )
    );
  }
}