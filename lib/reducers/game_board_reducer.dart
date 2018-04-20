import 'package:minesweeper/actions/actions.dart';
import 'package:minesweeper/models/game_board.dart';
import 'package:minesweeper/reducers/helpers.dart';
import 'package:minesweeper/util.dart';
import 'package:redux/redux.dart';

final gameBoardReducer = combineReducers<GameBoard>([
  new TypedReducer<GameBoard, InitializeBoardAction>(_initializeBoard),
  new TypedReducer<GameBoard, RevealTileAction>(_revealTile),
  new TypedReducer<GameBoard, FlagTileAction>(_flagTile),
]);

GameBoard _initializeBoard(GameBoard board, InitializeBoardAction action) {
  int numElems = action.numColumns * action.numRows;

  List<bool> mines = new List<bool>.generate(
      numElems, (int index) => (index < action.numMines));
  mines.shuffle();

  List<bool> flagged = new List<bool>.generate(numElems, (int index) => false);
  List<bool> revealed = new List<bool>.generate(numElems, (int index) => false);

  List<int> adjacentMines = new List<int>.generate(numElems, (int index) {
    List<int> neighborIdxs = getNeighborIdxs(
      index,
      action.numRows,
      action.numColumns,
    );
    return neighborIdxs.where((idx) => mines[idx]).length;
  });

  return new GameBoard(
    mines: mines,
    flagged: flagged,
    revealed: revealed,
    adjacentMines: adjacentMines,
    numColumns: action.numColumns,
    numRows: action.numRows,
    createdAt: action.time,
  );
}

GameBoard _flagTile(GameBoard board, FlagTileAction action) {
  List<bool> newFlagged = mapWithIndex(board.flagged, ((tile, i) {
    return tile || (action.idx == i);
  })).toList(growable: false);

  return new GameBoard(
    mines: board.mines,
    flagged: newFlagged,
    revealed: board.revealed,
    numColumns: board.numColumns,
    numRows: board.numRows,
    adjacentMines: board.adjacentMines,
    createdAt: board.createdAt,
  );
}

GameBoard _revealTile(GameBoard board, RevealTileAction action) {
  List<bool> newRevealed = mapWithIndex(board.revealed, ((tile, i) {
    return tile || (action.idx == i);
  })).toList(growable: false);

  return new GameBoard(
    mines: board.mines,
    flagged: board.flagged,
    revealed: newRevealed,
    numColumns: board.numColumns,
    numRows: board.numRows,
    adjacentMines: board.adjacentMines,
    createdAt: board.createdAt,
  );
}
