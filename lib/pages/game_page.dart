import 'package:flutter/material.dart';
import 'package:plusminus/helper/number_generator.dart';
import 'package:plusminus/widgets/cell.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Table(
          border: TableBorder.all(color: Colors.black),
          defaultColumnWidth: const FixedColumnWidth(40),
          children: generateTableRow(4),
        ),
      ),
    );
  }

  List<TableRow> generateTableRow(int matrix) {
    List<TableRow> tableRows = [];
    for (int i = 0; i < matrix; i++) {
      tableRows.add(TableRow(
        children: generateTableCell(matrix),
      ));
    }
    return tableRows;
  }

  List<Cell> generateTableCell(int matrix) {
    List<Cell> tableCells = [];
    for (int i = 0; i < matrix; i++) {
      tableCells.add(Cell(
        content: randomGenerator(20),
      ));
    }
    return tableCells;
  }
}
