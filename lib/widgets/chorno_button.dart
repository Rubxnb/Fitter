import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ChronoButton extends StatelessWidget {
  const ChronoButton({
    Key? key,
    required StopWatchTimer stopWatchTimer, required this.stopWatchExecute, required this.icon,
  }) : _stopWatchTimer = stopWatchTimer, super(key: key);

  final IconData icon;
  final StopWatchExecute stopWatchExecute;
  final StopWatchTimer _stopWatchTimer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: RaisedButton(
        padding: const EdgeInsets.all(4),
        color: Colors.lightBlue,
        shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(360 )
        ),
        onPressed: () async {
          _stopWatchTimer.onExecute
              .add(stopWatchExecute);
        },
        child: Icon(icon),
      ),
    );
  }
}