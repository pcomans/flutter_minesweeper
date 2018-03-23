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

  InitializeBoardAction(this.numRows, this.numColumns, this.numMines);
}