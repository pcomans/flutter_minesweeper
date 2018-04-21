import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:minesweeper/actions/actions.dart';
import 'package:minesweeper/containers/game_page.dart';
import 'package:minesweeper/models/game_board.dart';
import 'package:redux/redux.dart';

typedef OnInitCallback = Function(int numRows, int numCols, int numMines);

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() =>
      new _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  int _numRows;
  int _numCols;
  int _numMines;

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
              new DateTime.now(),
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
                new Row(
                  children: <Widget>[
                    new Text("Rows:"),
                    new Slider(
                      value: _numRows.toDouble(),
                      min: 3.0,
                      max: 25.0,
                      onChanged: (newVal) {
                        setState(() {
                          _numRows = newVal.floor();
                          _numMines = min(_numMines, _numCols * _numRows);
                        });
                      },
                    ),
                    new Text("$_numRows"),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Text("Columns:"),
                    new Slider(
                      value: _numCols.toDouble(),
                      min: 3.0,
                      max: 25.0,
                      onChanged: (newVal) {
                        setState(() {
                          _numCols = newVal.floor();
                          _numMines = min(_numMines, _numCols * _numRows);
                        });
                      },
                    ),
                    new Text("$_numCols"),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Text("Mines:"),
                    new Slider(
                      value: _numMines.toDouble(),
                      min: 1.0,
                      max: _numRows * _numCols * 1.0,
                      onChanged: (newVal) {
                        setState(() {
                          _numMines = newVal.floor();
                        });
                      },
                    ),
                    new Text("$_numMines"),
                  ],
                ),
                new RaisedButton(
                  child: new Text("Start Game"),
                  onPressed: () {
                    onInit(_numRows, _numCols, _numMines);
                    Navigator.of(context).push(getGamePageRoute());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _numRows = 12;
    _numCols = 9;
    _numMines = 16;
  }
}
