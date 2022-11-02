// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameState {
  JunglerGame? get gameRef => throw _privateConstructorUsedError;
  GameStateEnum get gameState => throw _privateConstructorUsedError;
  PlayerStateEnum get playerState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {JunglerGame? gameRef,
      GameStateEnum gameState,
      PlayerStateEnum playerState});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameRef = freezed,
    Object? gameState = null,
    Object? playerState = null,
  }) {
    return _then(_value.copyWith(
      gameRef: freezed == gameRef
          ? _value.gameRef
          : gameRef // ignore: cast_nullable_to_non_nullable
              as JunglerGame?,
      gameState: null == gameState
          ? _value.gameState
          : gameState // ignore: cast_nullable_to_non_nullable
              as GameStateEnum,
      playerState: null == playerState
          ? _value.playerState
          : playerState // ignore: cast_nullable_to_non_nullable
              as PlayerStateEnum,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$$_GameStateCopyWith(
          _$_GameState value, $Res Function(_$_GameState) then) =
      __$$_GameStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {JunglerGame? gameRef,
      GameStateEnum gameState,
      PlayerStateEnum playerState});
}

/// @nodoc
class __$$_GameStateCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$_GameState>
    implements _$$_GameStateCopyWith<$Res> {
  __$$_GameStateCopyWithImpl(
      _$_GameState _value, $Res Function(_$_GameState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameRef = freezed,
    Object? gameState = null,
    Object? playerState = null,
  }) {
    return _then(_$_GameState(
      gameRef: freezed == gameRef
          ? _value.gameRef
          : gameRef // ignore: cast_nullable_to_non_nullable
              as JunglerGame?,
      gameState: null == gameState
          ? _value.gameState
          : gameState // ignore: cast_nullable_to_non_nullable
              as GameStateEnum,
      playerState: null == playerState
          ? _value.playerState
          : playerState // ignore: cast_nullable_to_non_nullable
              as PlayerStateEnum,
    ));
  }
}

/// @nodoc

class _$_GameState implements _GameState {
  const _$_GameState(
      {this.gameRef,
      this.gameState = GameStateEnum.pause,
      this.playerState = PlayerStateEnum.alive});

  @override
  final JunglerGame? gameRef;
  @override
  @JsonKey()
  final GameStateEnum gameState;
  @override
  @JsonKey()
  final PlayerStateEnum playerState;

  @override
  String toString() {
    return 'GameState(gameRef: $gameRef, gameState: $gameState, playerState: $playerState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameState &&
            (identical(other.gameRef, gameRef) || other.gameRef == gameRef) &&
            (identical(other.gameState, gameState) ||
                other.gameState == gameState) &&
            (identical(other.playerState, playerState) ||
                other.playerState == playerState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gameRef, gameState, playerState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      __$$_GameStateCopyWithImpl<_$_GameState>(this, _$identity);
}

abstract class _GameState implements GameState {
  const factory _GameState(
      {final JunglerGame? gameRef,
      final GameStateEnum gameState,
      final PlayerStateEnum playerState}) = _$_GameState;

  @override
  JunglerGame? get gameRef;
  @override
  GameStateEnum get gameState;
  @override
  PlayerStateEnum get playerState;
  @override
  @JsonKey(ignore: true)
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      throw _privateConstructorUsedError;
}
