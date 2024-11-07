import 'package:floor/floor.dart';

import '../entity/pokemon_database_entity.dart';


@dao
abstract class PokemonDao {
  @Query('SELECT * FROM pokemon WHERE id = :id')
  Future<PokemonDatabaseEntity?> findPokemonById(int id);


  @Query('SELECT * FROM pokemon LIMIT :limit OFFSET :offset')
Future<List<PokemonDatabaseEntity>> findAllPokemons(int limit, int offset);


  @Query('DELETE FROM pokemon WHERE id = :id')
  Future<void> deletePokemonById(int id);

  @Query('DELETE FROM pokemon')
  Future<void> deleteAllPokemons();

  @insert
  Future<void> insertPokemon(PokemonDatabaseEntity pokemon);

  @insert
  Future<void> insertAllPokemons(List<PokemonDatabaseEntity> pokemons);

  @update
  Future<void> updatePokemon(PokemonDatabaseEntity pokemon);

  @delete
  Future<void> deletePokemon(PokemonDatabaseEntity pokemon);
}
