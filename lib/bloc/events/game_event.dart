abstract class GameEvent {}

class GameCellPressed extends GameEvent {
  final int row;
  final int cellPoint;

  GameCellPressed(this.row, this.cellPoint);
}

class GameRetryPressed extends GameEvent {}

class GameOver extends GameEvent {}
