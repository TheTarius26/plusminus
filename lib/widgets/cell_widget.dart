import 'package:flutter/material.dart';
import 'package:plusminus/bloc/game_bloc.dart';

class CellWidget extends StatelessWidget {
  final CellStatus status;
  final int value;

  const CellWidget({
    Key? key,
    required this.status,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          color: status == CellStatus.selected ? Colors.blue : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('$value'),
            ),
          ),
        ),
      ),
    );
  }

  static List<CellWidget> generateCell(GameState state) {
    final List<CellWidget> cells = [];
    for (int i = 0; i < state.matrix; i++) {
      for (int j = 0; j < state.matrix; j++) {}
    }
    return cells;
  }
}
