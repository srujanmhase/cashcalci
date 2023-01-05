import 'package:freezed_annotation/freezed_annotation.dart';

part 'symbols.freezed.dart';
part 'symbols.g.dart';

@Freezed()
class Symbols with _$Symbols {
  const factory Symbols({
    required Map<String, String> symbols,
  }) = _Symbols;

  factory Symbols.fromJson(Map<String, dynamic> json) =>
      _$SymbolsFromJson(json);
}
