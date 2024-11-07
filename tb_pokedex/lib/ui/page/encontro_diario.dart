import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tb_pokedex/data/repository/pokemon_repository_impl.dart';
import 'package:tb_pokedex/domain/pokemon.dart';

class EncontroDiario extends StatefulWidget {
  const EncontroDiario({super.key});

  @override
  State<EncontroDiario> createState() => _EncontroDiarioState();
}

class _EncontroDiarioState extends State<EncontroDiario> {
  late final PokemonRepositoryImpl pokemonsRepo;
  late SharedPreferences _prefs;
  late final int ultimaVez;
  late final List<String> tamLista;

  @override
  void initState() {
    super.initState();
    pokemonsRepo = Provider.of<PokemonRepositoryImpl>(context, listen: false);
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    ultimaVez = _prefs.getInt('ultimaVez') ?? 0;
    tamLista = _prefs.getStringList("myIds") ?? [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home:  Scaffold(
      appBar: AppBar(
        title: const Text("Pokémon Aleatório"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
      ),
      body: FutureBuilder<Pokemon>(
        future: pokemonsRepo.getRandomPokemon(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final pokemon = snapshot.data!;
          }

          return Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                if (_prefs.getString('imgUrlDiario') != null)
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
                        imageUrl: _prefs.getString('imgUrlDiario')!,
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
                        "Nome: ${_prefs.getString('nameDiario')} HP: ${_prefs.getInt('hpDiario')}",
                       textScaler: TextScaler.linear(1),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Tipos: ${_prefs.getStringList('typesDiario')?.join(', ') ?? ''}",
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Ataque: ${_prefs.getInt('attackDiario')}",
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Defesa: ${_prefs.getInt('defenseDiario')}",
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "SP Ataque: ${_prefs.getInt('spAttackDiario')}",
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "SP Defesa: ${_prefs.getInt('spDefenseDiario')}",
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Velocidade: ${_prefs.getInt('speedDiario')}",
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    print('${tamLista.length}');
                    if (DateTime.now().millisecondsSinceEpoch - ultimaVez >= 60 * 1000) {
                      pokemonsRepo.savePokemonToCache(Pokemon(
                        id: _prefs.getInt('IDDiario')!,
                        name: _prefs.getString('nameDiario')!,
                        types: _prefs.getStringList('typesDiario')!,
                        hp: _prefs.getInt('hpDiario')!,
                        attack: _prefs.getInt('attackDiario')!,
                        defense: _prefs.getInt('defenseDiario')!,
                        spAttack: _prefs.getInt('spAttackDiario')!,
                        spDefense: _prefs.getInt('spDefenseDiario')!,
                        speed: _prefs.getInt('speedDiario')!,
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color.fromARGB(225, 29, 236, 2),
                          content: const Text('Pokémon adicionado'),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    } else if (tamLista.length >= 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color(0xE2EC0202),
                          content: const Text('Número máximo de Pokémons atingido!'),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: const Text("Capturar"),
                ),
              ],
            ),
          );
        },
      ),
    ));
  }
}

