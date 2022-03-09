abstract class GameEvent {}

class GameCellPressed extends GameEvent {
  final int row, cell, value;

  GameCellPressed(this.row, this.cell, this.value);
}

class GameRetryPressed extends GameEvent {}

class GameOver extends GameEvent {}
