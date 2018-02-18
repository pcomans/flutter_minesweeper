import 'package:flutter/foundation.dart';

class GameBoard {
  final List<bool> mines;
  final List<bool> flagged;
  final List<bool> revealed;
  final List<int> adjacentMines;
  final int numRows;
  final int numColumns;

  GameBoard({
    @required this.mines,
    @required this.flagged,
    @required this.revealed,
    @required this.adjacentMines,
    @required this.numRows,
    @required this.numColumns,
  });
}
