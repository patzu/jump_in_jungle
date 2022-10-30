// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'score_overlay_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ScoreOverlayState {
  int get highScore => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get lives => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScoreOverlayStateCopyWith<ScoreOverlayState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreOverlayStateCopyWith<$Res> {
  factory $ScoreOverlayStateCopyWith(
          ScoreOverlayState value, $Res Function(ScoreOverlayState) then) =
      _$ScoreOverlayStateCopyWithImpl<$Res, ScoreOverlayState>;
  @useResult
  $Res call({int highScore, int score, int lives});
}

/// @nodoc
class _$ScoreOverlayStateCopyWithImpl<$Res, $Val extends ScoreOverlayState>
    implements $ScoreOverlayStateCopyWith<$Res> {
  _$ScoreOverlayStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? highScore = null,
    Object? score = null,
    Object? lives = null,
  }) {
    return _then(_value.copyWith(
      highScore: null == highScore
          ? _value.highScore
          : highScore // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      lives: null == lives
          ? _value.lives
          : lives // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ScoreOverlayStateCopyWith<$Res>
    implements $ScoreOverlayStateCopyWith<$Res> {
  factory _$$_ScoreOverlayStateCopyWith(_$_ScoreOverlayState value,
          $Res Function(_$_ScoreOverlayState) then) =
      __$$_ScoreOverlayStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int highScore, int score, int lives});
}

/// @nodoc
class __$$_ScoreOverlayStateCopyWithImpl<$Res>
    extends _$ScoreOverlayStateCopyWithImpl<$Res, _$_ScoreOverlayState>
    implements _$$_ScoreOverlayStateCopyWith<$Res> {
  __$$_ScoreOverlayStateCopyWithImpl(
      _$_ScoreOverlayState _value, $Res Function(_$_ScoreOverlayState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? highScore = null,
    Object? score = null,
    Object? lives = null,
  }) {
    return _then(_$_ScoreOverlayState(
      highScore: null == highScore
          ? _value.highScore
          : highScore // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      lives: null == lives
          ? _value.lives
          : lives // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ScoreOverlayState implements _ScoreOverlayState {
  const _$_ScoreOverlayState(
      {this.highScore = 0, this.score = 0, this.lives = 5});

  @override
  @JsonKey()
  final int highScore;
  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final int lives;

  @override
  String toString() {
    return 'ScoreOverlayState(highScore: $highScore, score: $score, lives: $lives)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScoreOverlayState &&
            (identical(other.highScore, highScore) ||
                other.highScore == highScore) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.lives, lives) || other.lives == lives));
  }

  @override
  int get hashCode => Object.hash(runtimeType, highScore, score, lives);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScoreOverlayStateCopyWith<_$_ScoreOverlayState> get copyWith =>
      __$$_ScoreOverlayStateCopyWithImpl<_$_ScoreOverlayState>(
          this, _$identity);
}

abstract class _ScoreOverlayState implements ScoreOverlayState {
  const factory _ScoreOverlayState(
      {final int highScore,
      final int score,
      final int lives}) = _$_ScoreOverlayState;

  @override
  int get highScore;
  @override
  int get score;
  @override
  int get lives;
  @override
  @JsonKey(ignore: true)
  _$$_ScoreOverlayStateCopyWith<_$_ScoreOverlayState> get copyWith =>
      throw _privateConstructorUsedError;
}
