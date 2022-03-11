import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plusminus/bloc/events/game_event.dart';
import 'package:plusminus/bloc/game_bloc.dart';
import 'package:plusminus/data/model/cell.dart';

class CellWidget extends StatefulWidget {
  final int cellId;
  final CellStatus status;
  final int value;
  final int row;

  const CellWidget({
    Key? key,
    required this.cellId,
    required this.status,
    required this.value,
    required this.row,
  }) : super(key: key);

  @override
  State<CellWidget> createState() => _CellWidgetState();

  static List<TableRow> cellToTable(GameState state) {
    List<TableRow> table = [];
    int cellIndex = 0;

    List<Cell> cells = state.cells;

    for (int row = 0; row < state.matrix; row++) {
      List<CellWidget> rowCells = [];
      for (int col = 0; col < state.matrix; col++) {
        Cell cell = cells[cellIndex];
        rowCells.add(CellWidget(
          cellId: cellIndex,
          status: cell.status,
          value: cell.value,
          row: cell.row,
        ));
        cellIndex++;
      }
      print(rowCells.map((e) => e.status).toList());
      table.add(TableRow(children: rowCells));
    }

    return table;
  }
}

class _CellWidgetState extends State<CellWidget> {
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: GestureDetector(
        onTap: isStatusActive,
        child: Container(
          color: isSelected(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('${widget.value}'),
            ),
          ),
        ),
      ),
    );
  }

  void onClickCell() {
    context
        .read<GameBloc>()
        .add(GameCellPressed(widget.cellId, widget.row, widget.value));
  }

  void Function()? isStatusActive() {
    return widget.status == CellStatus.active ? onClickCell : null;
  }

  Color isSelected() {
    return widget.status == CellStatus.selected ? Colors.blue : Colors.white;
  }
}
