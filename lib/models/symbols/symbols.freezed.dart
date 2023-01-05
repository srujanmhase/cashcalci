// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'symbols.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Symbols _$SymbolsFromJson(Map<String, dynamic> json) {
  return _Symbols.fromJson(json);
}

/// @nodoc
mixin _$Symbols {
  Map<String, String> get symbols => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SymbolsCopyWith<Symbols> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SymbolsCopyWith<$Res> {
  factory $SymbolsCopyWith(Symbols value, $Res Function(Symbols) then) =
      _$SymbolsCopyWithImpl<$Res, Symbols>;
  @useResult
  $Res call({Map<String, String> symbols});
}

/// @nodoc
class _$SymbolsCopyWithImpl<$Res, $Val extends Symbols>
    implements $SymbolsCopyWith<$Res> {
  _$SymbolsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbols = null,
  }) {
    return _then(_value.copyWith(
      symbols: null == symbols
          ? _value.symbols
          : symbols // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SymbolsCopyWith<$Res> implements $SymbolsCopyWith<$Res> {
  factory _$$_SymbolsCopyWith(
          _$_Symbols value, $Res Function(_$_Symbols) then) =
      __$$_SymbolsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, String> symbols});
}

/// @nodoc
class __$$_SymbolsCopyWithImpl<$Res>
    extends _$SymbolsCopyWithImpl<$Res, _$_Symbols>
    implements _$$_SymbolsCopyWith<$Res> {
  __$$_SymbolsCopyWithImpl(_$_Symbols _value, $Res Function(_$_Symbols) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbols = null,
  }) {
    return _then(_$_Symbols(
      symbols: null == symbols
          ? _value._symbols
          : symbols // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Symbols implements _Symbols {
  const _$_Symbols({required final Map<String, String> symbols})
      : _symbols = symbols;

  factory _$_Symbols.fromJson(Map<String, dynamic> json) =>
      _$$_SymbolsFromJson(json);

  final Map<String, String> _symbols;
  @override
  Map<String, String> get symbols {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_symbols);
  }

  @override
  String toString() {
    return 'Symbols(symbols: $symbols)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Symbols &&
            const DeepCollectionEquality().equals(other._symbols, _symbols));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_symbols));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SymbolsCopyWith<_$_Symbols> get copyWith =>
      __$$_SymbolsCopyWithImpl<_$_Symbols>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SymbolsToJson(
      this,
    );
  }
}

abstract class _Symbols implements Symbols {
  const factory _Symbols({required final Map<String, String> symbols}) =
      _$_Symbols;

  factory _Symbols.fromJson(Map<String, dynamic> json) = _$_Symbols.fromJson;

  @override
  Map<String, String> get symbols;
  @override
  @JsonKey(ignore: true)
  _$$_SymbolsCopyWith<_$_Symbols> get copyWith =>
      throw _privateConstructorUsedError;
}
