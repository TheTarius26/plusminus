import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plusminus/bloc/events/game_event.dart';
import 'package:plusminus/bloc/game_bloc.dart';
import 'package:plusminus/bloc/states/game_state.dart';
import 'package:plusminus/data/model/cell.dart';
import 'package:plusminus/data/model/cell_status.dart';

class CellWidget extends StatefulWidget {
  final CellStatus status;
  final int value;
  final int row;
  final void Function() onTap;

  const CellWidget({
    Key? key,
    required this.status,
    required this.value,
    required this.row,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CellWidget> createState() => _CellWidgetState();

  static List<TableRow> cellToTable(GameLoadSuccess state) {
    final table = state.listCell
        .map(
          (e) => TableRow(
            children: e
                .map(
                  (e) => CellWidget(
                      status: e.status,
                      value: e.value,
                      row: e.row,
                      onTap: () {
                        state.point--;
                      }),
                )
                .toList(),
          ),
        )
        .toList();

    print(table);
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

  void Function()? isStatusActive() {
    return widget.status == CellStatus.active ? widget.onTap : null;
  }

  Color isSelected() {
    return widget.status == CellStatus.selected ? Colors.blue : Colors.white;
  }
}
