
import '../../domain/exception/mapper_exception.dart';
import '../../domain/pokemon.dart';
import 'entity/http_paged_result.dart';

class NetworkMapper {
  Pokemon toPokemon(PokemonEntity entity) {
    try {
      return Pokemon(
        id: entity.id,
        name: entity.name['english'] ?? 'Unknown', // Usa o nome em inglês
        types: entity.type,
        hp: entity.base['HP'] ?? 0,
        attack: entity.base['Attack'] ?? 0,
        defense: entity.base['Defense'] ?? 0,
        spAttack: entity.base['Sp. Attack'] ?? 0,
        spDefense: entity.base['Sp. Defense'] ?? 0,
        speed: entity.base['Speed'] ?? 0,
      );
    } catch (e) {
      throw MapperException<PokemonEntity, Pokemon>(e.toString());
    }
  }

  List<Pokemon> toPokemons(List<PokemonEntity> entities) {
    final List<Pokemon> pokemons = [];
    for (var pokemonEntity in entities) {
      pokemons.add(toPokemon(pokemonEntity));
    }
    return pokemons;
  }
}
