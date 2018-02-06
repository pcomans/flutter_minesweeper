class GameTile {
  final int index;
  int numAdjecentMines;

  GameTile(this.index);

  bool hasMine = false;
  bool flagged = false;
  bool isRevealed = false;
}
