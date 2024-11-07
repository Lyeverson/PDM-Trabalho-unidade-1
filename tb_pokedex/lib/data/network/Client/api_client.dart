
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tb_pokedex/data/network/network_mapper.dart';
import '../../../domain/exception/network_exception.dart';
import '../entity/http_paged_result.dart';
import 'dart:convert';

class ApiClient {
  late final Dio _dio;

  ApiClient({required String baseUrl}) {
    _dio = Dio()
      ..options.baseUrl = baseUrl
      ..interceptors.add(
       LogInterceptor(
          requestBody: true,
          responseBody: true,
       ),
     );
  }

  /// Método para buscar todos os Pokémons com paginação
  Future<List<PokemonEntity>> getAll({int? page, int? limit}) async {
    try{
      final response = await _dio.get(
        '/pokedex',
        queryParameters: {
          '_page': page,
          '_per_page': limit,
        },
      );

      if (response.statusCode != null && response.statusCode! >= 400) {
        throw NetworkException(
          statusCode: response.statusCode!,
          message: response.statusMessage,
        );
      }

      else if (response.statusCode != null) {
         final HttpPagedResult receivedData = HttpPagedResult.fromJson(response.data as Map<String, dynamic>);
         return receivedData.data;
        
      }
      else {
      throw Exception('Unknown error');
    }
    }catch(e){
    print("erro buscar allpokemons: $e");
    return [];
    }
    } 
      

  /// Método para buscar os detalhes de um Pokémon específico por ID
  Future<PokemonEntity> fetchPokemonDetails(int id) async {
  final response = await _dio.get('/pokedex/$id');
    
 
   if (response.statusCode != null && response.statusCode! >= 400) {
        throw NetworkException(
          statusCode: response.statusCode!,
          message: response.statusMessage,
        );
      }

      else if (response.statusCode != null) {
        return PokemonEntity.fromJson(response.data as Map<String, dynamic>);
      }
      else{
       throw Exception('Unknown error');
      }
      
    
  }

  /// Método para buscar um Pokémon aleatório para a funcionalidade de Encontro Diário
  Future<PokemonEntity> fetchRandomPokemon() async {
  
   final prefs = await SharedPreferences.getInstance();
   final ultimaVez = prefs.getInt('ultimaVez') ?? 0;
   final randomcache = prefs.getInt('randomId') ?? DateTime.now().millisecondsSinceEpoch % 809;
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  final UmMinuto = 60 * 1000;
  

  if (currentTime - ultimaVez >= UmMinuto) {
    
      final randomId = DateTime.now().millisecondsSinceEpoch % 809;
      
      final random = await fetchPokemonDetails(randomId);
      final randomPokemon = NetworkMapper().toPokemon(random);
      // Atualiza o timestamp da última vez que o Pokémon foi gerado
     await prefs.setInt('ultimaVez', currentTime);
     await prefs.setInt('randomId', randomId);


      await prefs.setInt('IDDiario', randomPokemon.id);
      await prefs.setString('imgUrlDiario', "${randomPokemon.imgUrl}");
      await prefs.setString('nameDiario', "${randomPokemon.name}");
      await prefs.setStringList('typesDiario', randomPokemon.types);
      await prefs.setInt('hpDiario', randomPokemon.hp);
      await prefs.setInt('attackDiario', randomPokemon.attack);
      await prefs.setInt('defenseDiario', randomPokemon.defense);
      await prefs.setInt('spAttackDiario', randomPokemon.spAttack);
      await prefs.setInt('spDefenseDiario', randomPokemon.spDefense);
      await prefs.setInt('speedDiario', randomPokemon.speed);
      return random;
     
     }else{
     final random  = await fetchPokemonDetails(randomcache);
      final randomPokemon = NetworkMapper().toPokemon(random);

      await prefs.setInt('IDDiario', randomPokemon.id);
       await prefs.setString('imgUrlDiario', "${randomPokemon.imgUrl}");
     await prefs.setString('nameDiario', "${randomPokemon.name}");
      await prefs.setStringList('typesDiario', randomPokemon.types);
      await prefs.setInt('hpDiario', randomPokemon.hp);
      await prefs.setInt('attackDiario', randomPokemon.attack);
      await prefs.setInt('defenseDiario', randomPokemon.defense);
      await prefs.setInt('spAttackDiario', randomPokemon.spAttack);
      await prefs.setInt('spDefenseDiario', randomPokemon.spDefense);
      await prefs.setInt('speedDiario', randomPokemon.speed);
     return random;
     
     }
     
     
  }
}
