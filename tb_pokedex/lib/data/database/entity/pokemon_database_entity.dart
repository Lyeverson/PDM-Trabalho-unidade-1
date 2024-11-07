import 'package:floor/floor.dart';

@Entity(tableName: 'pokemon')
class PokemonDatabaseEntity {
  @PrimaryKey(autoGenerate: false)
  final int id; // Correspondente ao ID original do Pokémon
  final String name;
  final String types; // Armazenar como string separada por vírgulas
  final int hp;
  final int attack;
  final int defense;
  final int spAttack;
  final int spDefense;
  final int speed;

  PokemonDatabaseEntity({
    required this.id,
    required this.name,
    required this.types,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.spAttack,
    required this.spDefense,
    required this.speed,
  });
}
