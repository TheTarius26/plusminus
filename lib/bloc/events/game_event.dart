abstract class GameEvent {}

class GameCellPressed extends GameEvent {
  final int row;
  final int cellPoint;

  GameCellPressed(this.row, this.cellPoint);
}

class GameEnded extends GameEvent {
  final bool isWin;
  final bool isRestart;

  GameEnded(this.isWin, this.isRestart);
}
