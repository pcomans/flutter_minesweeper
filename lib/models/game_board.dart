import '../helpers.dart';
import 'game_tile.dart';

class GameBoard {
  List<GameTile> _boardTiles;
  final int numRows;
  final int numColumns;
  final int numMines;

  GameBoard(this.numRows, this.numColumns, this.numMines) {
    _boardTiles = new List<GameTile>.generate(
        numRows * numColumns, (int index) => new GameTile(index));

    List<int> mineLocations =
        new List<int>.generate(numRows * numColumns, (int index) => index);

    mineLocations.shuffle();
    mineLocations.take(numMines).forEach((mineIndex) {
      _boardTiles[mineIndex].hasMine = true;
    });

    _updateAdjecentMines();
  }

  GameBoard.withTiles(
    this.numRows,
    this.numColumns,
    this.numMines,
    this._boardTiles,
  );

  List<GameTile> get boardTiles => _boardTiles;

  void _updateAdjecentMines() {
    _boardTiles.forEach((tile) {
      if (!tile.hasMine) {
        tile.numAdjecentMines = _getNumAdjecentMines(tile);
      }
    });
  }

  int _getNumAdjecentMines(GameTile tile) {
    List<int> neighborIdxs = getNeighborIdxs(tile.index, numRows, numColumns);
    return neighborIdxs.where((idx) => _boardTiles[idx].hasMine).length;
  }
}