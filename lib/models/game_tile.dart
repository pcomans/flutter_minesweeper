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
