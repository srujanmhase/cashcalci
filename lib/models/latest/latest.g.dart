// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Latest _$$_LatestFromJson(Map<String, dynamic> json) => _$_Latest(
      rates: (json['rates'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      timestamp: json['timestamp'] as int,
    );

Map<String, dynamic> _$$_LatestToJson(_$_Latest instance) => <String, dynamic>{
      'rates': instance.rates,
      'timestamp': instance.timestamp,
    };
