
import 'package:graphql_flutter/graphql_flutter.dart';

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

  const GastronomicoProvider({GraphQLClient graphQLClient})
    : assert(graphQLClient != null),
    _graphQLClient = graphQLClient;

  factory GastronomicoProvider.create() {
    final httpLink = HttpLink(uri: 'http://192.168.1.36:8080/v1/graphql');
    final link = Link.from([httpLink]);

    return GastronomicoProvider( 
      graphQLClient: GraphQLClient(cache: InMemoryCache(), link: link)
    );
  }

  final GraphQLClient _graphQLClient;

  Future<List<dynamic>> getAll() async {
    final result = await _graphQLClient.query(QueryOptions(documentNode: gql(getAllQuery)));
    final data = result.data['turismo_gastronomicos'];
    return data;
  }
}