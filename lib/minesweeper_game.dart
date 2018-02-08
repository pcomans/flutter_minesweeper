import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'models/game_board.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

MaterialPageRoute getMinesweeperGameRoute() {
  return new MaterialPageRoute(
    builder: (context) {
      return new MinesweeperGame();
    },
  );
}

class MinesweeperGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<GameBoard>(
      builder: (BuildContext context, Store<GameBoard> store) {
        GameBoard board = store.state;

        List<int> indices =
            new List<int>.generate(board.mines.length, (int index) => index);

        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Minesweeper"),
          ),
          body: new GridView.count(
            crossAxisCount: board.numColumns,
            children: indices.map((index) {
              bool hasMine = board.mines[index];
              bool isFlagged = board.flagged[index];
              //Leave the board revealed for now
              bool isRevealed = true || board.revealed[index];
              int numAdjecentMines = board.adjacentMines[index];

              return isRevealed
                  ? new RevealedTileView(hasMine, numAdjecentMines)
                  : new HiddenTileView(isFlagged);
            }).toList(),
          ),
        );
      },
    );
  }
}

class HiddenTileView extends StatelessWidget {
  final bool isFlagged;

  HiddenTileView(this.isFlagged);

  @override
  build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.white30),
        color: Colors.grey[600],
      ),
      child: new Center(
        child: new Text(isFlagged ? "🚩" : ""),
      ),
    );
  }
}

class RevealedTileView extends StatelessWidget {
  final bool hasMine;
  final int numAdjecentMines;

  RevealedTileView(this.hasMine, this.numAdjecentMines);

  @override
  build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.white30),
        color: hasMine ? Colors.red : Colors.grey,
      ),
      child: new Center(
        child: new Text(hasMine ? "💣" : numAdjecentMines.toString()),
      ),
    );
  }
}
