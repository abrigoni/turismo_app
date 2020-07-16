import 'package:app/presentation/widgets/filterchip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/data/models/models.dart';
import 'package:app/data/providers/providers.dart';
import 'package:app/BLoC/bloc.dart';

class FiltrosAlojamientosScreen extends StatefulWidget {
  static const String ROUTENAME = 'FiltroAlojamientosScreen';
  final ClasificacionProvider clasificacionProvider;
  final CategoriaProvider categoriaProvider;
  final LocalidadProvider localidadProvider;

  FiltrosAlojamientosScreen({
    @required this.clasificacionProvider,
    @required this.categoriaProvider,
    @required this.localidadProvider,
  });

  @override
  _FiltrosAlojamientosScreenState createState() =>
      _FiltrosAlojamientosScreenState();
}

class _FiltrosAlojamientosScreenState extends State<FiltrosAlojamientosScreen> {
  List<Categoria> categorias = [];
  List<int> selectedCategorias = [];
  List<Clasificacion> clasificaciones = [];
  List<int> selectedClasificaciones = [];
  List<Localidad> localidades = [];
  List<int> selectedLocalidades = [];
  AlojamientosBloc _alojamientosBloc;
  @override
  void initState() {
    super.initState();
    getClasificaciones();
    getCategorias();
    getLocalidades();
  }

  void getClasificaciones() async {
    clasificaciones = await widget.clasificacionProvider.getClasificaciones();
    setState(() {});
  }

  void getCategorias() async {
    categorias = await widget.categoriaProvider.getCategorias();
    setState(() {});
  }

  void getLocalidades() async {
    localidades = await widget.localidadProvider.getLocalidades();
    setState(() {});
  }

  void updateSelectedLocalidades(int localidad) {
    if (selectedLocalidades.any((element) => element == localidad)) {
      selectedLocalidades.remove(localidad);
    } else {
      selectedLocalidades.add(localidad);
    }
    print("Selected localidades: " + selectedLocalidades.toString());
  }

  void updateSelectedClasificaciones(int clasificacion) {
    if (selectedClasificaciones.any((element) => element == clasificacion)) {
      selectedClasificaciones.remove(clasificacion);
    } else {
      selectedClasificaciones.add(clasificacion);
    }
    print("Selected clasificaciones: " + selectedClasificaciones.toString());
  }

  void updateSelectedCategorias(int categoria) {
    if (selectedCategorias.any((element) => element == categoria)) {
      selectedCategorias.remove(categoria);
    } else {
      selectedCategorias.add(categoria);
    }
    print("Selected clasificaciones: " + selectedCategorias.toString());
  }

  @override
  Widget build(BuildContext context) {
    _alojamientosBloc = BlocProvider.of<AlojamientosBloc>(context);
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
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _crearListaFiltros(),
                _crearBotonFiltrar(context),
              ],
            ),
          ),
        ));
  }

  Widget _crearListaFiltros() {
    return Column(
      children: <Widget>[
        SizedBox(height: 10,),
        _crearFiltroLocalidad(),
        SizedBox(height: 10,),
        _crearFiltroCategoria(),
        SizedBox(height: 10,),
        _crearFiltroClasificacion(),
      ],
    );
  }

  Widget _crearFiltroLocalidad() {
    return Column(
      children: <Widget>[
        Container(
            child: Text("Localidad/es",
                style: TextStyle(color: Colors.black, fontSize: 24.0))),
        Wrap(
          children: localidades
              .map<FilterChipWidget>((e) => FilterChipWidget(chipInfo: {"id": e.id, "name": e.nombre}, primaryColor: Color(0xFF18C5C1), updateSelecteds: updateSelectedLocalidades) )
              .toList(),
        )
      ],
    );
  }

  Widget _crearFiltroCategoria() {
    return Column(
      children: <Widget>[
        Container(
            child: Text("Categoria",
                style: TextStyle(color: Colors.black, fontSize: 24.0))),
        Wrap(
          children: categorias
              .map<FilterChipWidget>((e) => FilterChipWidget(chipInfo: {"id": e.id, "name": e.estrellas}, primaryColor: Colors.yellow[700], updateSelecteds: updateSelectedCategorias)  )
              .toList(),
        )
      ],
    );
  }

  Widget _crearFiltroClasificacion() {
    return Column(
      children: <Widget>[
        Container(
            child: Text("Clasificacion/es",
                style: TextStyle(color: Colors.black, fontSize: 24.0))),
        Wrap(
            children: clasificaciones
            .map<FilterChipWidget>((e) => FilterChipWidget(chipInfo: {"id": e.id, "name":  e.nombre}, primaryColor: Colors.blue, updateSelecteds: updateSelectedClasificaciones))
            .toList(),
        ),
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
          var filtros = {
            "localidades": selectedLocalidades, 
            "categorias": selectedCategorias,
            "clasificaciones": selectedClasificaciones,
          };
          Navigator.pop(context);
          _alojamientosBloc.add(AlojamientosFilter(filtros));
          
        },
        child: Text("Filtrar"),
        textColor: Colors.white,
      ),
    );
  }
}
