import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:minesweeper/containers/config_page.dart';
import 'package:minesweeper/models/game_board.dart';
import 'package:minesweeper/reducers/game_board_reducer.dart';
import 'package:redux/redux.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final store = new Store<GameBoard>(
    gameBoardReducer,
    initialState: null,
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new StoreProvider<GameBoard>(
      store: store,
      child: new MaterialApp(
        title: 'Minesweeper',
        home: new ConfigPage(),
      ),
    );
  }
}
