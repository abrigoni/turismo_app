import 'package:app/presentation/widgets/filterchip_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/data/repositories/filtros_repository.dart';
import 'package:app/BLoC/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
  List<int> selectedLocalidades= [];
  List<int> selectedEspecialidades = [];
  List<int> selectedActividades = [];
  GastronomicosBloc _gastronomicosBloc;


  @override
  Widget build(BuildContext context) {
    _gastronomicosBloc = BlocProvider.of<GastronomicosBloc>(context);
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FutureBuilder(
                future: widget.filtrosRepository.getFiltrosGastronomicos(),
                builder: (BuildContext context, AsyncSnapshot<Map<String, List>> snapshot) {
                  if (snapshot.hasData) {
                    return _crearListaFiltros(snapshot.data);
                  }
                  return CircularProgressIndicator();
                }
              ),
              _crearBotonFiltrar(context)
            ],
          )
        ),
      )
    );
  }

  Widget _crearListaFiltros(Map<String, List> filtros) {
    return Column(
      children: <Widget>[
        SizedBox(height:10),
        _crearFiltrosLocalidades(filtros["localidades"]),
        SizedBox(height:10),
        _crearFiltrosEspecialidades(filtros["especialidades"]),
        SizedBox(height:10),
        _crearFiltrosActividades(filtros["actividades"]),
      ],
    );
  }


  void updateSelectedLocalidades(int localidad) {
    if (selectedLocalidades.any((element) => element == localidad)) {
      selectedLocalidades.remove(localidad);
    } else {
      selectedLocalidades.add(localidad);
    }
    print("Selected localidades: " + selectedLocalidades.toString());
  }

  Widget _crearFiltrosLocalidades(List<dynamic> localidades) {
    return Column(
      children: <Widget>[
        Container(
            child: Text("Localidad/es",
                style: TextStyle(color: Colors.black, fontSize: 24.0))),
        Wrap(
          children: localidades.map((e) => FilterChipWidget(chipInfo: {"id": e.id, "name": e.nombre}, primaryColor: Color(0xFF18C5C1), updateSelecteds: updateSelectedLocalidades)).toList(),
        )
      ],
    );
  }

  void updateSelectedEspecialidades(int especialidad) {
    if (selectedEspecialidades.any((element) => element == especialidad)) {
      selectedEspecialidades.remove(especialidad);
    } else {
      selectedEspecialidades.add(especialidad);
    }
    print("Selected especialidades: " + selectedEspecialidades.toString());
  }

  Widget _crearFiltrosEspecialidades(List<dynamic> especialidades) {
    return Column(
      children: <Widget>[
        Container(
            child: Text("Especialidad/es",
                style: TextStyle(color: Colors.black, fontSize: 24.0))),
        Wrap(
          children: especialidades.map((e) => FilterChipWidget(chipInfo: {"id": e.id, "name": e.nombre}, primaryColor: Color(0xFF18C5C1), updateSelecteds: updateSelectedEspecialidades)).toList(),
        )
      ],
    );
  }

  void updateSelectedActividades(int actividad) {
    if (selectedActividades.any((element) => element == actividad)) {
      selectedActividades.remove(actividad);
    } else {
      selectedActividades.add(actividad);
    }
    print("Selected actividades: " + selectedActividades.toString());
  }

  Widget _crearFiltrosActividades(List<dynamic> actividades) {
    return Column(
      children: <Widget>[
        Container(
            child: Text("Actividad/es",
                style: TextStyle(color: Colors.black, fontSize: 24.0))),
        Wrap(
          children: actividades.map((e) => FilterChipWidget(chipInfo: {"id": e.id, "name": e.nombre}, primaryColor: Color(0xFF18C5C1), updateSelecteds: updateSelectedActividades)).toList(),
        )
      ],
    );
  }

  Widget _crearBotonFiltrar(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(bottom: 15, top: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFF18C5C1), const Color(0xFF25EAA5)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: MaterialButton(
        onPressed: () { 
          Navigator.pop(context);
          var filtros = {
            "localidades": selectedLocalidades,
            "especialidades": selectedEspecialidades,
            "actividades": selectedActividades
          };
          _gastronomicosBloc.add(GastronomicosFilter(filtros));
        },
        child: Text("Filtrar"),
        textColor: Colors.white,
      ),
    );
  }
}