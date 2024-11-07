import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tb_pokedex/data/repository/pokemon_repository_impl.dart';
import 'package:tb_pokedex/domain/pokemon.dart';
import 'package:tb_pokedex/ui/widget/my_pokemon_card.dart';
import 'package:tb_pokedex/ui/widget/pokemon_card.dart';

class MyPokemons extends StatefulWidget {
  const MyPokemons({super.key});

  @override
  State<MyPokemons> createState() => _MyPokemonsState();
}

class _MyPokemonsState extends State<MyPokemons> {
  late final PokemonRepositoryImpl pokemonsRepo;
  List<Pokemon> cachedPokemons = [];

  @override
  void initState() {
    super.initState();
    pokemonsRepo = Provider.of<PokemonRepositoryImpl>(context, listen: false);
    _loadCachedPokemons();
  }

  Future<void> _loadCachedPokemons() async {
    try {
      cachedPokemons = await pokemonsRepo.getPokemonsFromCache();
      setState(() {});
    } catch (e) {
      print("Error loading cached Pokémons: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyPokemons"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
      ),
      body:Container(
        padding: EdgeInsets.all(16.0), 
        color: Colors.white,
        child: ListView.builder(
          itemCount: cachedPokemons.length,
          itemBuilder: (context, index) {
            final pokemon = cachedPokemons[index];
            return MyPokemonCard(pokemon: pokemon);
          },
        ),
      ),
    );
  }
}
