import 'package:app/BLoC/alojamiento_state.dart';
import 'package:flutter/material.dart';
import 'package:app/providers/alojamiento_provider.dart';
import 'package:app/models/alojamiento_model.dart';
import 'package:app/pages/alojamientos_map_page.dart';
import 'package:app/widgets/alojamiento_card_widget.dart';
import 'package:app/widgets/searchbar_widget.dart';
import 'package:app/pages/filtros_alojamientos_page.dart';
import 'package:app/pages/alojamiento_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/BLoC/alojamiento_bloc.dart';
import 'package:app/BLoC/alojamiento_event.dart';



class AlojamientosPage extends StatelessWidget {

  static const String ROUTENAME = 'Alojamientos';

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF4EAEFB),
        appBar: _crearAppBar(context),
        body: BlocProvider(
          create: (context) =>
              AlojamientoBloc(alojamientoProvider: AlojamientoProvider() )..add(FetchAlojamientos()),
          child: AlojamientosUI(alojamientosProvider: AlojamientoProvider(),)
      ),
    );
  }

  Widget _crearAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0xFF4EAEFB), 
        title: Text("Alojamientos"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.filter_list), onPressed: (){
            Navigator.pushNamed(context, FiltrosAlojamientosPage.ROUTENAME);
          }),
        ],
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.map), onPressed: () async {
          Navigator.pushNamed(context, AlojamientosMapPage.ROUTENAME);
        }),
    );
  }
}

class AlojamientosUI extends StatefulWidget {

  final AlojamientoProvider alojamientosProvider;


  AlojamientosUI({
    @required this.alojamientosProvider,
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
    Navigator.pushNamed(context, AlojamientoDetailPage.ROUTENAME, arguments: alojamiento);
  }

}
