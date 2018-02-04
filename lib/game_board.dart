class GameBoard {
  List<GameTile> _boardTiles;

  GameBoard(int rows, int columns, int mines) {
    _boardTiles = new List<GameTile>.generate(
        rows * columns, (int index) => new GameTile(index));

    List<int> mineLocations =
        new List<int>.generate(rows * columns, (int index) => index);

    mineLocations.shuffle();
    mineLocations.take(mines).forEach((mineIndex) {
      _boardTiles[mineIndex].setMine(true);
    });

    print(_boardTiles);
  }

  List<GameTile> get boardTiles => _boardTiles;
}

class GameTile {
  final int index;

  GameTile(this.index);

  bool _hasMine = false;
  bool _flagged = false;

  void setMine(bool hm) {
    _hasMine = hm;
  }

  void toggleFlagged() {
    _flagged = !_flagged;
  }

  bool get flagged => _flagged;
  bool get getMine => _hasMine;
}
