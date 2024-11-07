import 'package:shared_preferences/shared_preferences.dart';

import 'package:tb_pokedex/data/database/dao/pokemon_dao.dart';
import 'package:tb_pokedex/data/database/database_mapper.dart';
import 'package:tb_pokedex/data/network/Client/api_client.dart';
import 'package:tb_pokedex/data/network/network_mapper.dart';
import 'package:tb_pokedex/data/repository/pokemon_repository.dart';
import 'package:tb_pokedex/domain/pokemon.dart';

class PokemonRepositoryImpl implements PokemonRepository {

  final ApiClient apiClient;
  final NetworkMapper networkMapper;
  final PokemonDao pokemonDao;
  final DatabaseMapper databaseMapper;

  PokemonRepositoryImpl(
      {required this.pokemonDao,
      required this.databaseMapper,
      required this.apiClient,
      required this.networkMapper});

  Future<List<Pokemon>> getPokemons({ required int page, required int limit}) async {

    
    final dbEntities = await pokemonDao.findAllPokemons(10, (page * limit) - limit);
    
    if (dbEntities.isNotEmpty) {
      return databaseMapper.toPokemons(dbEntities);
    }
    
    final networkEntity = await apiClient.getAll(page: page, limit: limit);
    final pokemons = networkMapper.toPokemons(networkEntity);
    
    pokemonDao.insertAllPokemons(databaseMapper.toPokemonDatabaseEntities(pokemons));

    return pokemons;
  }

Future<Pokemon> getRandomPokemon() async {
     final networkEntity = await apiClient.fetchRandomPokemon();
    final pokemon = networkMapper.toPokemon(networkEntity);

    return pokemon;
}

Future<Pokemon> getPokemonId(int id) async {
   final networkEntity = await apiClient.fetchPokemonDetails(id);
   final pokemon = networkMapper.toPokemon(networkEntity);

   return pokemon;
}

Future<void> savePokemonToCache(Pokemon pokemon) async {
  final prefs = await SharedPreferences.getInstance();

  List<String> ids = prefs.getStringList("myIds") ?? [];
  List<String> names = prefs.getStringList("myNames") ?? [];
  List<String> types = prefs.getStringList("myTypes") ?? [];
  List<String> hps = prefs.getStringList("myHps") ?? [];
  List<String> attacks = prefs.getStringList("myAttacks") ?? [];
  List<String> defenses = prefs.getStringList("myDefenses") ?? [];
  List<String> spAttacks = prefs.getStringList("mySpAttacks") ?? [];
  List<String> spDefenses = prefs.getStringList("mySpDefenses") ?? [];
  List<String> speeds = prefs.getStringList("mySpeeds") ?? [];



  // Limita o cache a 6 Pokémon
  if (ids.length < 6) {
    ids.add("${pokemon.id}");
    names.add(pokemon.name);
    types.add(pokemon.types.join(",")); // Convertendo a lista para string
    hps.add("${pokemon.hp}");
    attacks.add("${pokemon.attack}");
    defenses.add("${pokemon.defense}");
    spAttacks.add("${pokemon.spAttack}");
    spDefenses.add("${pokemon.spDefense}");
    speeds.add("${pokemon.speed}");

    // Salvando listas no SharedPreferences
    await prefs.setStringList("myIds", ids);
    await prefs.setStringList("myNames", names);
    await prefs.setStringList("myTypes", types);
    await prefs.setStringList("myHps", hps);
    await prefs.setStringList("myAttacks", attacks);
    await prefs.setStringList("myDefenses", defenses);
    await prefs.setStringList("mySpAttacks", spAttacks);
    await prefs.setStringList("mySpDefenses", spDefenses);
    await prefs.setStringList("mySpeeds", speeds);
  }
}

Future<void> removeFromCache(Pokemon pokemon)async {
  final prefs = await SharedPreferences.getInstance();

  // Recupera todas as listas do cache
  List<String> ids = prefs.getStringList("myIds") ?? [];
  List<String> names = prefs.getStringList("myNames") ?? [];
  List<String> types = prefs.getStringList("myTypes") ?? [];
  List<String> hps = prefs.getStringList("myHps") ?? [];
  List<String> attacks = prefs.getStringList("myAttacks") ?? [];
  List<String> defenses = prefs.getStringList("myDefenses") ?? [];
  List<String> spAttacks = prefs.getStringList("mySpAttacks") ?? [];
  List<String> spDefenses = prefs.getStringList("mySpDefenses") ?? [];
  List<String> speeds = prefs.getStringList("mySpeeds") ?? [];

  // Encontra o índice do Pokémon a ser removido
  int index = ids.indexOf("${pokemon.id}");
  if (index == -1) return; // Sai se o Pokémon não estiver no cache

  // Remove o Pokémon de cada lista
  ids.removeAt(index);
  names.removeAt(index);
  types.removeAt(index);
  hps.removeAt(index);
  attacks.removeAt(index);
  defenses.removeAt(index);
  spAttacks.removeAt(index);
  spDefenses.removeAt(index);
  speeds.removeAt(index);

  // Salva as listas atualizadas no SharedPreferences
  await prefs.setStringList("myIds", ids);
  await prefs.setStringList("myNames", names);
  await prefs.setStringList("myTypes", types);
  await prefs.setStringList("myHps", hps);
  await prefs.setStringList("myAttacks", attacks);
  await prefs.setStringList("myDefenses", defenses);
  await prefs.setStringList("mySpAttacks", spAttacks);
  await prefs.setStringList("mySpDefenses", spDefenses);
  await prefs.setStringList("mySpeeds", speeds);
}


Future<List<Pokemon>> getPokemonsFromCache() async {
  final prefs = await SharedPreferences.getInstance();
  
  List<String> ids = prefs.getStringList("myIds") ?? [];
  List<String> names = prefs.getStringList("myNames") ?? [];
  List<String> types = prefs.getStringList("myTypes") ?? [];
  List<String> hps = prefs.getStringList("myHps") ?? [];
  List<String> attacks = prefs.getStringList("myAttacks") ?? [];
  List<String> defenses = prefs.getStringList("myDefenses") ?? [];
  List<String> spAttacks = prefs.getStringList("mySpAttacks") ?? [];
  List<String> spDefenses = prefs.getStringList("mySpDefenses") ?? [];
  List<String> speeds = prefs.getStringList("mySpeeds") ?? [];

   List<Pokemon> pokemons = [];
  

  int length = ids.length;
  // Constrói a lista de Pokémons a partir dos dados armazenados
  for (int i = 0; i < length; i++) {
    pokemons.add(Pokemon(
      id: int.parse(ids[i]),
      name: names[i],
      types: types[i].split(","), // Converte a string de volta para uma lista
      hp: int.parse(hps[i]),
      attack: int.parse(attacks[i]),
      defense: int.parse(defenses[i]),
      spAttack: int.parse(spAttacks[i]),
      spDefense: int.parse(spDefenses[i]),
      speed: int.parse(speeds[i]),
    ));
  }

  return pokemons;
  
}

}