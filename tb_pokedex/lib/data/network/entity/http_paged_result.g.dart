// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_paged_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpPagedResult _$HttpPagedResultFromJson(Map<String, dynamic> json) =>
    HttpPagedResult(
      first: (json['first'] as num).toInt(),
      prev: json['prev'],
      next: (json['next'] as num).toInt(),
      last: (json['last'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
      items: (json['items'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => PokemonEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HttpPagedResultToJson(HttpPagedResult instance) =>
    <String, dynamic>{
      'first': instance.first,
      'prev': instance.prev,
      'next': instance.next,
      'last': instance.last,
      'pages': instance.pages,
      'items': instance.items,
      'data': instance.data,
    };

PokemonEntity _$PokemonEntityFromJson(Map<String, dynamic> json) =>
    PokemonEntity(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      name: Map<String, String>.from(json['name'] as Map),
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      base: Map<String, int>.from(json['base'] as Map),
    );

Map<String, dynamic> _$PokemonEntityToJson(PokemonEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'base': instance.base,
    };
