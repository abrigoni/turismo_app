
import 'package:app/data/models/models.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FiltrosRepository {
  final String getFiltrosQuery = """
    query GetFiltros {

  turismo_actividades {
      id, 
      nombre
  }
  turismo_especialidades {
    id, 
    nombre
  }
  turismo_localidades {
    id, 
    nombre
  }
}
""";
  final GraphQLClient _graphQLClient;

  const FiltrosRepository({GraphQLClient graphQLClient})
    : assert(graphQLClient != null),
    _graphQLClient = graphQLClient;

  factory FiltrosRepository.create() {
    final httpLink = HttpLink(uri: 'http://192.168.1.35:8080/v1/graphql');
    final link = Link.from([httpLink]);

    return FiltrosRepository( 
      graphQLClient: GraphQLClient(cache: InMemoryCache(), link: link)
    );
  }

  Future<Map<String, List>> getFiltrosGastronomicos() async {
    final result = await _graphQLClient.query(QueryOptions(documentNode: gql(getFiltrosQuery)));
    final Map<String, List> filtros = {
      "actividades": Actividades.fromJsonList(result.data['turismo_actividades']).items,
      "especialidades": Especialidades.fromJsonList(result.data['turismo_especialidades']).items,
      "localidades": Localidades.fromJsonList(result.data['turismo_localidades']).items,
    };
    return filtros;
  }
}