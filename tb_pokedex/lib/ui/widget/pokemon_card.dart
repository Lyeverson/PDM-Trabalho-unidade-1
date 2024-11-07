import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tb_pokedex/ui/page/detalhes_my_pokemon.dart';
import 'package:tb_pokedex/ui/page/detalhes_pokemon.dart';

import '../../domain/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;


  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          // Navega para a ttela de detalhes do pokemon
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetalhesPokemon(pokemon: pokemon)),
          );
        },
        child: Card(
          elevation: 5,
          child: Row(
            children: [
              if (pokemon.imgUrl != null)
                Container(
                  
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 100,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(imageUrl: pokemon.imgUrl),
                    ),
                  ),
                )
              else
                const Icon(
                  Icons.image_not_supported,
                  size: 100,
                  color: Colors.black,
                ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 8,
                    right: 8,
                    bottom: 8,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "nome: ${pokemon.name} hp: ${pokemon.hp}",
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "tipos: ${pokemon.types.join(', ')}",
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        "ataque: ${pokemon.attack}",
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
