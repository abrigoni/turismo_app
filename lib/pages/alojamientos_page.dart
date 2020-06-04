import 'package:flutter/material.dart';
import 'package:app/providers/alojamiento_provider.dart';
import 'package:app/models/alojamiento_model.dart';
import 'package:app/pages/alojamientos_map_page.dart';
import 'package:app/widgets/alojamiento_card_widget.dart';
import 'package:app/widgets/searchbar_widget.dart';
import 'package:app/pages/filtros_alojamientos_page.dart';
import 'package:app/BLoC/alojamientos_bloc.dart';
import 'package:app/pages/alojamiento_detail_page.dart';


class AlojamientosPage extends StatefulWidget {

  static const String ROUTENAME = 'Alojamientos';
  final AlojamientoProvider alojamientosProvider;


  AlojamientosPage({
    @required this.alojamientosProvider,
  });

  @override
  _AlojamientosPageState createState() => _AlojamientosPageState();
}

class _AlojamientosPageState extends State<AlojamientosPage> {

  List<Alojamiento> alojamientos;
  final alojamientosBloc = new AlojamientosBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _crearAppBar(context),
      backgroundColor: Color(0xFF4EAEFB),
      body: SafeArea( 
        child: Column(
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
            child: _crearListContainer(),
          )
          
        ],
        )
      )
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

  Widget _crearListContainer() {
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
        StreamBuilder(
          stream: alojamientosBloc.alojamientosStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              alojamientos = snapshot.data;
              return _alojamientosListView(snapshot.data);
            }
            return Container(child: Center(child: CircularProgressIndicator()));
          }
        ),
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
