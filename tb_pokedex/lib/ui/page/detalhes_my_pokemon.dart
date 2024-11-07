import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tb_pokedex/data/repository/pokemon_repository_impl.dart';
import 'package:tb_pokedex/domain/pokemon.dart';

class DetalhesMyPokemon extends StatefulWidget {
  final Pokemon pokemon;
  const DetalhesMyPokemon({super.key, required this.pokemon});

  @override
  State<DetalhesMyPokemon> createState() => _DetalhesMyPokemonState();
}

class _DetalhesMyPokemonState extends State<DetalhesMyPokemon> {
  late final PokemonRepositoryImpl pokemonsRepo;

  @override
  void initState() {
    super.initState();
    pokemonsRepo = Provider.of<PokemonRepositoryImpl>(context, listen: false);
  }

  void _showReleaseDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: 'Confirmar Ação',
      desc: 'Tem certeza que deseja soltar este Pokémon?',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        await pokemonsRepo.removeFromCache(widget.pokemon);
        Navigator.pop(context); // Fecha a tela de detalhes após soltar o Pokémon
      },
      btnOkText: "Sim",
      btnCancelText: "Cancelar",
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: Scaffold(
      appBar: AppBar(
        title: const Text("MyPokedex"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            if (widget.pokemon.imgUrl != null)
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.pokemon.imgUrl!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              const Icon(
                Icons.image_not_supported,
                size: 100,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 9, 8, 56).withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(31, 255, 255, 255),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nome: ${widget.pokemon.name} - HP: ${widget.pokemon.hp}",
                   textScaler: TextScaler.linear(1),
                  ),
                  const SizedBox(height: 4),
                  Text("Tipos: ${widget.pokemon.types.join(', ')}"),
                  const SizedBox(height: 4),
                  Text("Ataque: ${widget.pokemon.attack}"),
                  const SizedBox(height: 4),
                  Text("Defesa: ${widget.pokemon.defense}"),
                  const SizedBox(height: 4),
                  Text("SP Ataque: ${widget.pokemon.spAttack}"),
                  const SizedBox(height: 4),
                  Text("SP Defesa: ${widget.pokemon.spDefense}"),
                  const SizedBox(height: 4),
                  Text("Velocidade: ${widget.pokemon.speed}"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showReleaseDialog,
              child: const Text("Soltar"),
            ),
          ],
        ),
      ),
    ));
  }
}
