import 'package:json_annotation/json_annotation.dart';

part 'http_paged_result.g.dart';

@JsonSerializable()
class HttpPagedResult {
  int first;
  dynamic prev;
  int next;
  int last;
  int pages;
  int items;
  List<PokemonEntity> data;

  HttpPagedResult({
    required this.first,
    required this.prev,
    required this.next,
    required this.last,
    required this.pages,
    required this.items,
    required this.data,
  });

  factory HttpPagedResult.fromJson(Map<String, dynamic> json) => _$HttpPagedResultFromJson(json);
}

@JsonSerializable()
class PokemonEntity {
  int id;
  Map<String, String> name; 
  List<String> type;
  Map<String, int> base; 

  PokemonEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.base,
  });

  factory PokemonEntity.fromJson(Map<String, dynamic> json) => _$PokemonEntityFromJson(json);

  @override
  String toString() {
    return 'PokemonEntity{name: $name, id: $id}';
  }
}