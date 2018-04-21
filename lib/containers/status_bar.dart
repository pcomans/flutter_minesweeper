import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/models/game_board.dart';

class StatusBar extends StatelessWidget {
  final int flagsRemaining;
  final DateTime startTime;
  final GameStatus status;
  final TextStyle statusTextStyle = const TextStyle(
    fontSize: 20.0,
  );

  static const double HEIGHT = 60.0;

  const StatusBar({
    Key key,
    @required this.status,
    @required this.flagsRemaining,
    @required this.startTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<Duration> counterStream =
        new Stream.periodic(new Duration(milliseconds: 200), (_) {
      return new DateTime.now().difference(startTime);
    });
    return SizedBox(
      height: HEIGHT,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.only(left: 10.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              flagsRemaining.toString(),
              style: statusTextStyle,
            ),
          ),
          new GameStatusIndicator(status: status),
          new Container(
            padding: const EdgeInsets.only(right: 10.0),
            alignment: Alignment.centerRight,
            child: new StreamBuilder<Duration>(
              stream: counterStream,
              builder: (context, snap) {
                if (snap.hasData) {
                  return new Text(
                    snap.data.toString().split(".").first,
                    style: statusTextStyle,
                  );
                }
                return new Text(
                  "--",
                  style: statusTextStyle,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GameStatusIndicator extends StatelessWidget {
  final GameStatus status;

  const GameStatusIndicator({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String face = "";
    switch (status) {
      case GameStatus.ongoing:
        face = "🙂";
        break;
      case GameStatus.won:
        face = "😀";
        break;
      case GameStatus.lost:
        face = "😵";
        break;
    }
    return SizedBox(
      width: 5.0,
      child: new Text(
        face,
        style: new TextStyle(fontSize: 32.0),
      ),
    );
  }
}
