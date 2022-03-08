import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      create: (context) => GameBloc(),
      child: Scaffold(
        body: BlocBuilder<GameBloc, GameInitialState>(
          builder: (context, state) {
            return Center(
              child: Table(
                border: TableBorder.all(color: Colors.black),
                defaultColumnWidth: const FixedColumnWidth(40),
                children: generateTableRow(context, state),
              ),
            );
          },
        ),
      ),
    );
  }

  List<TableRow> generateTableRow(
      BuildContext context, GameInitialState state) {
    List<TableRow> rows = [];
    for (int row = 0; row < state.contentCells.length; row++) {
      rows.add(TableRow(
        children: generateTableCell(
          context,
          state.contentCells[row],
          state.cellStatus,
          row,
        ),
      ));
    }
    return rows;
  }

  List<Widget> generateTableCell(
    BuildContext context,
    List<int> row,
    List<GameCellStatus> status,
    int rowIndex,
  ) {
    List<Widget> cells = [];

    void onClickCell() {
      context.read<GameBloc>().add(GameCellPressed(rowIndex: rowIndex));
      setState(() {});
    }

    for (int cell = 0; cell < row.length; cell++) {
      cells.add(
        Cell(
          content: GestureDetector(
            onTap: status[cell] == GameCellStatus.active ? onClickCell : null,
            child: Text(row[cell].toString()),
          ),
        ),
      );
    }
    return cells;
  }
}
