import 'package:plusminus/data/model/cell_status.dart';
import 'package:plusminus/helper/game_setup.dart';

class Cell {
  int row;
  int value;
  CellStatus status;

  Cell({
    required this.row,
    required this.value,
    required this.status,
  });

  static List<List<Cell>> createTable(int point, int matrix) {
    final correctList = listCorrect(point, matrix);

    final List<List<Cell>> table = List.generate(matrix, (i) {
      final row = List.generate(
        matrix,
        (j) => Cell(
          row: i,
          value: valueCellGenerator(point, correctList, i, j),
          status: (i == 0) ? CellStatus.active : CellStatus.inactive,
        ),
      );

      row.shuffle();
      return row;
    });

    return table;
  }
}
