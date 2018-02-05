import 'package:flutter/material.dart';
import 'minesweeper_game.dart';

class MinesweeperConfigPage extends StatefulWidget {
  @override
  _MinesweeperConfigPageState createState() =>
      new _MinesweeperConfigPageState();
}

class _MinesweeperConfigPageState extends State<MinesweeperConfigPage> {
  @override
  Widget build(BuildContext context) {
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
                Navigator.of(context).push(getMinesweeperGameRoute(12, 9, 16));
              },
            ),
          ],
        ),
      ),
    );
  }
}
