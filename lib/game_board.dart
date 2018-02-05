import 'package:flutter/foundation.dart';
import 'helpers.dart';

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
      _boardTiles[mineIndex].setHasMine(true);
    });

    _updateAdjecentMines();
  }

  List<GameTile> get boardTiles => _boardTiles;

  void _updateAdjecentMines() {
    _boardTiles.forEach((tile) {
      if (!tile._hasMine) {
        tile.numAdjecentMines = _getNumAdjecentMines(tile);
      }
    });
  }

  int _getNumAdjecentMines(GameTile tile) {
    List<int> neighborIdxs = getNeighborIdxs(tile.index, numRows, numColumns);
    return neighborIdxs.where((idx) => _boardTiles[idx]._hasMine).length;
  }
}

class GameTile {
  final int index;
  int numAdjecentMines;

  GameTile(this.index);

  bool _hasMine = false;
  bool _flagged = false;
  bool _isRevealed = false;

  void setHasMine(bool hm) {
    _hasMine = hm;
  }

  void toggleFlagged() {
    _flagged = !_flagged;
  }

  void setRevealed() {
    _isRevealed = true;
  }

  bool get isFlagged => _flagged;
  bool get hasMine => _hasMine;
  bool get isRevealed => _isRevealed;
}
