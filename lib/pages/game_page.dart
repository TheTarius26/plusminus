import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plusminus/bloc/events/game_event.dart';
import 'package:plusminus/bloc/game_bloc.dart';
import 'package:plusminus/bloc/states/game_state.dart';
import 'package:plusminus/data/model/cell_status.dart';
import 'package:plusminus/data/model/game_difficulty.dart';
import 'package:plusminus/widgets/cell_widget.dart';
import 'package:plusminus/widgets/timer.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _timerController;

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 3),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // BlocProvider.of<GameBloc>(context).add(GameOver());
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(GameInitial(
        difficulty: GameDifficulty.easy,
      )),
      child: Scaffold(
        body: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state is GameInitial) {
              context.read<GameBloc>().add(GameStarted(state.difficulty));
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GameLoadInProgress) {
              context
                  .read<GameBloc>()
                  .add(GameLoading(state.point, state.matrix));
            } else if (state is GameLoadSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Timer(timerController: _timerController, duration: 3),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${state.point}',
                          style: const TextStyle(fontSize: 40),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Table(
                          border: TableBorder.all(color: Colors.black),
                          defaultColumnWidth: const FixedColumnWidth(100),
                          children: CellWidget.cellToTable(state),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (state.point < 0)
                      ElevatedButton(
                        onPressed: () {
                          context.read<GameBloc>().add(GameRestartPressed());
                        },
                        child: const Text('Restart'),
                      ),
                    if (state.point == 0)
                      ElevatedButton(
                        onPressed: () {
                          context.read<GameBloc>().add(GameEndPressed());
                        },
                        child: const Text('Next'),
                      ),
                    const Spacer()
                  ],
                ),
              );
            } else if (state is GameEndInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GameEndSuccess) {
              return const Center(
                child: Text('Game Over'),
              );
            }
            return const Center(
              child: Text('Unknown state'),
            );
          },
        ),
      ),
    );
  }

  Color isSelected(CellStatus status) {
    return status == CellStatus.selected ? Colors.blue : Colors.white;
  }
}
