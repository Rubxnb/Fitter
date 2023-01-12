import 'package:fitter/helpers/helpers.dart';
import 'package:fitter/widgets/chorno_button.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../theme/app_theme.dart';

class ChronometerExerciseScreen extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => ChronometerExerciseScreen(nombreEj: '', imageEj: '', time: '0',),
      ),
    );
  }

  @override

  final String nombreEj;
  final String imageEj;
  final String time;

  const ChronometerExerciseScreen({Key? key, required this.nombreEj, required this.imageEj, required this.time, }) : super(key: key);

  _State createState() => _State();
}

class _State extends State<ChronometerExerciseScreen> {
  final _isHours = false;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(0),
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onEnded: () {
      print('onEnded');
    },
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

    _stopWatchTimer.setPresetMinuteTime(getMinutes(widget.time));
    _stopWatchTimer.setPresetSecondTime(getSeconds(widget.time));
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(widget.nombreEj,style: TextStyle(fontSize: 30,color: AppTheme.blue, fontWeight: FontWeight.bold),),
            Image(image: AssetImage(widget.imageEj)),
            SizedBox(height: 10,),
            /// Display stop watch time
            Padding(
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
                              fontSize: 40,
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.bold,
                              color: AppTheme.blue),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
            /// Button
            Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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