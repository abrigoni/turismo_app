import 'package:flutter/material.dart';
import 'package:app/data/models/models.dart';
import 'package:app/data/providers/providers.dart';


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
  List<Clasificacion> clasificaciones = [];
  List<Localidad> localidades = [];

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
    print(clasificaciones[0].nombre);
  }

  void getCategorias() async {
    categorias = await widget.categoriaProvider.getCategorias();
    setState(() {});
    print(categorias[0].estrellas);
  }

  void getLocalidades() async {
    localidades = await widget.localidadProvider.getLocalidades();
    setState(() {});
    print(localidades[0].nombre);
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
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _crearListaFiltros(),
              _crearBotonFiltrar(),
            ],
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
              .map<FilterChip>((e) => FilterChip(
                  avatar: CircleAvatar(
                      backgroundColor: Color(0xFF18C5C1),
                      child: Text(e.nombre[0],
                          style: TextStyle(color: Colors.white))),
                  label: Text(e.nombre),
                  onSelected: (value) {}))
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
              .map<FilterChip>((e) => FilterChip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.star, color: Colors.yellow[600])),
                  label: Text(e.estrellas),
                  onSelected: (value) {}))
              .toList(),
        )
      ],
    );
  }

  Widget _crearFiltroClasificacion() {
    return Column(
      children: <Widget>[
        Container(
            child: Text("Categoria",
                style: TextStyle(color: Colors.black, fontSize: 24.0))),
        DropdownButton(
            items: clasificaciones.map<DropdownMenuItem>((clasificacion) {
              return DropdownMenuItem(child: Text(clasificacion.nombre));
            }).toList(),
            onChanged: (value) {}),
      ],
    );
  }

  Widget _crearBotonFiltrar() {
    return Container(
      width: 150,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFF18C5C1), const Color(0xFF25EAA5)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: MaterialButton(
        onPressed: () {},
        child: Text("Filtrar"),
        textColor: Colors.white,
      ),
    );
  }
}
