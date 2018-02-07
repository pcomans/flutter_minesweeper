import 'package:flutter/material.dart';
import 'minesweeper_config_page.dart';
import 'models/game_board.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() => runApp(new MyApp());

class RevealTileAction {
  final int idx;

  RevealTileAction(this.idx);
}

final gameBoardReducer = combineTypedReducers<GameBoard>([
  new ReducerBinding<GameBoard, RevealTileAction>(_revealTile),
]);

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
    initialState: new GameBoard(
      mines: [],
      flagged: [],
      revealed: [],
    ),
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
