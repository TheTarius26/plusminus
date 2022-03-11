abstract class GameEvent {}

class GameCellPressed extends GameEvent {
  final int row, value, cellId;

  GameCellPressed(this.cellId, this.row, this.value);
}

class GameRetryPressed extends GameEvent {}

class GameOver extends GameEvent {}
