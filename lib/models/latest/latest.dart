import 'package:freezed_annotation/freezed_annotation.dart';

part 'latest.freezed.dart';
part 'latest.g.dart';

@Freezed()
class Latest with _$Latest {
  const factory Latest({
    required Map<String, double> rates,
    required int timestamp,
  }) = _Latest;

  factory Latest.fromJson(Map<String, dynamic> json) => _$LatestFromJson(json);
}
