// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChangeRouteState {
  ChangeRouteType get routeType => throw _privateConstructorUsedError;
  String get routeName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChangeRouteStateCopyWith<ChangeRouteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeRouteStateCopyWith<$Res> {
  factory $ChangeRouteStateCopyWith(
          ChangeRouteState value, $Res Function(ChangeRouteState) then) =
      _$ChangeRouteStateCopyWithImpl<$Res, ChangeRouteState>;
  @useResult
  $Res call({ChangeRouteType routeType, String routeName});
}

/// @nodoc
class _$ChangeRouteStateCopyWithImpl<$Res, $Val extends ChangeRouteState>
    implements $ChangeRouteStateCopyWith<$Res> {
  _$ChangeRouteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routeType = null,
    Object? routeName = null,
  }) {
    return _then(_value.copyWith(
      routeType: null == routeType
          ? _value.routeType
          : routeType // ignore: cast_nullable_to_non_nullable
              as ChangeRouteType,
      routeName: null == routeName
          ? _value.routeName
          : routeName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangeRouteStateImplCopyWith<$Res>
    implements $ChangeRouteStateCopyWith<$Res> {
  factory _$$ChangeRouteStateImplCopyWith(_$ChangeRouteStateImpl value,
          $Res Function(_$ChangeRouteStateImpl) then) =
      __$$ChangeRouteStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChangeRouteType routeType, String routeName});
}

/// @nodoc
class __$$ChangeRouteStateImplCopyWithImpl<$Res>
    extends _$ChangeRouteStateCopyWithImpl<$Res, _$ChangeRouteStateImpl>
    implements _$$ChangeRouteStateImplCopyWith<$Res> {
  __$$ChangeRouteStateImplCopyWithImpl(_$ChangeRouteStateImpl _value,
      $Res Function(_$ChangeRouteStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routeType = null,
    Object? routeName = null,
  }) {
    return _then(_$ChangeRouteStateImpl(
      routeType: null == routeType
          ? _value.routeType
          : routeType // ignore: cast_nullable_to_non_nullable
              as ChangeRouteType,
      routeName: null == routeName
          ? _value.routeName
          : routeName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChangeRouteStateImpl implements _ChangeRouteState {
  const _$ChangeRouteStateImpl(
      {this.routeType = ChangeRouteType.restoring, this.routeName = ''});

  @override
  @JsonKey()
  final ChangeRouteType routeType;
  @override
  @JsonKey()
  final String routeName;

  @override
  String toString() {
    return 'ChangeRouteState(routeType: $routeType, routeName: $routeName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeRouteStateImpl &&
            (identical(other.routeType, routeType) ||
                other.routeType == routeType) &&
            (identical(other.routeName, routeName) ||
                other.routeName == routeName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, routeType, routeName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeRouteStateImplCopyWith<_$ChangeRouteStateImpl> get copyWith =>
      __$$ChangeRouteStateImplCopyWithImpl<_$ChangeRouteStateImpl>(
          this, _$identity);
}

abstract class _ChangeRouteState implements ChangeRouteState {
  const factory _ChangeRouteState(
      {final ChangeRouteType routeType,
      final String routeName}) = _$ChangeRouteStateImpl;

  @override
  ChangeRouteType get routeType;
  @override
  String get routeName;
  @override
  @JsonKey(ignore: true)
  _$$ChangeRouteStateImplCopyWith<_$ChangeRouteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
