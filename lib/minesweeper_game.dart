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
      onTap: _flag,
      onLongPress: _reveal,
      child: new BoardTileViewView(tile),
    );
  }

  void _flag() {
    tile.toggleFlagged();
  }

  void _reveal() {}
}

class BoardTileViewView extends StatelessWidget {
  final GameTile tile;

  BoardTileViewView(this.tile);

  @override
  build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.white30),
        color: tile.getMine ? Colors.red : Colors.grey,
      ),
      child: new Center(
        child: new Stack(
          children: <Widget>[
            new Text(tile.flagged ? "🚩" : ""),
            new Text("${tile.numAdjecentMines}")
          ],
        ),
      ),
    );
  }
}
