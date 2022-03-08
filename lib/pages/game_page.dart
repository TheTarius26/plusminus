import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plusminus/bloc/events/game_event.dart';
import 'package:plusminus/bloc/game_bloc.dart';
import 'package:plusminus/widgets/cell.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late AnimationController _timerController;
  late Animation<Duration> _timerAnimation;

  @override
  void initState() {
    super.initState();

    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 3),
    );

    _timerAnimation = Tween<Duration>(
      begin: const Duration(minutes: 3),
      end: Duration.zero,
    ).animate(_timerController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          context.read<GameBloc>().add(GameOver());
        }
      });

    _timerController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(GameState(
        difficulty: GameDifficulty.medium,
        player: 'Tarius',
      )),
      child: Scaffold(
        body: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Player: ${state.player}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Timer(timerAnimation: _timerAnimation),
                      Text(
                        'Lives: ${state.lives}',
                        style: const TextStyle(fontSize: 20),
                      ),
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
                        defaultColumnWidth: const FixedColumnWidth(50),
                        children: generateTableRow(context, state),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (state.isEnd)
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Restart'),
                    ),
                  const Spacer()
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<TableRow> generateTableRow(BuildContext context, GameState state) {
    List<TableRow> rows = [];
    for (int row = 0; row < state.gameTable.length; row++) {
      rows.add(TableRow(
        children: generateTableCell(context, state, row),
      ));
    }
    return rows;
  }

  List<Widget> generateTableCell(
    BuildContext context,
    GameState state,
    int rowIndex,
  ) {
    List<Widget> cells = [];
    final status = state.rowStatus[rowIndex];
    final row = state.gameTable[rowIndex];

    void onClickCell(int cellPoint) {
      context.read<GameBloc>().add(GameCellPressed(rowIndex, cellPoint));
      setState(() {});
      if (rowIndex == state.matrix) {
        _timerController.stop();
      }
    }

    for (var cell in row) {
      cells.add(
        Cell(
          content: GestureDetector(
            onTap: status == CellStatus.active || state.isEnd
                ? () {
                    onClickCell(cell);
                  }
                : null,
            child: Container(
              decoration: BoxDecoration(
                color:
                    status == CellStatus.inactive ? Colors.grey : Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "$cell",
                    style: TextStyle(
                        color: status == CellStatus.inactive
                            ? Colors.grey
                            : Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return cells;
  }
}

class Timer extends StatelessWidget {
  final Animation<Duration> timerAnimation;

  const Timer({
    Key? key,
    required this.timerAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: timerAnimation,
      builder: (context, child) {
        return Text(
          'Time: ${timerAnimation.value.inMinutes}:${timerAnimation.value.inSeconds % 60}',
          style: const TextStyle(fontSize: 20),
        );
      },
    );
  }
}
