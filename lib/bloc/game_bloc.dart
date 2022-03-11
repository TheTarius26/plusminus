import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plusminus/bloc/events/game_event.dart';
import 'package:plusminus/bloc/states/game_state.dart';
import 'package:plusminus/data/model/cell.dart';
import 'package:plusminus/data/model/cell_status.dart';
import 'package:plusminus/data/model/game_difficulty.dart';
import 'package:plusminus/helper/game_setup.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(GameState initialState) : super(initialState) {
    on<GameStarted>(_onGameStarted);
    on<GameLoading>(_onLoading);
    on<GameRestartPressed>(_onRestart);
    // on<GameEnded>(_onGameEnded);
  }

  void _onGameStarted(GameStarted event, Emitter<GameState> emit) {
    if (state is GameInitial) {
      if (event.difficulty == GameDifficulty.easy) {
        emit(GameLoadInProgress(point: 100, matrix: 3));
      } else if (event.difficulty == GameDifficulty.medium) {
        emit(GameLoadInProgress(point: 1000, matrix: 4));
      } else if (event.difficulty == GameDifficulty.hard) {
        emit(GameLoadInProgress(point: 10000, matrix: 5));
      }
    }
  }

  void _onLoading(GameLoading event, Emitter<GameState> emit) {
    if (state is GameLoadInProgress) {
      emit(GameLoadSuccess(
        listCell: Cell.createTable(event.point, event.matrix),
        point: event.point,
      ));
    } else if (state is GameLoadSuccess) {}
  }

  void _onRestart(GameRestartPressed event, Emitter<GameState> emit) {
    if (state is GameLoadInProgress) {}
  }
}
