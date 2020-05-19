
import 'package:app/pages/filtros_gastronomicos_page.dart';
import 'package:app/pages/gastronomicos_map_page.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/gastronomico_card_widget.dart';
import 'package:app/widgets/searchbar_widget.dart';

class GastronomicosPage extends StatelessWidget {
  static const String ROUTENAME = 'Gastronomicos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _crearAppBar(context),
      backgroundColor: Color(0xFFF0AD5F),
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
            child: _crearListContainer()
          )
        ],
        )
      )
    );
  }

  Widget _crearAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0xFFF0AD5F), 
        title: Text("Gastronomicos"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.filter_list), onPressed: (){
            Navigator.pushNamed(context, FiltrosGastronomicosPage.ROUTENAME);
          }),
        ],
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.map), onPressed: (){
          Navigator.pushNamed(context, GastronomicosMapPage.ROUTENAME);
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
        FutureBuilder(
          future: null,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // if (snapshot.hasData) 
            //   return _gastronomicosListView(snapshot.data);
            // return Container(child: Center(child: CircularProgressIndicator()));
            return _gastronomicosListView([1, 2, 3, 4]);
          },
        ),
      ],
    );
  }


  Widget _gastronomicosListView(List gastronomicos) {
    return Center(
            child: Container(
            padding: EdgeInsets.only(top: 20.0),
            child: ListView.builder(
                itemCount: gastronomicos.length,
                itemBuilder: (BuildContext context, int index) {
                    return GastronomicoCardWidget(gastronomico: gastronomicos[index]);
                },
            ),
          ),
        );
  }
 
}
