import 'package:flutter/material.dart';
import 'minesweeper_config_page.dart';
import 'models/game_board.dart';
import 'package:redux/redux.dart';
import 'models/game_tile.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => runApp(new MyApp());

class RevealTileAction {
  final int idx;

  RevealTileAction(this.idx);
}

final gameBoardReducer = combineTypedReducers<GameBoard>([
  new ReducerBinding<GameBoard, RevealTileAction>(_revealTile),
]);

GameBoard _revealTile(GameBoard board, RevealTileAction action) {
  List<GameTile> newTiles = board.boardTiles.map((tile) {
    GameTile newTile = new GameTile(tile.index);
    newTile.numAdjecentMines = tile.numAdjecentMines;
    newTile.hasMine = tile.hasMine;
    newTile.flagged = tile.flagged;
    newTile.isRevealed = (tile.index == action.idx) ? true : tile.isRevealed;
    return newTile;
  }).toList(growable: false);

  return new GameBoard.withTiles(
    board.numRows,
    board.numColumns,
    board.numMines,
    newTiles,
  );
}

class MyApp extends StatelessWidget {
  final store = new Store<GameBoard>(
    gameBoardReducer,
    initialState: new GameBoard(8, 8, 8),
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
