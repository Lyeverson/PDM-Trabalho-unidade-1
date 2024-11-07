import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tb_pokedex/domain/pokemon.dart';

class DetalhesPokemon extends StatelessWidget {
  final Pokemon pokemon;

  const DetalhesPokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            if (pokemon.imgUrl != null)
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
                    imageUrl: pokemon.imgUrl!,
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
                color: Colors.black,
              ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color:const Color.fromARGB(255, 9, 8, 56).withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color:  const Color.fromARGB(31, 255, 255, 255),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nome: ${pokemon.name} HP: ${pokemon.hp}",
                    textScaler: TextScaler.linear(1),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Tipos: ${pokemon.types.join(', ')}",
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Ataque: ${pokemon.attack}",
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Defesa: ${pokemon.defense}",
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "SP Ataque: ${pokemon.spAttack}",
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "SP Defesa: ${pokemon.spDefense}",
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Velocidade: ${pokemon.speed}",
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
