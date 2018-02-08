import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'models/game_board.dart';
import "main.dart";
import 'minesweeper_game.dart';

typedef OnInitCallback = Function(int numRows, int numCols, int numMines);

class MinesweeperConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<GameBoard, OnInitCallback>(
      converter: (Store<GameBoard> store) {
        return (numRows, numCols, numMines) {
          store.dispatch(
            new InitializeBoardAction(
              numRows,
              numCols,
              numMines,
            ),
          );
        };
      },
      builder: (BuildContext context, OnInitCallback onInit) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("New Game"),
          ),
          body: new Center(
            child: new Column(
              children: <Widget>[
                new Text("TODO Config goes here"),
                new RaisedButton(
                  child: new Text("Start Game"),
                  onPressed: () {
                    onInit(12, 9, 16);
                    Navigator.of(context).push(getMinesweeperGameRoute());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
