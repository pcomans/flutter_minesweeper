import 'package:flutter/material.dart';
import 'minesweeper_config_page.dart';
import 'models/game_board.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'helpers.dart';

void main() => runApp(new MyApp());

class RevealTileAction {
  final int idx;

  RevealTileAction(this.idx);
}

class InitializeBoardAction {
  final int numRows;
  final int numColumns;
  final int numMines;

  InitializeBoardAction(this.numRows, this.numColumns, this.numMines);
}

final gameBoardReducer = combineTypedReducers<GameBoard>([
  new ReducerBinding<GameBoard, InitializeBoardAction>(_initializeBoard),
  new ReducerBinding<GameBoard, RevealTileAction>(_revealTile),
]);

GameBoard _initializeBoard(GameBoard board, InitializeBoardAction action) {
  int numElems = action.numColumns * action.numRows;

  List<bool> mines = new List<bool>.generate(
      numElems, (int index) => (index < action.numMines));
  mines.shuffle();

  List<bool> flagged = new List<bool>.generate(numElems, (int index) => false);
  List<bool> revealed = new List<bool>.generate(numElems, (int index) => false);

  List<int> adjacentMines = new List<int>.generate(numElems, (int index) {
    List<int> neighborIdxs =
        getNeighborIdxs(index, action.numRows, action.numColumns);
    return neighborIdxs.where((idx) => mines[idx]).length;
  });

  return new GameBoard(
    mines: mines,
    flagged: flagged,
    revealed: revealed,
    adjacentMines: adjacentMines,
    numColumns: action.numColumns,
    numRows: action.numRows,
  );
}

GameBoard _revealTile(GameBoard board, RevealTileAction action) {
  int i = 0;
  List<bool> newRevealed = board.revealed.map((tile) {
    i++;
    return tile || (action.idx == i - 1);
  }).toList(growable: false);

  return new GameBoard(
    mines: board.mines,
    flagged: board.flagged,
    revealed: newRevealed,
  );
}

class MyApp extends StatelessWidget {
  final store = new Store<GameBoard>(
    gameBoardReducer,
    initialState: null,
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: 'Minesweeper',
        home: new MinesweeperConfigPage(),
      ),
    );
  }
}
