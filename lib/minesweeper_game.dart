import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'game_board.dart';

MaterialPageRoute getMinesweeperGameRoute(
  int numRows,
  int numColumns,
  int numMines,
) {
  return new MaterialPageRoute(
    builder: (context) {
      return new MinesweeperGame(
        columns: numColumns,
        rows: numRows,
        mines: numMines,
      );
    },
  );
}

class MinesweeperGame extends StatefulWidget {
  final int rows;
  final int columns;
  final int mines;

  MinesweeperGame({
    @required this.rows,
    @required this.columns,
    @required this.mines,
  });
  @override
  _MinesweeperGameState createState() => new _MinesweeperGameState();
}

class _MinesweeperGameState extends State<MinesweeperGame> {
  GameBoard _gameBoard;

  @override
  initState() {
    super.initState();
    _gameBoard = new GameBoard(widget.rows, widget.columns, widget.mines);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Minesweeper"),
      ),
      body: new GridView.count(
        crossAxisCount: widget.columns,
        children: _gameBoard.boardTiles.map((tile) {
          return new BoardTileView(tile);
        }).toList(),
      ),
    );
  }
}

class BoardTileView extends StatelessWidget {
  final GameTile tile;
  BoardTileView(this.tile);

  @override
  build(BuildContext context) {
    return new InkWell(
      onTap: _reveal,
      onLongPress: _flag,
      child: tile.isRevealed
          ? new RevealedTileView(tile)
          : new HiddenTileView(tile),
    );
  }

  void _flag() => tile.toggleFlagged();
  void _reveal() => tile.setRevealed();
}

class HiddenTileView extends StatelessWidget {
  final GameTile tile;

  HiddenTileView(this.tile);

  @override
  build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.white30),
        color: Colors.grey[600],
      ),
      child: new Center(
        child: new Text(tile.isFlagged ? "🚩" : ""),
      ),
    );
  }
}

class RevealedTileView extends StatelessWidget {
  final GameTile tile;

  RevealedTileView(this.tile);

  @override
  build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.white30),
        color: tile.hasMine ? Colors.red : Colors.grey,
      ),
      child: new Center(
        child: new Text(tile.hasMine ? "💣" : tile.numAdjecentMines.toString()),
      ),
    );
  }
}
