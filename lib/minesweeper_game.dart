import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'models/game_board.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import "main.dart";

typedef void OnRevealTileCallback(int idx);
typedef void OnFlagTileCallback(int idx);

class ViewModel {
  final GameBoard board;
  final OnRevealTileCallback onRevealTile;
  final OnFlagTileCallback onFlagTile;

  ViewModel({this.board, this.onRevealTile, this.onFlagTile});
}

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
    return new StoreConnector<GameBoard, ViewModel>(
      converter: (Store<GameBoard> store) {
        return new ViewModel(
          board: store.state,
          onRevealTile: (idx) => store.dispatch(new RevealTileAction(idx)),
          onFlagTile: (idx) => store.dispatch(new FlagTileAction(idx)),
        );
      },
      builder: (BuildContext context, ViewModel viewModel) {
        GameBoard board = viewModel.board;

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
              bool isRevealed = board.revealed[index];
              int numAdjacentMines = board.adjacentMines[index];

              return isRevealed
                  ? new RevealedTileView(hasMine, numAdjacentMines)
                  : new HiddenTileView(
                      isFlagged,
                      () => viewModel.onRevealTile(index),
                      () => viewModel.onFlagTile(index),
                    );
            }).toList(),
          ),
        );
      },
    );
  }
}

class HiddenTileView extends StatelessWidget {
  final bool isFlagged;
  final VoidCallback onReveal;
  final VoidCallback onFlag;

  HiddenTileView(this.isFlagged, this.onReveal, this.onFlag);

  @override
  build(BuildContext context) {
    return new Material(
      color: Colors.grey[600],
      child: new InkWell(
        onTap: onReveal,
        onLongPress: onFlag,
        child: new Container(
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.white30),
          ),
          child: new Center(
            child: new Text(isFlagged ? "🚩" : ""),
          ),
        ),
      ),
    );
  }
}

class RevealedTileView extends StatelessWidget {
  final bool hasMine;
  final int numAdjacentMines;

  RevealedTileView(this.hasMine, this.numAdjacentMines);

  @override
  build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.white30),
        color: hasMine ? Colors.red : Colors.grey,
      ),
      child: new Center(
        child: new Text(hasMine ? "💣" : numAdjacentMines.toString()),
      ),
    );
  }
}
