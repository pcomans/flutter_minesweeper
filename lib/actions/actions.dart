class RevealTileAction {
  final int idx;

  RevealTileAction(this.idx);
}
class FlagTileAction {
  final int idx;

  FlagTileAction(this.idx);
}

class InitializeBoardAction {
  final int numRows;
  final int numColumns;
  final int numMines;
  final DateTime time;

  InitializeBoardAction(this.numRows, this.numColumns, this.numMines, this.time);
}