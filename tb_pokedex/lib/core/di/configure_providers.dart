import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tb_pokedex/data/database/dao/app_database.dart';
import 'package:tb_pokedex/data/database/dao/pokemon_dao.dart';
import 'package:tb_pokedex/data/database/database_mapper.dart';
import 'package:tb_pokedex/data/network/Client/api_client.dart';
import 'package:tb_pokedex/data/network/network_mapper.dart';
import 'package:tb_pokedex/data/repository/pokemon_repository_impl.dart';

class ConfigureProviders {
  final List<SingleChildWidget> providers;

  ConfigureProviders({required this.providers});

  static Future<ConfigureProviders> createDependencyTree() async {

    final api_client = ApiClient(baseUrl: "http://10.0.0.16:3000");
    final network_mapper = NetworkMapper();
    final database_mapper = DatabaseMapper();
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
   final pokemon_dao = database.pokemonDao;

    final pokemons_repository = PokemonRepositoryImpl(
        apiClient: api_client,
        networkMapper: network_mapper,
        databaseMapper: database_mapper,
        pokemonDao: pokemon_dao
    );

    return ConfigureProviders(providers: [
      Provider<ApiClient>.value(value: api_client),
      Provider<NetworkMapper>.value(value: network_mapper),
      Provider<DatabaseMapper>.value(value: database_mapper),
      Provider<PokemonDao>.value(value: pokemon_dao),
      Provider<PokemonRepositoryImpl>.value(value: pokemons_repository),
    ]);
  }
}