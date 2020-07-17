import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app/data/models/gastronomico_model.dart';

class GastronomicoProvider {

  final String getAllQuery = """
    query GetGastronomicos {
  turismo_gastronomicos {
      id,
      nombre,
      foto, 
      lat,
      lng,
      domicilio,
      localidad_id,
      localidad {
          nombre
      }
    	especialidades {
        especialidad {
          id
          nombre
        }
      }
      actividades {
        actividad {
          id
          nombre
        }
      }
    }
}
""";

  const GastronomicoProvider({GraphQLClient graphQLClient})
    : assert(graphQLClient != null),
    _graphQLClient = graphQLClient;

  factory GastronomicoProvider.create() {
    final httpLink = HttpLink(uri: 'http://192.168.1.35:8080/v1/graphql');
    final link = Link.from([httpLink]);

    return GastronomicoProvider( 
      graphQLClient: GraphQLClient(cache: InMemoryCache(), link: link)
    );
  }

  final GraphQLClient _graphQLClient;

  Future<List<Gastronomico>> getAll() async {
    final result = await _graphQLClient.query(QueryOptions(documentNode: gql(getAllQuery)));
    final gastronomicos = Gastronomicos.fromJsonList(result.data['turismo_gastronomicos']);
    return gastronomicos.items;
  }
}