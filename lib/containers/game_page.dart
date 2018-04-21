import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:minesweeper/actions/actions.dart';
import 'package:minesweeper/containers/status_bar.dart';
import 'package:minesweeper/models/game_board.dart';
import 'package:minesweeper/presentation/tile_views.dart';
import 'package:redux/redux.dart';

typedef void OnRevealTileCallback(int idx);
typedef void OnFlagTileCallback(int idx);

class ViewModel {
  final GameBoard board;
  final OnRevealTileCallback onRevealTile;
  final OnFlagTileCallback onFlagTile;
  final OnNewGameCallback onNewGame;

  ViewModel({
    this.board,
    this.onRevealTile,
    this.onFlagTile,
    this.onNewGame,
  });
}

MaterialPageRoute getGamePageRoute() {
  return new MaterialPageRoute(
    builder: (context) {
      return new GamePage();
    },
  );
}

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<GameBoard, ViewModel>(
      converter: (Store<GameBoard> store) {
        return new ViewModel(
          board: store.state,
          onRevealTile: (idx) => store.dispatch(new RevealTileAction(idx)),
          onFlagTile: (idx) => store.dispatch(new FlagTileAction(idx)),
          onNewGame: () => store.dispatch(
                new InitializeBoardAction(
                  store.state.numRows,
                  store.state.numColumns,
                  store.state.numMines,
                  new DateTime.now(),
                ),
              ),
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
          body: Column(
            children: <Widget>[
              new StatusBar(
                startTime: board.createdAt,
                status: board.gameStatus,
                flagsRemaining: board.flagsRemaining,
                onNewGame: () => viewModel.onNewGame(),
              ),
              new Expanded(
                child: new GridView.count(
                  crossAxisCount: board.numColumns,
                  children: indices.map((index) {
                    bool hasMine = board.mines[index];
                    bool isFlagged = board.flagged[index];
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
              ),
            ],
          ),
        );
      },
    );
  }
}
