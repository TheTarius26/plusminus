import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plusminus/bloc/events/game_event.dart';
import 'package:plusminus/helper/game_setup.dart';

enum CellStatus { active, inactive, selected }
enum GameDifficulty { easy, medium, hard }

class GameState {
  GameDifficulty difficulty;
  List<List<int>> gameTable;
  List<CellStatus> rowStatus;
  String player;
  int point, matrix, retryPoint;
  bool isWin;

  GameState({
    required this.player,
    required this.difficulty,
    this.point = 0,
    this.matrix = 0,
    this.gameTable = const [],
    this.rowStatus = const [],
    this.retryPoint = 3,
    this.isWin = false,
  });
}

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(GameState state) : super(state) {
    _gameSetup();
    on<GameCellPressed>(_onGameCellPressed);
    on<GameEnded>(_onGameEnded);
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
      state.point = 10000;
    }
    _generateGameTable();
    _setRowStatus();
  }

  void _generateGameTable() {
    final correctList = listCorrect(state.point, state.matrix);
    state.gameTable = List.generate(state.matrix, (i) {
      final tempList = List.generate(state.matrix - 1, (j) {
        return seedTableGenerator(state.point);
      });
      tempList.add(correctList[i]);
      return tempList;
    });
  }

  void _setRowStatus() {
    state.rowStatus = List.generate(state.matrix, (i) {
      return CellStatus.inactive;
    });
    state.rowStatus.first = CellStatus.active;
  }

  void _onGameCellPressed(GameCellPressed event, Emitter<GameState> emit) {
    state.rowStatus[event.row] = CellStatus.selected;
    final nextRow =
        state.rowStatus.indexWhere((element) => element == CellStatus.inactive);
    if (nextRow != -1) {
      state.rowStatus[nextRow] = CellStatus.active;
    }
    state.point -= event.cellPoint;
    emit(state);
  }

  void _onGameEnded(GameEnded event, Emitter<GameState> emit) {
    if (state.point > 0 || state.point < 0) {
      state.retryPoint--;
      if (state.retryPoint == 0) {
        emit(state);
      } else {
        _gameSetup();
        emit(state);
      }
    } else if (state.point == 0) {
      state.isWin = true;
      emit(state);
    }
  }
}
