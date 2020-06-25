import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app/config/graphql_config.dart';
import 'package:app/presentation/screens/gastronomico_detail_screen.dart';
import 'package:app/presentation/screens/filtros_gastronomicos_screen.dart';
import 'package:app/presentation/screens/gastronomicos_map_screen.dart';
import 'package:app/presentation/widgets/gastronomico_card_widget.dart';
import 'package:app/presentation/widgets/searchbar_widget.dart';

class GastronomicosScreen extends StatefulWidget {
  static const String ROUTENAME = 'Gastronomicos';

  @override
  _GastronomicosScreenState createState() => _GastronomicosScreenState();
}

class _GastronomicosScreenState extends State<GastronomicosScreen> {
  String query = """
    query GetGastronomicos {
  turismo_gastronomicos {
      id,
      nombre,
      foto, 
      lat,
      lng,
      domicilio,
      localidad {
          nombre
      }
    	especialidades {
        especialidad {
          nombre
        }
      }
      actividades {
        actividad {
          nombre
        }
      }
    }
}
""";

  List<dynamic> _gastronomicos;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLConfig.initializeClient(),
      child: Scaffold(
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
              Expanded(child: _crearListContainer())
            ],
          ))),
    );
  }

  Widget _crearAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFF0AD5F),
      title: Text("Gastronomicos"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.pushNamed(
                  context, FiltrosGastronomicosScreen.ROUTENAME);
            }),
      ],
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.map),
          onPressed: () {
            Navigator.pushNamed(context, GastronomicosMapScreen.ROUTENAME,
                arguments: _gastronomicos);
          }),
    );
  }

  Widget _crearListContainer() {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(54), topRight: Radius.circular(54)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 20.0),
              ]),
        ),
        Query(
          options: QueryOptions(
            documentNode: gql(query),
          ),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.loading) {
              return Text('Loading');
            }
            _gastronomicos = result.data["turismo_gastronomicos"];
            return _gastronomicosListView(_gastronomicos);
          },
        )
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
            return GastronomicoCardWidget(
                gastronomico: gastronomicos[index], onTap: _onCardTap);
          },
        ),
      ),
    );
  }

  void _onCardTap(BuildContext context, dynamic gastronomico) {
    Navigator.pushNamed(context, GastronomicoDetailScreen.ROUTENAME,
        arguments: gastronomico);
  }
}
