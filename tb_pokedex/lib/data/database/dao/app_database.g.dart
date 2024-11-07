// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PokemonDao? _pokemonDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `pokemon` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `types` TEXT NOT NULL, `hp` INTEGER NOT NULL, `attack` INTEGER NOT NULL, `defense` INTEGER NOT NULL, `spAttack` INTEGER NOT NULL, `spDefense` INTEGER NOT NULL, `speed` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PokemonDao get pokemonDao {
    return _pokemonDaoInstance ??= _$PokemonDao(database, changeListener);
  }
}

class _$PokemonDao extends PokemonDao {
  _$PokemonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pokemonDatabaseEntityInsertionAdapter = InsertionAdapter(
            database,
            'pokemon',
            (PokemonDatabaseEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'types': item.types,
                  'hp': item.hp,
                  'attack': item.attack,
                  'defense': item.defense,
                  'spAttack': item.spAttack,
                  'spDefense': item.spDefense,
                  'speed': item.speed
                }),
        _pokemonDatabaseEntityUpdateAdapter = UpdateAdapter(
            database,
            'pokemon',
            ['id'],
            (PokemonDatabaseEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'types': item.types,
                  'hp': item.hp,
                  'attack': item.attack,
                  'defense': item.defense,
                  'spAttack': item.spAttack,
                  'spDefense': item.spDefense,
                  'speed': item.speed
                }),
        _pokemonDatabaseEntityDeletionAdapter = DeletionAdapter(
            database,
            'pokemon',
            ['id'],
            (PokemonDatabaseEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'types': item.types,
                  'hp': item.hp,
                  'attack': item.attack,
                  'defense': item.defense,
                  'spAttack': item.spAttack,
                  'spDefense': item.spDefense,
                  'speed': item.speed
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PokemonDatabaseEntity>
      _pokemonDatabaseEntityInsertionAdapter;

  final UpdateAdapter<PokemonDatabaseEntity>
      _pokemonDatabaseEntityUpdateAdapter;

  final DeletionAdapter<PokemonDatabaseEntity>
      _pokemonDatabaseEntityDeletionAdapter;

  @override
  Future<PokemonDatabaseEntity?> findPokemonById(int id) async {
    return _queryAdapter.query('SELECT * FROM pokemon WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PokemonDatabaseEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            types: row['types'] as String,
            hp: row['hp'] as int,
            attack: row['attack'] as int,
            defense: row['defense'] as int,
            spAttack: row['spAttack'] as int,
            spDefense: row['spDefense'] as int,
            speed: row['speed'] as int),
        arguments: [id]);
  }

  @override
  Future<List<PokemonDatabaseEntity>> findAllPokemons(
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList('SELECT * FROM pokemon LIMIT ?1 OFFSET ?2',
        mapper: (Map<String, Object?> row) => PokemonDatabaseEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            types: row['types'] as String,
            hp: row['hp'] as int,
            attack: row['attack'] as int,
            defense: row['defense'] as int,
            spAttack: row['spAttack'] as int,
            spDefense: row['spDefense'] as int,
            speed: row['speed'] as int),
        arguments: [limit, offset]);
  }

  @override
  Future<void> deletePokemonById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM pokemon WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllPokemons() async {
    await _queryAdapter.queryNoReturn('DELETE FROM pokemon');
  }

  @override
  Future<void> insertPokemon(PokemonDatabaseEntity pokemon) async {
    await _pokemonDatabaseEntityInsertionAdapter.insert(
        pokemon, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertAllPokemons(List<PokemonDatabaseEntity> pokemons) async {
    await _pokemonDatabaseEntityInsertionAdapter.insertList(
        pokemons, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePokemon(PokemonDatabaseEntity pokemon) async {
    await _pokemonDatabaseEntityUpdateAdapter.update(
        pokemon, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePokemon(PokemonDatabaseEntity pokemon) async {
    await _pokemonDatabaseEntityDeletionAdapter.delete(pokemon);
  }
}
