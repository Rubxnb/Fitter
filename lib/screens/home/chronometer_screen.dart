import 'package:fitter/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../widgets/widgets.dart';


class ChronometerScreen extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => ChronometerScreen(),
      ),
    );
  }

  @override
  _State createState() => _State();
}

class _State extends State<ChronometerScreen> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronómetro'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Icon(Icons.timer_outlined, size: 100, color: AppTheme.blue,),
              timer(stopWatchTimer: _stopWatchTimer, isHours: _isHours),
              Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ChronoButton(stopWatchTimer: _stopWatchTimer, stopWatchExecute: StopWatchExecute.reset, icon: Icons.restore,),
                          ChronoButton(stopWatchTimer: _stopWatchTimer, stopWatchExecute: StopWatchExecute.start, icon: Icons.play_arrow,),
                          ChronoButton(stopWatchTimer: _stopWatchTimer, stopWatchExecute: StopWatchExecute.stop, icon: Icons.stop,),

                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

    );
  }
}

class timer extends StatelessWidget {
  const timer({
    Key? key,
    required StopWatchTimer stopWatchTimer,
    required bool isHours,
  }) : _stopWatchTimer = stopWatchTimer, _isHours = isHours, super(key: key);

  final StopWatchTimer _stopWatchTimer;
  final bool _isHours;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: StreamBuilder<int>(
        stream: _stopWatchTimer.rawTime,
        initialData: _stopWatchTimer.rawTime.value,
        builder: (context, snap) {
          final value = snap.data!;
          final displayTime =
          StopWatchTimer.getDisplayTime(value, hours: _isHours);
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  displayTime,
                  style: const TextStyle(
                      fontSize: 50,
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.bold,
                      color: AppTheme.blue),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


