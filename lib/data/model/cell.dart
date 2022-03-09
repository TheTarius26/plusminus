import 'package:plusminus/bloc/game_bloc.dart';

class Cell {
  String id;
  int row;
  int value;
  CellStatus status;

  Cell({
    required this.id,
    required this.row,
    required this.value,
    required this.status,
  });
}
