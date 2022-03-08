import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plusminus/helper/game_setup.dart';

enum GameCellStatus { active, inactive, selected }
enum GameDifficulty { easy, medium, hard }

abstract class GameState {}

class GameInitialState extends GameState {
  GameDifficulty difficulty;
  String playerName;
  int matrix;
  List<GameCellStatus> cellStatus;
  List<List<int>> contentCells;
  int point;

  GameInitialState({
    this.difficulty = GameDifficulty.easy,
    this.playerName = '',
    this.matrix = 0,
    this.cellStatus = const [],
    this.contentCells = const [],
    this.point = 0,
  });
}

abstract class GameEvent {}

class GameStarted extends GameEvent {
  final GameDifficulty difficulty;
  final String playerName;

  GameStarted({
    required this.difficulty,
    required this.playerName,
  });
}

class GameCellPressed extends GameEvent {
  final int rowIndex;

  GameCellPressed({
    required this.rowIndex,
  });
}

class GameBloc extends Bloc<GameEvent, GameInitialState> {
  GameBloc() : super(GameInitialState()) {
    on<GameStarted>((event, emit) {
      state.playerName = event.playerName;
      if (event.difficulty == GameDifficulty.easy) {
        state.difficulty = GameDifficulty.easy;
        state.matrix = 3;
        setUpCells();
      } else if (event.difficulty == GameDifficulty.medium) {
        state.difficulty = GameDifficulty.medium;
        state.matrix = 4;
        setUpCells();
      } else if (event.difficulty == GameDifficulty.hard) {
        state.difficulty = GameDifficulty.hard;
        state.matrix = 5;
        setUpCells();
      }
    });

    on<GameCellPressed>((event, emit) {
      if (state.cellStatus[event.rowIndex] == GameCellStatus.active) {
        state.cellStatus[event.rowIndex] = GameCellStatus.selected;
        try {
          state.cellStatus[event.rowIndex + 1] = GameCellStatus.active;
        } on RangeError {
          // do nothing
        }
      }
      emit(state);
    });
  }

  void setUpCells() {
    state.point = randomNumber();
    state.cellStatus =
        List.generate(state.matrix, (index) => GameCellStatus.inactive);
    state.cellStatus[0] = GameCellStatus.active;
    List<int> correctList = listCorrect(state.point, state.matrix);

    state.contentCells = List.generate(state.matrix, (index) {
      final list = List.generate(state.matrix - 1, (index) {
        return seedTableGenerator(state.point);
      });
      list
        ..add(correctList[index])
        ..shuffle();
      return list;
    });

    print(state.contentCells.toString());
  }
}
