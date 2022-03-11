import 'package:plusminus/data/model/game_difficulty.dart';

abstract class GameEvent {}

class GameStarted extends GameEvent {
  final GameDifficulty difficulty;

  GameStarted(this.difficulty);
}

class GameLoading extends GameEvent {
  int point, matrix;

  GameLoading(this.point, this.matrix);
}

class GameRestartPressed extends GameEvent {}

class GameEndPressed extends GameEvent {}
