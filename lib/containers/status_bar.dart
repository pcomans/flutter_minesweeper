import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/models/game_board.dart';

class StatusBar extends StatelessWidget {
  final int flagsRemaining;
  final DateTime startTime;
  final GameStatus status;

  const StatusBar({
    Key key,
    @required this.status,
    @required this.flagsRemaining,
    @required this.startTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(flagsRemaining.toString()),
          new Text(status.toString()),
          new Text(startTime.toIso8601String()),
        ],
      ),
    );
  }
}

// class GameStatusIndicator extends StatelessWidget {
//   final GameStatus status;

//   const GameStatusIndicator({Key key, this.status}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String face = "";
//     switch (status) {
//       case GameStatus.ongoing:
//         face = "🙂";
//         break;
//       case GameStatus.won:
//         face = "😀";
//         break;
//       case GameStatus.lost:
//         face = "😵";
//         break;
//     }
//     return SizedBox(
//       width: 5.0,
//       child: new Text(status.toString()),
//     );
//   }
// }
