// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sound_manager_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SoundManagerState {
  bool get bgmStatus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SoundManagerStateCopyWith<SoundManagerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SoundManagerStateCopyWith<$Res> {
  factory $SoundManagerStateCopyWith(
          SoundManagerState value, $Res Function(SoundManagerState) then) =
      _$SoundManagerStateCopyWithImpl<$Res, SoundManagerState>;
  @useResult
  $Res call({bool bgmStatus});
}

/// @nodoc
class _$SoundManagerStateCopyWithImpl<$Res, $Val extends SoundManagerState>
    implements $SoundManagerStateCopyWith<$Res> {
  _$SoundManagerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bgmStatus = null,
  }) {
    return _then(_value.copyWith(
      bgmStatus: null == bgmStatus
          ? _value.bgmStatus
          : bgmStatus // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SoundManagerStateCopyWith<$Res>
    implements $SoundManagerStateCopyWith<$Res> {
  factory _$$_SoundManagerStateCopyWith(_$_SoundManagerState value,
          $Res Function(_$_SoundManagerState) then) =
      __$$_SoundManagerStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool bgmStatus});
}

/// @nodoc
class __$$_SoundManagerStateCopyWithImpl<$Res>
    extends _$SoundManagerStateCopyWithImpl<$Res, _$_SoundManagerState>
    implements _$$_SoundManagerStateCopyWith<$Res> {
  __$$_SoundManagerStateCopyWithImpl(
      _$_SoundManagerState _value, $Res Function(_$_SoundManagerState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bgmStatus = null,
  }) {
    return _then(_$_SoundManagerState(
      bgmStatus: null == bgmStatus
          ? _value.bgmStatus
          : bgmStatus // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SoundManagerState implements _SoundManagerState {
  const _$_SoundManagerState({this.bgmStatus = false});

  @override
  @JsonKey()
  final bool bgmStatus;

  @override
  String toString() {
    return 'SoundManagerState(bgmStatus: $bgmStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SoundManagerState &&
            (identical(other.bgmStatus, bgmStatus) ||
                other.bgmStatus == bgmStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bgmStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SoundManagerStateCopyWith<_$_SoundManagerState> get copyWith =>
      __$$_SoundManagerStateCopyWithImpl<_$_SoundManagerState>(
          this, _$identity);
}

abstract class _SoundManagerState implements SoundManagerState {
  const factory _SoundManagerState({final bool bgmStatus}) =
      _$_SoundManagerState;

  @override
  bool get bgmStatus;
  @override
  @JsonKey(ignore: true)
  _$$_SoundManagerStateCopyWith<_$_SoundManagerState> get copyWith =>
      throw _privateConstructorUsedError;
}
