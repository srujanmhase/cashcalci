// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'latest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Latest _$LatestFromJson(Map<String, dynamic> json) {
  return _Latest.fromJson(json);
}

/// @nodoc
mixin _$Latest {
  Map<String, double> get rates => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LatestCopyWith<Latest> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatestCopyWith<$Res> {
  factory $LatestCopyWith(Latest value, $Res Function(Latest) then) =
      _$LatestCopyWithImpl<$Res, Latest>;
  @useResult
  $Res call({Map<String, double> rates, int timestamp});
}

/// @nodoc
class _$LatestCopyWithImpl<$Res, $Val extends Latest>
    implements $LatestCopyWith<$Res> {
  _$LatestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rates = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      rates: null == rates
          ? _value.rates
          : rates // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LatestCopyWith<$Res> implements $LatestCopyWith<$Res> {
  factory _$$_LatestCopyWith(_$_Latest value, $Res Function(_$_Latest) then) =
      __$$_LatestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, double> rates, int timestamp});
}

/// @nodoc
class __$$_LatestCopyWithImpl<$Res>
    extends _$LatestCopyWithImpl<$Res, _$_Latest>
    implements _$$_LatestCopyWith<$Res> {
  __$$_LatestCopyWithImpl(_$_Latest _value, $Res Function(_$_Latest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rates = null,
    Object? timestamp = null,
  }) {
    return _then(_$_Latest(
      rates: null == rates
          ? _value._rates
          : rates // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Latest implements _Latest {
  const _$_Latest(
      {required final Map<String, double> rates, required this.timestamp})
      : _rates = rates;

  factory _$_Latest.fromJson(Map<String, dynamic> json) =>
      _$$_LatestFromJson(json);

  final Map<String, double> _rates;
  @override
  Map<String, double> get rates {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rates);
  }

  @override
  final int timestamp;

  @override
  String toString() {
    return 'Latest(rates: $rates, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Latest &&
            const DeepCollectionEquality().equals(other._rates, _rates) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_rates), timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LatestCopyWith<_$_Latest> get copyWith =>
      __$$_LatestCopyWithImpl<_$_Latest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LatestToJson(
      this,
    );
  }
}

abstract class _Latest implements Latest {
  const factory _Latest(
      {required final Map<String, double> rates,
      required final int timestamp}) = _$_Latest;

  factory _Latest.fromJson(Map<String, dynamic> json) = _$_Latest.fromJson;

  @override
  Map<String, double> get rates;
  @override
  int get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$_LatestCopyWith<_$_Latest> get copyWith =>
      throw _privateConstructorUsedError;
}
