import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../entity/pokemon_database_entity.dart';
import 'pokemon_dao.dart';

part 'app_database.g.dart'; 

@Database(version: 1, entities: [PokemonDatabaseEntity])
abstract class AppDatabase extends FloorDatabase {
  PokemonDao get pokemonDao;
}