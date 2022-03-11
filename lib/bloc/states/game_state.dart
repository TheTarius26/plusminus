import 'package:flutter/cupertino.dart';
import 'package:plusminus/data/model/cell.dart';
import 'package:plusminus/data/model/game_difficulty.dart';

abstract class GameState {}

class GameInitial extends GameState {
  final GameDifficulty difficulty;

  GameInitial({
    required this.difficulty,
  });
}

class GameLoadInProgress extends GameState {
  final int point, matrix;

  GameLoadInProgress({
    required this.point,
    required this.matrix,
  });
}

class GameLoadSuccess extends GameState {
  final List<List<Cell>> listCell;
  int point;

  GameLoadSuccess({
    required this.listCell,
    required this.point,
  });
}

class GameEndInProgress extends GameState {}

class GameEndSuccess extends GameState {}
