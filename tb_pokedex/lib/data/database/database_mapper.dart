import '/data/database/entity/pokemon_database_entity.dart';
import '/domain/exception/mapper_exception.dart';
import '/domain/pokemon.dart';

class DatabaseMapper {
  Pokemon toPokemon(PokemonDatabaseEntity entity) {
    try {
      return Pokemon(
        id: entity.id,
        name: entity.name,
        types: entity.types.split(','), // Converte a string de volta para a lista
        hp: entity.hp,
        attack: entity.attack,
        defense: entity.defense,
        spAttack: entity.spAttack,
        spDefense: entity.spDefense,
        speed: entity.speed,
      );
    } catch (e) {
      throw MapperException<PokemonDatabaseEntity, Pokemon>(e.toString());
    }
  }

  List<Pokemon> toPokemons(List<PokemonDatabaseEntity> entities) {
    return entities.map(toPokemon).toList();
  }

  PokemonDatabaseEntity toPokemonDatabaseEntity(Pokemon pokemon) {
    try {
      return PokemonDatabaseEntity(
        id: pokemon.id,
        name: pokemon.name,
        types: pokemon.types.join(','), // Converte a lista para uma string
        hp: pokemon.hp,
        attack: pokemon.attack,
        defense: pokemon.defense,
        spAttack: pokemon.spAttack,
        spDefense: pokemon.spDefense,
        speed: pokemon.speed,
      );
    } catch (e) {
      throw MapperException<Pokemon, PokemonDatabaseEntity>(e.toString());
    }
  }

  List<PokemonDatabaseEntity> toPokemonDatabaseEntities(List<Pokemon> pokemons) {
    return pokemons.map(toPokemonDatabaseEntity).toList();
  }
}
