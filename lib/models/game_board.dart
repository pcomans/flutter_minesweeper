import 'package:flutter/foundation.dart';
import 'package:minesweeper/util.dart';

class GameBoard {
  final List<bool> mines;
  final List<bool> flagged;
  final List<bool> revealed;
  final List<int> adjacentMines;
  final int numRows;
  final int numColumns;
  final DateTime createdAt;

  GameBoard({
    @required this.mines,
    @required this.flagged,
    @required this.revealed,
    @required this.adjacentMines,
    @required this.numRows,
    @required this.numColumns,
    @required this.createdAt,
  });
  int get flagsRemaining {
    int numMines = mines.where((hasMine) => hasMine).length;
    int numFlags = flagged.where((hasFlag) => hasFlag).length;

    return numMines - numFlags;
  }

  int get minesRemaining {
    return mapWithIndex(mines, (hasMine, idx) {
      return hasMine && !flagged[idx];
    }).where((hasUnflaggedMine) => hasUnflaggedMine).length;
  }

  int get minesRevealed {
    return mapWithIndex(mines, (hasMine, idx) {
      return hasMine && revealed[idx];
    }).where((hasRevealedMine) => hasRevealedMine).length;
  }

  GameStatus get gameStatus {
    if (minesRevealed > 0) {
      return GameStatus.lost;
    }
    if (minesRemaining == 0) {
      return GameStatus.won;
    }
    return GameStatus.ongoing;
  }
}

enum GameStatus {
  ongoing,
  won,
  lost,
}
