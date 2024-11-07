import 'package:freezed_annotation/freezed_annotation.dart';


part 'pokemon.freezed.dart';

@freezed
class Pokemon with _$Pokemon{

  const factory Pokemon({
    required int id,
    required String name,
    required List<String> types,
    required int hp,
    required int attack,
    required int defense,
    required int spAttack,
    required int spDefense,
    required int speed,
}) = _Pokemon;
  

const Pokemon._();

Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'types': types,
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'spAttack': spAttack,
      'spDefense': spDefense,
      'speed': speed,
    };
  }

   factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: List<String>.from(json['types']),
      hp: json['hp'],
      attack: json['attack'],
      defense: json['defense'],
      spAttack: json['spAttack'],
      spDefense: json['spDefense'],
      speed: json['speed'],
    );
  }

  String get imgUrl => _generateImgUrl(this.id);
  

  String _generateImgUrl(int id) {
    String img = 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/';
    if (id >= 0 && id < 10) {
      img = '${img}00$id.png';
    } else if (id >= 10 && id < 100) {
      img = '${img}0$id.png';
    } else if (id >= 100 && id < 1000) {
      img = '$img$id.png';
    }
    return img;
  }
}