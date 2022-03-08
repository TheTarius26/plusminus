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

class _GamePageState extends State<GamePage> {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Player: ${state.player}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Score: ${state.point}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const Spacer(),
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
        children: generateTableCell(
          context,
          state.gameTable[row],
          state.rowStatus,
          row,
        ),
      ));
    }
    return rows;
  }

  List<Widget> generateTableCell(
    BuildContext context,
    List<int> row,
    List<CellStatus> status,
    int rowIndex,
  ) {
    List<Widget> cells = [];

    void onClickCell(int cellPoint) {
      context.read<GameBloc>().add(GameCellPressed(rowIndex, cellPoint));
      setState(() {});
    }

    for (var cell in row) {
      cells.add(
        Cell(
          content: GestureDetector(
            onTap: status[rowIndex] == CellStatus.active
                ? () {
                    onClickCell(cell);
                  }
                : null,
            child: Container(
              decoration: BoxDecoration(
                color: status[rowIndex] == CellStatus.inactive
                    ? Colors.grey
                    : Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "$cell",
                    style: TextStyle(
                        color: status[rowIndex] == CellStatus.inactive
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
