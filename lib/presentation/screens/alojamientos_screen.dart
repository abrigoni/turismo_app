import 'package:app/data/repositories/alojamiento_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/BLoC/bloc.dart';
import 'package:app/data/models/alojamiento_model.dart';
import 'package:app/data/providers/providers.dart';
import 'package:app/presentation/screens/alojamiento_detail_screen.dart';
import 'package:app/presentation/screens/alojamientos_map_screen.dart';
import 'package:app/presentation/screens/filtros_alojamientos_screen.dart';
import 'package:app/presentation/widgets/alojamiento_card_widget.dart';
import 'package:app/presentation/widgets/searchbar_widget.dart';




class AlojamientosScreen extends StatelessWidget {

  static const String ROUTENAME = 'Alojamientos';

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF4EAEFB),
        appBar: _crearAppBar(context),
        body: BlocProvider(
          create: (context) =>
              AlojamientoBloc(alojamientoRepository: AlojamientoRepository() )..add(FetchAlojamientos()),
          child: AlojamientosUI(alojamientosRepository: AlojamientoRepository(),)
      ),
    );
  }

  Widget _crearAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0xFF4EAEFB), 
        title: Text("Alojamientos"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.filter_list), onPressed: (){
            Navigator.pushNamed(context, FiltrosAlojamientosScreen.ROUTENAME);
          }),
        ],
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.map), onPressed: () async {
          Navigator.pushNamed(context, AlojamientosMapScreen.ROUTENAME);
        }),
    );
  }
}

class AlojamientosUI extends StatefulWidget {

  final AlojamientoRepository alojamientosRepository;


  AlojamientosUI({
    @required this.alojamientosRepository,
  });

  @override
  _AlojamientosUIState createState() => _AlojamientosUIState();
}

class _AlojamientosUIState extends State<AlojamientosUI> {
  
  AlojamientoBloc _alojamientoBloc;
  List<Alojamiento> alojamientos;

  @override
  void initState() {
    super.initState();
    _alojamientoBloc = BlocProvider.of<AlojamientoBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlojamientoBloc, AlojamientoState>(
      builder: (context, state) {
        if (state is AlojamientoFailure) {
          return Center(
            child: Text('failed to fetch alojamientos'),
          );
        }
        if (state is AlojamientoSuccess) {
          if (state.alojamientos.isEmpty) {
            return Center(
              child: Text('no alojamientos'),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 20.0, 
              ),
              SearchBarWidget(),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: _crearListContainer(state.alojamientos),
              )
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _crearListContainer(List<Alojamiento> alojamientos) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(54), topRight: Radius.circular(54)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 20.0),
            ]
          ),
        ),
        _alojamientosListView(alojamientos)
      ],
    );
    
  }

  Widget _alojamientosListView(List<Alojamiento> alojamientos) {
    return Center(
        child: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: ListView.builder(
                itemCount: alojamientos.length,
                itemBuilder: (BuildContext context, int index) {
                  return AlojamientoCardWidget(alojamiento: alojamientos[index], onTap: _onCardTap);
            }
        ),
      ),
    );
  }

  void _onCardTap(BuildContext context, Alojamiento alojamiento) {
    Navigator.pushNamed(context, AlojamientoDetailScreen.ROUTENAME, arguments: alojamiento);
  }

}
