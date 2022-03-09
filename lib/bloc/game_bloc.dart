import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plusminus/bloc/events/game_event.dart';
import 'package:plusminus/data/model/cell.dart';
import 'package:plusminus/helper/game_setup.dart';

enum CellStatus { active, inactive, selected }
enum GameDifficulty { easy, medium, hard }

class GameState {
  GameDifficulty difficulty;
  List<Cell> cells;
  String player;
  int point, matrix, lives;
  bool isWin, isEnd;

  GameState({
    required this.player,
    required this.difficulty,
    this.cells = const [],
    this.point = 0,
    this.matrix = 0,
    this.lives = 3,
    this.isWin = false,
    this.isEnd = false,
  });
}

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(GameState state) : super(state) {
    _gameSetup();
    state.cells = _generateGameCells();
    // on<GameCellPressed>(_onGameCellPressed);
    on<GameRetryPressed>(_onGameRetryPressed);
    on<GameOver>(_onGameEnded);
  }

  @override
  void onChange(Change<GameState> change) {
    super.onChange(change);
  }

  void _gameSetup() {
    if (state.difficulty == GameDifficulty.easy) {
      state.matrix = 3;
      state.point = 100;
    } else if (state.difficulty == GameDifficulty.medium) {
      state.matrix = 4;
      state.point = 1000;
    } else if (state.difficulty == GameDifficulty.hard) {
      state.matrix = 5;
      state.point = 10000000;
    }
    state.isEnd = false;
  }

  List<Cell> _generateGameCells() {
    List<int> correctList = listCorrect(state.point, state.matrix);
    List<Cell> cells = [];

    for (int row = 0; row < state.matrix; row++) {
      final tempCells = List<Cell>.generate(
        state.matrix,
        (cell) => Cell(
          id: "$row-$cell",
          row: row,
          status: CellStatus.inactive,
          value: correctList[row * state.matrix + cell],
        ),
      );
      tempCells.shuffle();
      cells.addAll(tempCells);
    }

    for (int i = 0; i < state.matrix; i++) {
      cells[i].status = CellStatus.active;
    }

    print('cells: ${cells}');
    print('listCorrect: ${correctList}');
    return cells;
  }

  void _onGameCellPressed(GameCellPressed event, Emitter<GameState> emit) {
    state.cells[event.cell].status = CellStatus.selected;
    state.point -= event.value;
    emit(state);
  }

  void _onGameEnded(GameOver event, Emitter<GameState> emit) {
    state.isEnd = true;
    if (state.point == 0) {
      state.isWin = true;
      emit(state);
    } else {
      emit(state);
    }
  }

  void _onGameRetryPressed(GameRetryPressed event, Emitter<GameState> emit) {
    state.lives--;
    _gameSetup();
    emit(state);
  }
}
