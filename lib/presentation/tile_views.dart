import 'package:flutter/material.dart';

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
